//
//  CreateGroupViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/22/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "CreateGroupViewController.h"

@interface CreateGroupViewController ()

@end

@implementation CreateGroupViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessGroupCreation:(BOOL)success{
    if(success){
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD dismiss];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to create Group" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.groupMgr = [GroupManager new];
    [self.groupMgr setDelegate:self];
    
    self.isGroupImage = NO;
    [self hideEmptySeparators];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self.descriptionTextView.layer setCornerRadius:5.0];
    [self.descriptionTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.descriptionTextView.layer setBorderWidth:1.0];
    
    [self.groupNameTextField.layer setBorderWidth:1.0];
    [self.groupNameTextField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.groupNameTextField.layer setCornerRadius:5.0];
    
    //[self.profileImage.layer setBorderColor:[[UIColor blackColor] CGColor]];
    //[self.profileImage.layer setBorderWidth:1.0];
    
    [self.confirmBtn.layer setBorderWidth:0.5];
    [self.confirmBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.cancelBtn.layer setBorderWidth:0.5];
    [self.cancelBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard{
    [self.groupNameTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.groupNameTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.groupNameTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
}

// to show or to hide keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *keyboardEndFrameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [keyboardEndFrameValue CGRectValue];
    
    NSNumber *animationDurationNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationNumber doubleValue];
    
    NSNumber *animationCurveNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = [animationCurveNumber intValue];
    
    UIViewAnimationOptions animationOptions = animationCurve << 16;
    
    // Now we set up our animation block.
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptions
                     animations:^{
                         CGRect viewFrame = self.view.frame;
                         viewFrame.origin.y = keyboardEndFrame.origin.y - viewFrame.size.height + 140;
                         self.view.frame = viewFrame;
                     }
                     completion:^(BOOL finished) {}];
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSNumber *animationDurationNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationNumber doubleValue];
    
    NSNumber *animationCurveNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = [animationCurveNumber intValue];
    UIViewAnimationOptions animationOptions = animationCurve << 16;
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptions
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height); //just some hard coded value
                     }
                     completion:^(BOOL finished) {}];
    
}
// end

- (IBAction)imageBtn:(id)sender {
    [self performSegueWithIdentifier:@"changeImage" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ImageViewController *imageVC = [segue destinationViewController];
    if ([imageVC isKindOfClass:[ImageViewController class]]) {
        imageVC.delegate = self;
    }
}
-(void)recieveProfileImage:(NSString *)image{
    self.isGroupImage = YES;
    self.imageObj = [[imageModel alloc] initWithName:image];
    [self.profileImage setImage:[self.imageObj image] forState:UIControlStateNormal];
}

- (IBAction)confirmBtn:(id)sender {
    if (self.groupNameTextField.text.length > 0 && self.descriptionTextView.text.length > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to create this group" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must put in both Group Name and Description" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
// alert view to ask for confirmation when delete and swipe to delete cell
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [SVProgressHUD showWithStatus:@"Loading"];
        Group *newGroup = [Group new];
        [newGroup setTitle:self.groupNameTextField.text];
        [newGroup setDescription:self.descriptionTextView.text];
        if (self.isGroupImage) {
            [newGroup setIconId:[self.imageObj imageId]];
        }else{
            [newGroup setIconId:@"0"];
        }
        [self.groupMgr createGroup:newGroup];
    }
}
// end
// hide serpatator
- (void)hideEmptySeparators
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];
}
- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
