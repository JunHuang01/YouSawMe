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

-(BOOL) CreateTable{
    NSString *ceateSQL = @"CREATE TABLE IF NOT EXISTS YouSawMe(ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME TEXT, LASTNAME TEXT, EMAIl TEXT, HOMECITY TEXT,STATE TEXT,OTHERPURPOSE TEXT, GAME1 INTERGER,GAME2 INTERGER,GAME3 INTERGER,GAME4 INTERGER,GAME5 INTERGER,GAME6 INTERGER,GAME7 INTERGER,GAME8 INTERGER,GAME9 INTERGER,NOTIFYFUTURE INTERGER, CHECKALL INTERGER )";
    
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
                bFutureNotify:(int )bFutureNotify
                    bCheckAll:(int )bCheckAll
{
    if (sqlite3_open([_filePath UTF8String],&_database) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"insert into YouSawMe(FIRSTNAME,LASTNAME,EMAIL,HOMECITY,STATE,OTHERPURPOSE,GAME1,GAME2,GAME3,GAME4,GAME5,GAME6,GAME7,GAME8,GAME9,NOTIFYFUTURE,CHECKALL) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\")",
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
                               [self getIntVal:gameChoices[7]],
                               [self getIntVal:gameChoices[8]],
                               bFutureNotify,
                               bCheckAll];
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

@end
