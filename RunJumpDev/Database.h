//
//  Database.h
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic) sqlite3 * database;
-(BOOL) saveDataWithFirstName:(NSString*) firstName
                     lastName:(NSString*) lastName
                        email:(NSString*) email
                     homeCity:(NSString*) homeCity
                        state:(NSString*) state
                 otherPurpose:(NSString*) otherPurpose
                  gameChoices:(NSMutableArray *) gameChoices
                bFutureNotify:(int)bFutureNotify
                    bCheckAll:(int)bCheckAll;

-(BOOL)openDB;
@end
