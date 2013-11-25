//
//  CreateNewMessageViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/23/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageManager.h"
#import "ProfileViewController.h"

@interface CreateNewMessageViewController : UITableViewController <MessageManagerDelegate, ProfileManagerDelegate>

@property (strong, nonatomic) MessageManager *MsgMng;
@property (strong, nonatomic) Message *userObject;
@property (strong, nonatomic) ProfileManager *profileMgr;
@property (strong, nonatomic) User *userObj;
- (IBAction)sendBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITableViewCell *nameLabel;
- (IBAction)cancelBtn:(id)sender;
@property (nonatomic) BOOL isFromMessageContent;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

@end
