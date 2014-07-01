//
//  StatePickerViewController.h
//  RunJumpDev
//
//  Created by Jun Huang on 7/1/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormData.h"

@interface StatePickerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *StatePicker;
@property (strong, nonatomic)  NSArray *listOfStates;
@property (strong, nonatomic) IBOutlet UIButton *DoneButton;
@property (strong, nonatomic) FormData * currForm;
@end
