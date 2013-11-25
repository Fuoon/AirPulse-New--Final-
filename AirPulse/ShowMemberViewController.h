//
//  ShowMemberViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/8/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "ViewController.h"
#import "GroupNameCell.h"
#import "MembershipManager.h"
#import "OtherProfileViewController.h"
#import "ProfileViewController.h"
#import "ProfileManager.h"

@interface ShowMemberViewController : ViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MembershipManagerDelegate, ProfileManagerDelegate>

@property (nonatomic, strong) NSMutableArray *memberObject;
@property (nonatomic, strong) NSMutableArray *memberPicture;
@property (nonatomic, strong) GroupNameCell *cell;
@property (nonatomic, strong) MembershipManager *memberMgr;
@property (nonatomic, strong) NSString *grdIDString;
@property (nonatomic, strong) ProfileManager *profileMgr;
@property (nonatomic, strong) User *userObj;
@property (nonatomic, strong) NSIndexPath *selectedCell;

@end
