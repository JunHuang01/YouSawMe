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
    

    for ( int i = 0; i < [_gameCheckedList count]; ++i){
        BOOL bSel = [[[_currForm gameSelection] objectAtIndex:i] boolValue];
        [[_gameCheckedList objectAtIndex:i] setSelected:bSel];
    }
    
    self.otherPurpose.text = [_currForm otherPurpose];
    
    
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


- (IBAction)onCheckedAllGameBox:(id)sender {
    NSLog(@"touched!");
    BOOL bCheckALL = [_checkAllGameBox isSelected];
    if((UIButton *)sender == _checkAllGameBox){
        bCheckALL = !bCheckALL;
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
            }
            [currButton setSelected:bIsSelected];
            [_currForm setGameSelection:bIsSelected withObjectIndexAt:i];
            break;
        }
    }
    
    [_currForm LogCurrData];
}


- (IBAction)SubmitData:(id)sender {
    [self cacheData];
    [self submitDataToDB];
}

- (void) submitDataToDB{
    if ([_currForm SaveToDB])
    {
        [_currForm getNewForm];
        NSLog(@"Submited data");
    }
    else{
        NSLog(@"Submited data failed");
    }
}

- (void)cacheData{
    [_currForm setOtherPurpose:self.otherPurpose.text];
    [_currForm LogCurrData];
}


- (IBAction)onNextPage:(id)sender {
    [self cacheData];

    [self performSegueWithIdentifier:@"SecondToFirstSegue" sender:self];
}




@end
