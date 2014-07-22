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

-(BOOL)bDumpALL{
    if(!_bDumpALL)
        _bDumpALL = YES;
    return _bDumpALL;
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
- (IBAction)exportNEWOnly:(id)sender {
    
    _mydatabase = [[Database alloc] init];
    _bDumpALL = NO;
    
    [self performSelectorInBackground:@selector(exportImpl) withObject:nil];
}

- (IBAction)exportALL:(id)sender {
    
    _mydatabase = [[Database alloc] init];
    _bDumpALL = YES;
    
    [self performSelectorInBackground:@selector(exportImpl) withObject:nil];
}

-(void) exportImpl
{
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
        [_mydatabase DumpDBtoCSV:_bDumpALL];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
