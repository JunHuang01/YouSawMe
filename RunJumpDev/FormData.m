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
    NSLog(@"FirstName: %@, LastName: %@, Email: %@, HomeCity: %@, State: %@, otherPurpose: %@ ",_firstName,_lastName, _Email, _homeCity,_state,_otherPurpose);
    
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

-(NSString*)homeCity{
    if(!_homeCity)
        _homeCity = @"";
    
    return _homeCity;
}

-(NSString *)state{
    if(!_state)
        _state = @"AL";
    
    return _state;
}

-(NSString *)otherPurpose{
    if(!_otherPurpose){
        _otherPurpose = @"";
    }
    
    return _otherPurpose;
}


-(NSArray *)gameSelection{
    if (!_gameSelection) {
        BOOL bFalse = NO;
        NSNumber * defaultNum = [NSNumber numberWithBool:bFalse];
        _gameSelection = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum,defaultNum, nil]];
    }
    
    return _gameSelection;
}

-(void)setGameSelection:(BOOL)value withObjectIndexAt:(NSInteger) index{
    NSNumber * NumData = [NSNumber numberWithBool:value];
    [_gameSelection replaceObjectAtIndex:index withObject:NumData];
}

-(BOOL)SaveToDB{
    _database = [[Database alloc] init];
    return [_database saveDataWithFirstName:_firstName lastName:_lastName email:_Email homeCity:_homeCity state:_state otherPurpose:_otherPurpose gameChoices:_gameSelection];
}


@end
