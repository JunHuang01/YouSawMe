//
//  ThirdPageViewController.m
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "ThirdPageViewController.h"

@interface ThirdPageViewController ()

@end

@implementation ThirdPageViewController

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
    
    _CommentBox = [[CommentBox alloc] initWithFrame:CGRectMake(200, 180, 600, 200)];
    [self.view addSubview:_CommentBox];
    [_CommentBox setText: [_currForm Comments]];
    [_CommentBox becomeFirstResponder];
    _CommentBox.layer.borderColor = [UIColor redColor].CGColor;
    _CommentBox.layer.borderWidth = 2.0;
    _CommentBox.layer.cornerRadius = 5;
    _CommentBox.text = [_currForm Comments];
    _CommentBox.returnKeyType = UIReturnKeyDefault;
    _CommentBox.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _CommentBox.autocorrectionType = UITextAutocorrectionTypeYes;
    
    self.SubmitButton.layer.cornerRadius = 10;
    self.SubmitButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.SubmitButton.layer.borderWidth = 2.0f;
    
    self.PreviousPageButton.layer.cornerRadius = 10;
    self.PreviousPageButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.PreviousPageButton.layer.borderWidth = 2.0f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(CommentBox*)theTextView{
    [self CacheData];
    if(theTextView == self.CommentBox){
        [self submitDataToDB];
    }
        
    return YES;
}
- (IBAction)Back:(id)sender {
    [self CacheData];
}

- (IBAction)Finish:(id)sender {
    [self CacheData];
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


-(void)CacheData{
    [self.CommentBox resignFirstResponder];
    [_currForm setComments:self.CommentBox.text];
}

- (IBAction)SubmitData:(id)sender {
    [self submitDataToDB];
}

@end
