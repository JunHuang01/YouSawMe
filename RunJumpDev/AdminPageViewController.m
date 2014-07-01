//
//  AdminPageViewController.m
//  RunJumpDev
//
//  Created by Jun Huang on 4/5/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "AdminPageViewController.h"


@interface AdminPageViewController ()

@end

@implementation AdminPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.backButton.layer.cornerRadius = 10;
    self.backButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.backButton.layer.borderWidth = 2.0f;
    
    
}

-(Database *)mydatabase{
    if(!_mydatabase){
        _mydatabase = [[Database alloc] init];
        [_mydatabase openDB];
        self.databasePath = _mydatabase.filePath;
    }
    
    return _mydatabase;
}

-(NSString *)databasePath{
    if(!_databasePath)
    {
        _databasePath = _mydatabase.filePath;
    }
    
    return _databasePath;
}
- (IBAction)export:(id)sender {
    
    [self performSelectorInBackground:@selector(exportImpl) withObject:nil];
}

-(void) exportImpl
{
    /*
    NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSSystemDomainMask, YES);
    NSString* documentsDir = [documentPaths objectAtIndex:0];
    NSString* csvPath = [documentsDir stringByAppendingPathComponent: @"export.csv"];
    
    // TODO: mutex lock?
    [self exportCsv: csvPath];
     */
    
    // mail is graphical and must be run on UI thread
    [self performSelectorOnMainThread: @selector(mail:) withObject: self.databasePath waitUntilDone: NO];
}

- (void) mail: (NSString*) filePath
{
    // here I stop animating the UIActivityIndicator
    
    // http://howtomakeiphoneapps.com/home/2009/7/14/how-to-make-your-iphone-app-send-email-with-attachments.html
    BOOL success = NO;
    if ([MFMailComposeViewController canSendMail]) {
        // TODO: autorelease pool needed ?
        
        _mydatabase = [[Database alloc] init];
        [_mydatabase DumpDBtoCSV];
        _databasePath = [_mydatabase dataCSVFilePath];
        filePath = _databasePath;
        NSData* database = [NSData dataWithContentsOfFile: filePath];
        
        if (database != nil) {
            MFMailComposeViewController* picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:[NSString stringWithFormat: @"%@ %@", [[UIDevice currentDevice] model], [filePath lastPathComponent]]];
            
            NSString* filename = [filePath lastPathComponent];
            [picker addAttachmentData: database mimeType:@"application/octet-stream" fileName: filename];
            NSString* emailBody = @"Attached is the SQLite data from my iOS device.";
            [picker setMessageBody:emailBody isHTML:YES];
            
            [self presentViewController:picker animated:YES completion:NULL];
            success = YES;
        }
    }
    
    if (!success) {
        UIAlertView* warning = [[UIAlertView alloc] initWithTitle: @"Error"
                                                          message: @"Unable to send attachment!"
                                                         delegate: self
                                                cancelButtonTitle: @"Ok"
                                                otherButtonTitles: nil];
        [warning show];
    }
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) exportCsv: (NSString*) filename
{
    // We record this filename, because the app deletes it on exit
    self.tempFile = filename;
    
    // Setup the database object
    sqlite3* database;
    
    // Open the database from the users filessytem
    if (sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK)
    {
        [self createTempFile: filename];
        NSOutputStream* output = [[NSOutputStream alloc] initToFileAtPath: filename append: YES];
        [output open];
        if (![output hasSpaceAvailable]) {
            NSLog(@"No space available in %@", filename);
            // TODO: UIAlertView?
        } else {
            NSString* header = @"Source,Time,Latitude,Longitude,Accuracy\n";
            NSInteger result = [output write:(const uint8_t *) [header UTF8String] maxLength: [header length]];
            if (result <= 0) {
                NSLog(@"exportCsv encountered error=%ld from header write", (long)result);
            }
            /*
            BOOL errorLogged = NO;
            NSString* sqlStatement = @"select timestamp,latitude,longitude,horizontalAccuracy from my_sqlite_table";
            
            // Setup the SQL Statement and compile it for faster access
            sqlite3_stmt* compiledStatement;
            if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                // Loop through the results and write them to the CSV file
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Read the data from the result row
                    NSInteger secondsSinceReferenceDate = (NSInteger)sqlite3_column_double(compiledStatement, 0);
                    float lat = (float)sqlite3_column_double(compiledStatement, 1);
                    float lon = (float)sqlite3_column_double(compiledStatement, 2);
                    float accuracy = (float)sqlite3_column_double(compiledStatement, 3);
                    
                    if (lat != 0 && lon != 0) {
                        NSDate* timestamp = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: secondsSinceReferenceDate];
                        NSString* line = [[NSString alloc] initWithFormat: @"%@,%@,%f,%f,%d\n",
                                          table, [dateFormatter stringFromDate: timestamp], lat, lon, (NSInteger)accuracy];
                        result = [output write: [line UTF8String] maxLength: [line length]];
                        if (!errorLogged && (result <= 0)) {
                            NSLog(@"exportCsv write returned %ld", (long)result);
                            errorLogged = YES;
                        }
                    }
                    // Release the compiled statement from memory
                    sqlite3_finalize(compiledStatement);
                }
            }*/
            NSString* testingData = [[NSString alloc] initWithFormat:@"testing File"];
            [output write:(const uint8_t *)[testingData UTF8String] maxLength:sizeof(testingData)];
        }
        [output close];
    }
    
    sqlite3_close(database);
}

-(void) createTempFile: (NSString*) filename {
    NSFileManager* fileSystem = [NSFileManager defaultManager];
    [fileSystem removeItemAtPath: filename error: nil];
    
    NSMutableDictionary* attributes = [[NSMutableDictionary alloc] init];
    NSNumber* permission = [NSNumber numberWithLong: 0640];
    [attributes setObject: permission forKey: NSFilePosixPermissions];
    if (![fileSystem createFileAtPath: filename contents: nil attributes: attributes]) {
        NSLog(@"Unable to create temp file for exporting CSV.");
        // TODO: UIAlertView?
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
