//
//  CreateGroupViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/22/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupManager.h"
#import "ImageViewController.h"

@interface CreateGroupViewController : UITableViewController <GroupManagerDelegate, UITextFieldDelegate, imageViewDelegate>

@property (nonatomic, strong) GroupManager *groupMgr;
@property (nonatomic) BOOL isGroupImage;
@property (nonatomic, strong)imageModel *imageObj;
- (IBAction)imageBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *profileImage;
@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
- (IBAction)confirmBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)cancelBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@end
