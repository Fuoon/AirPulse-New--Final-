//
//  AddPulseViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/2/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "AddPulseViewController.h"
#import "Pulse.h"

@interface AddPulseViewController ()

- (IBAction)submitBtn:(id)sender;

@end

@implementation AddPulseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessPulsesCreation:(BOOL)success{
    if(success){
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD dismiss];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to create Pulse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.pulseMgr = [PulseManager new];
    [self.pulseMgr setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self.pulseTitle.layer setCornerRadius:5];
    [self.contentTextview.layer setCornerRadius:5];
    [self.pulseTitle.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.contentTextview.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.pulseTitle.layer setBorderWidth:1];
    [self.contentTextview.layer setBorderWidth:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtn:(id)sender {
    if (self.pulseTitle.text.length > 0 && self.contentTextview.text.length > 0) {
        [SVProgressHUD showWithStatus:@"Loading"];
        Pulse *pulseObj = [[Pulse alloc] initWithTitle:self.pulseTitle.text andContent:self.contentTextview.text];
        NSInteger grpID = [self.grpIDString intValue];
        [self.pulseMgr createPulse:pulseObj andGroupId:grpID];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You must fill in both title and content" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.pulseTitle resignFirstResponder];
    [self.contentTextview resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.pulseTitle resignFirstResponder];
    [self.contentTextview resignFirstResponder];
}
-(void)dismissKeyboard{
    [self.pulseTitle resignFirstResponder];
    [self.contentTextview resignFirstResponder];
}

@end
