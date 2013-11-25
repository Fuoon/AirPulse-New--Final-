//
//  LastNameViewController.m
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "LastNameViewController.h"

@interface LastNameViewController ()

@end

@implementation LastNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lastNameField.text = self.lastName;
	
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard{
    [self.lastNameField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onSuccessUserUpdate:(BOOL)success{
    if (success) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveLastName:(id)sender {
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.userObj setLastName:self.lastNameField.text];
    [self.profileMgr userUpdate:self.userObj andUserID:[[self.userObj siteId] intValue]];
}

@end
