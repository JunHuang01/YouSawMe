//
//  SecondPageViewController.m
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "SecondPageViewController.h"

@interface SecondPageViewController ()

@end

@implementation SecondPageViewController


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
    _currForm = [[FormData alloc] init];
    _currForm = [_currForm currFormData];
    
    [_checkAllGameBox setSelected: [_currForm bCheckAll]];
    for ( int i = 0; i < [_gameCheckedList count]; ++i){
        BOOL bSel = [[[_currForm gameSelection] objectAtIndex:i] boolValue];
        [[_gameCheckedList objectAtIndex:i] setSelected:bSel];
    }
    
    BOOL bFutureNotify = [_currForm bNotifyFutureGame];
    [_bNotifyFutureGame setSelected:bFutureNotify];
    
    /*
    if([_checkAllGameBox isSelected])
        [_checkAllGameBox setBackgroundColor:[UIColor redColor]];
    else
        [_checkAllGameBox setBackgroundColor:[UIColor greenColor]];
     */
    
    self.NextPageButton.layer.cornerRadius = 10;
    self.NextPageButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.NextPageButton.layer.borderWidth = 2.0f;
    
    self.PreviousPageButton.layer.cornerRadius = 10;
    self.PreviousPageButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.PreviousPageButton.layer.borderWidth = 2.0f;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (IBAction)onCheckFutureNotification:(id)sender {
    BOOL bSel = [_bNotifyFutureGame isSelected];
    bSel = !bSel;
    
    [_currForm setBNotifyFutureGame:bSel];
    [_bNotifyFutureGame setSelected:bSel];
}*/

- (IBAction)onCheckedAllGameBox:(id)sender {
    NSLog(@"touched!");
    BOOL bCheckALL = [_checkAllGameBox isSelected];
    if((UIButton *)sender == _checkAllGameBox){
        bCheckALL = !bCheckALL;
        [_currForm setBCheckAll:bCheckALL];
        [_checkAllGameBox setSelected:bCheckALL];
        if (bCheckALL){
            //[_checkAllGameBox setBackgroundColor:[UIColor redColor]];
            for ( int i = 0 ; i < [_gameCheckedList count]; ++i){
                [[_gameCheckedList objectAtIndex:i] setSelected:YES];
                [_currForm setGameSelection:YES withObjectIndexAt:i];
            }
        }
        else{
            //[_checkAllGameBox setBackgroundColor:[UIColor greenColor]];
            for ( int i = 0 ; i < [_gameCheckedList count]; ++i){
                [[_gameCheckedList objectAtIndex:i] setSelected:NO];
                [_currForm setGameSelection:NO withObjectIndexAt:i];
            }
        }
    }
    
    for ( int i = 0 ; i < [_gameCheckedList count]; ++i){
        if ( (UIButton *)sender == [_gameCheckedList objectAtIndex:i]){
            UIButton* currButton = [_gameCheckedList objectAtIndex:i];
            BOOL bIsSelected = ![currButton isSelected];
            if(!bIsSelected){
                [_checkAllGameBox setSelected:NO];
                [_currForm setBCheckAll:NO];
            }
            [currButton setSelected:bIsSelected];
            [_currForm setGameSelection:bIsSelected withObjectIndexAt:i];
            break;
        }
    }
    
    [_currForm LogCurrData];
}

@end
