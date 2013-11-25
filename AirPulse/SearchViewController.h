//
//  AddPeopleViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/8/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "ViewController.h"
#import "ProfileManager.h"
#import "GroupManager.h"
#import "OtherProfileViewController.h"
#import "GroupInfoViewController.h"
#import "CreateNewMessageViewController.h"

@interface SearchViewController : ViewController <UITableViewDelegate, UITableViewDelegate, ProfileManagerDelegate, UISearchBarDelegate, GroupManagerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *queries;
@property (strong, nonatomic) ProfileManager *profileMng;
@property (strong, nonatomic) User *userObj;
@property (strong, nonatomic) GroupManager *groupMng;
@property (strong, nonatomic) Group *groupObj;
@property (strong, nonatomic) NSString *grpIDString;
@property (strong,nonatomic) NSString *grpTitle;
@property (nonatomic) BOOL isFromNewsFeed;
@property (nonatomic) BOOL isFromMessage;

@end
