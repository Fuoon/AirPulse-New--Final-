//
//  PulsesViewController.h
//  AirPulse
//
//  Created by Fuoon on 10/31/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextViewController.h"
#import "CustomCell.h"
#import "CommentCell.h"
#import "OtherProfileViewController.h"
#import "CommentManager.h"
#import "Pulse.h"
#import "imageModel.h"
#import "ProfileManager.h"

@interface CommentViewController : UIViewController <CustomTextViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, CommentManagerDelegate, ProfileManagerDelegate, profileViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *pulseObjects;
@property (strong, nonatomic) NSMutableArray *arrayImage;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) Pulse *tempCom;
@property NSInteger pulseID;
@property (strong, nonatomic) CommentManager *commentMgr;
@property (strong, nonatomic) imageModel *imageObj;
@property (strong, nonatomic) ProfileManager *profileMgr;
@property (strong, nonatomic) User *userObj;

@end
