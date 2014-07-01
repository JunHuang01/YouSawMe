//
//  FirstPageViewController.h
//  RunJumpDev
//
//  Created by Jun Huang on 3/28/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormData.h"

@interface FirstPageViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *FirstNameField;
@property (weak, nonatomic) IBOutlet UITextField *LastNameField;
@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UIButton *NextPageButton;
@property (weak, nonatomic) IBOutlet UITextField *HomeCity;
@property (weak, nonatomic) IBOutlet UIButton *StatePicker;
@property (strong, nonatomic) FormData * currForm;

- (BOOL) textFieldShouldReturn:(UITextField *)theTextField;
@end
