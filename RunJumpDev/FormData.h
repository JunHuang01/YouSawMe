//
//  FormData.h
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"

@interface FormData : NSObject
@property (nonatomic,strong) NSString * firstName;
@property (nonatomic,strong) NSString * lastName;
@property (nonatomic,strong) NSString * Email;
@property (nonatomic,strong) NSString * Comments;
@property (nonatomic) BOOL bCheckAll;
@property (nonatomic) BOOL bNotifyFutureGame;

@property (nonatomic,readwrite) NSMutableArray *gameSelection;

@property (nonatomic, strong) Database * database;

-(FormData *)currFormData;
-(void)LogCurrData;
-(void)setGameSelection:(BOOL)value withObjectIndexAt:(NSInteger) index;
-(BOOL)SaveToDB;
-(void)getNewForm;
@end
