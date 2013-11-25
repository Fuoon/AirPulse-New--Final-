//
//  NewFeedViewController.h
//  AirPulse
//
//  Created by Fuoon on 10/30/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "CustomCell.h"
#import "NewsFeedManager.h"
#import "CommentViewController.h"
#import "CreateNewMessageViewController.h"
#import "imageModel.h"
#import "PulseManager.h"

@interface NewFeedViewController : UIViewController <NewsFeedManagerDelegate>

@property (strong, nonatomic) NSMutableArray *newsFeedObjs;
@property (strong, nonatomic) CustomCell *customCell;
@property (strong, nonatomic) NewsFeedManager *newsFeedMgr;
@property (strong, nonatomic) NSIndexPath *selectedCell;
@property (strong, nonatomic) PulseManager *pulseMgr;

@end
