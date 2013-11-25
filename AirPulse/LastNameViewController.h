//
//  LastNameViewController.h
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileManager.h"

@interface LastNameViewController : UIViewController <ProfileManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) NSString *lastName;
@property (nonatomic, strong) ProfileManager *profileMgr;
@property (nonatomic, strong) User *userObj;

@end
