//
//  AdminPageViewController.h
//  RunJumpDev
//
//  Created by Jun Huang on 4/5/14.
//  Copyright (c) 2014 Jun Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Database.h"
//#import <sqlite3.h>

@interface AdminPageViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *emailDataButton;
@property (strong, nonatomic) NSString* tempFile;
@property (strong, nonatomic) NSString* databasePath;
@property (strong, nonatomic) Database* mydatabase;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, assign) BOOL bDumpALL;

@end
