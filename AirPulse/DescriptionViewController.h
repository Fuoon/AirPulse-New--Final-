//
//  DescriptionViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/22/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

@class DescriptionViewController;
@protocol DescriptionDelegate <NSObject>

-(void)receiveDescription:(NSString *)description;

@end

#import "ViewController.h"
#import "GroupManager.h"

@interface DescriptionViewController : ViewController <GroupManagerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
- (IBAction)saveBtn:(id)sender;
@property (strong, nonatomic) GroupManager *groupMgr;
@property (strong, nonatomic) Group *groupObj;
@property (strong, nonatomic) id<DescriptionDelegate>delegate;
- (IBAction)cancelBtn:(id)sender;

@end
