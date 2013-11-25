//
//  ViewController.h
//  AirPulse
//
//  Created by Fuoon on 10/29/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "AuthenticationManager.h"

@interface ViewController : UIViewController <AuthenticationManagerDelegate>

@property (nonatomic, strong) NSArray *pulses;
@property (nonatomic, strong) NSMutableArray *feedData;
@property (nonatomic, strong) AuthenticationManager *authMgr;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UIButton *signUpBtn;

@end
