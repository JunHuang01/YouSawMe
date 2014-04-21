//
//  ThirdPageViewController.h
//  RunJumpDev
//
//  Created by Jun Huang on 4/2/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormData.h"
#import "CommentBox.h"

@interface ThirdPageViewController : UIViewController
@property (strong, nonatomic) IBOutlet CommentBox *CommentBox;
@property (strong, nonatomic) IBOutlet UIButton *SubmitButton;
@property (strong, nonatomic) IBOutlet UIButton *PreviousPageButton;


@property (strong, nonatomic) FormData * currForm;
@end
