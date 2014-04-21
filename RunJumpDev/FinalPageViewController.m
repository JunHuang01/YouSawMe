//
//  FinalPageViewController.m
//  RunJumpDev
//
//  Created by Jun Huang on 4/5/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "FinalPageViewController.h"

@interface FinalPageViewController ()

@end

@implementation FinalPageViewController

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
    self.NextPageButton.layer.cornerRadius = 10;
    self.NextPageButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.NextPageButton.layer.borderWidth = 2.0f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
