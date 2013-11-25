//
//  AddPulseViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/2/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PulseManager.h"

@interface AddPulseViewController : UIViewController <PulseManagerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *pulseTitle;
@property (strong, nonatomic) PulseManager *pulseMgr;
@property (strong, nonatomic) NSString *grpIDString;
@property (strong, nonatomic) IBOutlet UITextView *contentTextview;

@end
