//
//  Database.m
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "Database.h"

@implementation Database

-(id)init{
    self = [super init];
    if(!self){
        
        self = [[Database alloc] init];
        
    }
    _filePath = [[NSString alloc] initWithFormat:@"YouSawMe.sqlite" ];
    [self openDB];
    
    return self;
}

-(NSString*)filePath{
    if(!_filePath)
    {
        _filePath = [[NSString alloc] initWithFormat:@"YouSawMe.sqlite" ];
    }
    
    return _filePath;
}

-(NSString*)csvFilePath{
    if(!_csvFilePath)
    {
        _csvFilePath = [[NSString alloc] initWithFormat:@"YouSawMe.csv" ];
    }
    
    return _csvFilePath;
}

-(BOOL)openDB{
    _filePath = [self dataFilePath];
    if (sqlite3_open([_filePath UTF8String], &_database) != SQLITE_OK){
        sqlite3_close(_database);
        NSAssert(0, @"open database failed");
        NSLog(@"Failed to create database");
        return NO;
    }
    
    [self CreateTable];
    return YES;
}

-(NSString *)dataFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    NSString* document = [path objectAtIndex:0];
    
    return [document stringByAppendingString:_filePath];
}

-(NSString *)dataCSVFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    NSString* document = [path objectAtIndex:0];
    
    return [document stringByAppendingString:@"YouSawMe.csv"];
}

-(BOOL) CreateTable{
    NSString *ceateSQL = @"CREATE TABLE IF NOT EXISTS YouSawMe(ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME TEXT, LASTNAME TEXT, EMAIl TEXT, HOMECITY TEXT,STATE TEXT,OTHERPURPOSE TEXT, GAME1 INTERGER,GAME2 INTERGER,GAME3 INTERGER,GAME4 INTERGER,GAME5 INTERGER,GAME6 INTERGER,GAME7 INTERGER,GAME8 INTERGER)";
    
    char *ERROR;
    
    if (sqlite3_exec(_database, [ceateSQL UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
        sqlite3_close(_database);
        NSAssert(0, @"ceate table failed!");
        NSLog(@"create table failed");
        return NO;
    }
    return YES;
}

-(BOOL) saveDataWithFirstName:(NSString*) firstName
                     lastName:(NSString*) lastName
                        email:(NSString*) email
                     homeCity:(NSString*) homeCity
                        state:(NSString*) state
                 otherPurpose:(NSString*) otherPurpose
                  gameChoices:(NSMutableArray *) gameChoices
{
    if (sqlite3_open([_filePath UTF8String],&_database) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"insert into YouSawMe(FIRSTNAME,LASTNAME,EMAIL,HOMECITY,STATE,OTHERPURPOSE,GAME1,GAME2,GAME3,GAME4,GAME5,GAME6,GAME7,GAME8) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\")",
                               firstName,
                               lastName,
                               email,
                               homeCity,
                               state,
                               otherPurpose,
                               [self getIntVal:gameChoices[0]],
                               [self getIntVal:gameChoices[1]],
                               [self getIntVal:gameChoices[2]],
                               [self getIntVal:gameChoices[3]],
                               [self getIntVal:gameChoices[4]],
                               [self getIntVal:gameChoices[5]],
                               [self getIntVal:gameChoices[6]],
                               [self getIntVal:gameChoices[7]]
                               ];
        /*NSString* insertSQL = [NSString stringWithFormat:@"insert into RunJumpDev(FIRSTNAME) values (\"jun\")"];*/
        sqlite3_stmt* statement = nil;
        const char* insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_database,insert_stmt,-1,&statement,NULL);
        
        if(sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Successfully saved data to DB");
            return YES;
        }
        else{
            return NO;
        }
        
        sqlite3_reset(statement);
    }
    return NO;
}

-(int)getIntVal:(NSNumber* )value{
    int result = [value intValue];
    return result;
}

-(void)DumpDBtoCSV{
    NSString *csv = [[NSString alloc] init];
    //Create CSV header
    csv = [csv stringByAppendingString:@"First Name,Last Name,Email,homecity,state,Other Purpose,Walking,Running,Bicycling,Motorcycling,Concerts,Partying,Work Safety, Other \n"];
  
    
    if (sqlite3_open([_filePath UTF8String],&_database) == SQLITE_OK){ {
        const char *sqlStatement = [[NSString stringWithFormat:@"SELECT * FROM YouSawMe"] UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(_database,sqlStatement,-1,&compiledStatement,NULL) == SQLITE_OK) {
            
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                //this assumes that there are two rows in your database you want to get data from
                
                NSString* FirstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString* LastName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString* Email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString* homeCity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString* state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSString* otherPurpose = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                NSNumber* game1 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] intValue]];
                NSNumber* game2 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] intValue]];
                NSNumber* game3 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] intValue]];
                NSNumber* game4 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] intValue]];
                NSNumber* game5 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] intValue]];
                NSNumber* game6 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] intValue]];
                NSNumber* game7 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)] intValue]];
                NSNumber* game8 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] intValue]];
                csv = [csv stringByAppendingFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                 FirstName,
                 LastName,
                 Email,
                 homeCity,
                 state,
                 otherPurpose,
                 game1,
                 game2,
                 game3,
                 game4,
                 game5,
                 game6,
                 game7,
                 game8
                 ];
            }
            
            sqlite3_finalize(compiledStatement);
        }else{
            NSLog(@"database error");
        }
    }
    
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[self dataCSVFilePath] error:&error];

    [csv writeToFile: [self dataCSVFilePath]
          atomically:YES encoding:NSUTF8StringEncoding error:&error];

    }
}
@end
