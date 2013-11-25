//
//  FirstNameViewController.h
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileManager.h"

@interface FirstNameViewController : UIViewController <UITextFieldDelegate, ProfileManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) ProfileManager *profileMng;
@property (strong, nonatomic) User *userObj;
@property (strong, nonatomic) NSString *userIDString;
@end
