//
//  StatePickerViewController.m
//  RunJumpDev
//
//  Created by Jun Huang on 7/1/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import "StatePickerViewController.h"

@interface StatePickerViewController ()

@end

@implementation StatePickerViewController

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
    

    self.DoneButton.layer.cornerRadius = 10;
    self.DoneButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f].CGColor;
    self.DoneButton.layer.borderWidth = 2.0f;
    
    self.listOfStates = [[NSArray alloc] initWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DC",@"DE",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN"
                         ,@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY", nil];
    [self setDefaultRow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DoneSelecting:(id)sender {
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.listOfStates count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [[self listOfStates] objectAtIndex:row];
}

-(void)setDefaultRow{
    int iSetRow =  0;
    int iLen = [self.listOfStates count];
    
    for ( int i = 0; i < iLen; ++i ){
        NSString * currState = [self.listOfStates objectAtIndex:i];
        if ( [currState isEqualToString:[_currForm state]] ){
            iSetRow = i;
            break;
        }
        
    }
    
    [_StatePicker selectRow:iSetRow inComponent:0 animated:NO];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSLog(@"Selected state: %@", self.listOfStates[row]);
    [_currForm setState:self.listOfStates[row]];
}
@end
