//
//  FirstPageViewController.m
//  RunJumpDev
//
//  Created by Jun Huang on 3/28/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "FirstPageViewController.h"
#import "SecondPageViewController.h"

@interface FirstPageViewController ()

@end

@implementation FirstPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.FirstNameField becomeFirstResponder];
    _currForm = [[FormData alloc] init];
    _currForm = [_currForm currFormData];
    
    self.FirstNameField.text = [_currForm firstName];
    self.LastNameField.text = [_currForm lastName];
    self.EmailField.text = [_currForm Email];
    self.HomeCity.text = [_currForm homeCity];
    [self.StatePicker setTitle:[_currForm state] forState:UIControlStateNormal];
    
    
    self.NextPageButton.layer.cornerRadius = 10;
    self.NextPageButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.NextPageButton.layer.borderWidth = 2.0f;
    
    [self.EmailAlert setHidden:YES];
    
    
}

/*-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    NSLog(@"return called");
    if ( theTextField == self.FirstNameField){
        [theTextField resignFirstResponder];
        [self.LastNameField becomeFirstResponder];
        
        //NSLog(@"First name out Last Name in");
        //NSLog(@"%@", theTextField.text);
    }
    else if (theTextField == self.LastNameField){
        [theTextField resignFirstResponder];
        [self.EmailField becomeFirstResponder];
        
        //NSLog(@"Last name out Email in");
        //NSLog(@"%@", theTextField.text);
    }
    else if (theTextField == self.EmailField){
        [theTextField resignFirstResponder];
        [self.HomeCity becomeFirstResponder];
        
        //NSLog(@"Email in");
        //NSLog(@"%@", theTextField.text);
        
    }
    else if (theTextField == self.HomeCity){
        [theTextField resignFirstResponder]; //ToDo, change it to check for all input and go to next page;
        [self onNextPage:self];
    }
    //[self cacheData];
    return YES;
}
- (IBAction)onNextPage:(id)sender {
    [self cacheData];
    if ([self checkEmail])
    {
        if([self isAdminUser]){
            [_currForm getNewForm];
            [self performSegueWithIdentifier:@"AdminSegue" sender:self];
        }
        else
            [self performSegueWithIdentifier:@"FirstToSecondSegue" sender:self];
    }
    else{
        [self.EmailAlert setHidden:NO];
        [self.EmailField becomeFirstResponder];
        [self.EmailField selectAll:self];
    }
}

- (BOOL)isAdminUser{
    if ([self.FirstNameField.text isEqual: @"Admin"] &&
        [self.LastNameField.text isEqual: @"Admin"] &&(
        [self.EmailField.text  isEqual: @"Admin"] || [self.EmailField.text isEqual:@"admin"]))
        return YES;
    else
        return NO;
}
- (void)cacheData{
    [_currForm setFirstName:self.FirstNameField.text];
    [_currForm setLastName:self.LastNameField.text];
    [_currForm setEmail:self.EmailField.text];
    [_currForm setHomeCity:self.HomeCity.text];
    [_currForm LogCurrData];
}

-(BOOL)checkEmail{
    int iAtCount = 0;
    int iDotCountAfterAt = 0;
    NSString* t_Email = self.EmailField.text;
    int iLen = t_Email.length;
    
    if (iLen <4)
        return false;

    for(int i = 0 ; i < iLen; i++){
        NSString* currChar = [t_Email substringWithRange:NSMakeRange(i ,1)];
        if ([currChar isEqualToString:@"@"]) {
            iAtCount++;
        }
        if(iAtCount>1)
            return false;
        if( [currChar isEqualToString:@"."] && iAtCount==1){
            iDotCountAfterAt++;
        }
        if(iDotCountAfterAt > 1)
            return false;
        if([currChar isEqualToString:@" "])
            return false;
    }
    
    if(iAtCount!=1)
        return false;
    
    return true;
}

@end
