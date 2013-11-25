//
//  GroupNameViewController.h
//  AirPulse
//
//  Created by Fuoon on 10/31/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateGroupViewController.h"
#import "GroupNameCell.h"
#import "GroupManager.h"
#import "imageModel.h"

@interface GroupNameViewController : UIViewController <GroupManagerDelegate,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSIndexPath *indexDelete;
@property (strong, nonatomic) GroupNameCell *cell;
@property (strong, nonatomic) imageModel *imageObj;
@property (strong, nonatomic) GroupManager *groupMgr;
@property (strong, nonatomic) NSMutableArray *groupObjects;

@end
