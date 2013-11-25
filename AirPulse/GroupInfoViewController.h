//
//  GroupInfoViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/20/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "ProfileManager.h"
#import "User.h"
#import "GroupManager.h"
#import "MembershipManager.h"
#import "ImageViewController.h"
#import "DescriptionViewController.h"

@interface GroupInfoViewController : UITableViewController <ProfileManagerDelegate, MembershipManagerDelegate, GroupManagerDelegate, imageViewDelegate, DescriptionDelegate>

@property (strong, nonatomic) Group *grpObj;
@property (strong, nonatomic) ProfileManager *profileMng;
@property (strong, nonatomic) User *creatorObj;
@property (strong, nonatomic) GroupManager *groupMgr;
@property (strong, nonatomic) MembershipManager *memberMgr;
@property (strong, nonatomic) NSString *grpIDString;
- (IBAction)imageBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *profileImage;
@property (strong, nonatomic) imageModel *imageObj;
@property (strong, nonatomic) IBOutlet UITableViewCell *descriptionCell;

@property (nonatomic) BOOL isCreator;
@property (nonatomic) BOOL isNewUser;

@end
