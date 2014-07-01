//
//  SecondPageViewController.h
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormData.h"

@interface SecondPageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton * checkAllGameBox;
@property (strong, nonatomic) IBOutlet UIButton *bNotifyFutureGame;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *gameCheckedList;
@property (strong, nonatomic) IBOutlet UIButton *PreviousPageButton;
@property (strong, nonatomic) IBOutlet UIButton *NextPageButton;
@property (strong, nonatomic) IBOutlet UITextField *otherPurpose;

@property (strong, nonatomic) FormData * currForm;
@end
