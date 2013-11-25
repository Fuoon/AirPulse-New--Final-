//
//  FirstNameViewController.m
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "FirstNameViewController.h"

@interface FirstNameViewController ()


@end

@implementation FirstNameViewController

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
    self.textField.text = self.name;
    self.profileMng = [ProfileManager new];
    [self.profileMng setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveTextfield:(id)sender {
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.userObj setFirstName:self.textField.text];
    [self.profileMng userUpdate:self.userObj andUserID:[[self.userObj siteId] intValue]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}

-(void)onSuccessUserUpdate:(BOOL)success{
    [SVProgressHUD dismiss];
    if(success){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to edti first name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}

-(void)dismissKeyboard{
    [self.textField resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resignFirstResponder];
}

@end
