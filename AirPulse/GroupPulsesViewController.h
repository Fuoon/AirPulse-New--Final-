//
//  GroupViewController.h
//  AirPulse
//
//  Created by Fuoon on 10/30/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CreateGroupViewController.h"
#import "AddPulseViewController.h"
#import "PulseManager.h"
#import "SearchViewController.h"
#import "ShowMemberViewController.h"
#import "imageModel.h"

@interface GroupPulsesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, PulseManagerDelegate>

@property (strong, nonatomic) NSMutableArray *groupPulses;
@property (strong, nonatomic) PulseManager *pulseMgr;
@property (strong, nonatomic) NSString *grpIDString;
@property (strong, nonatomic) NSIndexPath *indexDelete;
@property (strong, nonatomic) NSString *grpTitle;
@property (strong, nonatomic) imageModel *imageObj;
@property (strong, nonatomic) IBOutlet UIButton *addPulseBtn;
@property (strong, nonatomic) IBOutlet UIButton *seeMemberBtn;

@end
