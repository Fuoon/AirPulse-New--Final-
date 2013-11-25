//
//  DescriptionViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/22/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController

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
    
    self.groupMgr = [GroupManager new];
    [self.groupMgr setDelegate:self];
    
	self.descriptionTextField.text = [self.groupObj description];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard{
    [self.descriptionTextField resignFirstResponder];
}

- (IBAction)saveBtn:(id)sender {
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.groupObj setDescription:self.descriptionTextField.text];
    [self.delegate receiveDescription:self.descriptionTextField.text];
    [self.groupMgr groupUpdate:self.groupObj andGroupID:[[self.groupObj siteId] intValue]];
}

-(void)onSuccessGroupUpdate:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        
    }
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
