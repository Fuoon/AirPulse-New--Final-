//
//  MessageContentViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/23/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageManager.h"
#import "ProfileManager.h"
#import "imageModel.h"
#import "CreateNewMessageViewController.h"

@interface MessageContentViewController : UITableViewController <MessageManagerDelegate, ProfileManagerDelegate>

@property (strong, nonatomic) MessageManager *messageMgr;
@property (strong, nonatomic) Message *messageObj;
@property (strong, nonatomic) ProfileManager *profileMgr;
@property (strong, nonatomic) User *userObj;
- (IBAction)replyBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *replyBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) imageModel *messageImage;
@property (strong, nonatomic) IBOutlet UILabel *messageTitle;
@property (strong, nonatomic) IBOutlet UILabel *messageName;
@property (strong, nonatomic) IBOutlet UILabel *messageDate;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@end
