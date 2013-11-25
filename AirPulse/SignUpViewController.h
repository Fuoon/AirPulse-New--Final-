//
//  SingUpViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/21/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationManager.h"
#import "SVProgressHUD.h"
#import "ImageViewController.h"

@interface SignUpViewController : UITableViewController <RegistrationManagerDelegate, imageViewDelegate, UITextFieldDelegate>


- (IBAction)imageBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
- (IBAction)signUpBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
@property (strong, nonatomic) imageModel *imageObj;
@property (strong, nonatomic) RegistrationManager *regisMgr;
@property (strong, nonatomic) IBOutlet UIButton *signBtn;

@end
