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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    sleep(3);
    [self performSegueWithIdentifier:@"FinalToFirstPageSegue" sender:self];
}
@end
