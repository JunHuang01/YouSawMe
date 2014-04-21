//
//  FormData.m
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "FormData.h"

static FormData * single = nil;

@implementation FormData

-(FormData *)currFormData{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!single)
            single = [[FormData alloc] init];
    });
    
    return single;
}

-(void)getNewForm{
    single = [[FormData alloc] init];
}

-(id)init{
    self = [super init];
    if (!self){
        self = [[FormData alloc]init];
    }
    return self;
}

-(void)LogCurrData{
    NSLog(@"FirstName: %@, LastName: %@, Email: %@, Comments: %@ ",_firstName,_lastName, _Email, _Comments);
    
    for (int i = 0; i < [_gameSelection count]; ++i){
        NSLog(@"The game at index %d is set to %i",i,[[_gameSelection objectAtIndex:i] intValue]);
    }
}

-(Database *)database{
    if(!_database)
        _database = [[Database alloc] init];
    
    return _database;
}
-(NSString*)firstName{
    if(!_firstName)
        _firstName = @"";
    
    return _firstName;
}

-(NSString*)lastName{
    if(!_lastName)
        _lastName = @"";
    
    return _lastName;
}

-(NSString *)Email{
    if(!_Email)
        _Email = @"";
    
    return _Email;
}

-(NSString *)Comments{
    if(!_Comments)
        _Comments = @"";
    
    return _Comments;
}

-(NSArray *)gameSelection{
    if (!_gameSelection) {
        BOOL bFalse = NO;
        NSNumber * defaultNum = [NSNumber numberWithBool:bFalse];
        _gameSelection = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum, nil]];
    }
    
    return _gameSelection;
}

-(void)setGameSelection:(BOOL)value withObjectIndexAt:(NSInteger) index{
    NSNumber * NumData = [NSNumber numberWithBool:value];
    [_gameSelection replaceObjectAtIndex:index withObject:NumData];
}

-(BOOL)SaveToDB{
    
    int bNotifyFuture = [[NSNumber numberWithBool:_bNotifyFutureGame] intValue];
    int bCheck = [[NSNumber numberWithBool:_bCheckAll] intValue];
    _database = [[Database alloc] init];
    return [_database saveDataWithFirstName:_firstName lastName:_lastName email:_Email comments:_Comments gameChoices:_gameSelection bFutureNotify:bNotifyFuture bCheckAll:bCheck];
}


@end
