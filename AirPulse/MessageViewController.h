//
//  ConversationViewController.h
//  AirPulse
//
//  Created by Fuoon on 10/31/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextViewController.h"
#import "CustomCell.h"
#import "MessageManager.h"
#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "MessageContentViewController.h"

@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, MessageManagerDelegate, ProfileManagerDelegate>

@property (strong, nonatomic) NSMutableArray *conversation;
@property (strong, nonatomic) CustomCell *cell;
@property (strong, nonatomic) MessageManager *messageMgr;
@property (strong, nonatomic) ProfileManager *profileMgr;
@property (strong, nonatomic) User *ownUser;
@property (strong, nonatomic) NSIndexPath *selectedCell;

@end
