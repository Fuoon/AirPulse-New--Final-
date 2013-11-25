//
//  OtherProfileViewController.h
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileManager.h"
#import "User.h"
#import "SearchViewController.h"
#import "MessageManager.h"
#import "MessageViewController.h"
#import "imageModel.h"



@interface OtherProfileViewController : UITableViewController <ProfileManagerDelegate, MessageManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong , nonatomic) NSString *name;
@property (strong, nonatomic) IBOutlet UINavigationItem *naviItem;
@property (nonatomic) BOOL isFromSearchUser;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) ProfileManager *profileMng;
@property (strong, nonatomic) User *userObj;
@property (strong, nonatomic) MessageManager *messageMgr;
@property (strong, nonatomic) NSString *grpIDString;
@property (strong, nonatomic) NSString *grpTitle;
@property (strong, nonatomic) imageModel *imageObj;

@end
