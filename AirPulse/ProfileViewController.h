//
//  ProfileViewController.h
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstNameViewController.h"
#import "LastNameViewController.h"
#import "ProfileManager.h"
#import "imageModel.h"
#import "AuthenticationManager.h"
#import "ImageViewController.h"

@protocol profileViewControllerDelegate <NSObject>

-(void)receiveUpdateProfile:(User *)profileUpdate;

@end

@interface ProfileViewController : UITableViewController <UITableViewDelegate, ProfileManagerDelegate, AuthenticationManagerDelegate, imageViewDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *signOut;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *profileImage;
- (IBAction)imageBtn:(id)sender;
@property (strong, nonatomic) ProfileManager *profileMgr;
@property (strong, nonatomic) User *userObj;
@property (strong, nonatomic) imageModel *imageObj;
@property (strong, nonatomic) AuthenticationManager *authenObj;
@property (strong, nonatomic) id<profileViewControllerDelegate>delegate;

@end
