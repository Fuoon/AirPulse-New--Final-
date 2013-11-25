//
//  SingUpViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/21/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UIButton *imageProfile;
@property (nonatomic) BOOL isPickImage;

@end

@implementation SignUpViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isPickImage = NO;
    self.regisMgr = [RegistrationManager new];
    [self.regisMgr setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onSuccessAccountCreation:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to sign up" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)signUpBtn:(id)sender {
    if (self.lastNameTextField.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Last name is required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else if(self.firstNameTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"First name is required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else if(self.passwordTextField.text.length < 8){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Password must have at least 8 characters" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else if(self.emailTextField.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Email is required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [SVProgressHUD showWithStatus:@"Loading"];
        if(self.isPickImage) {
            User *user = [[User alloc] initWithFirstName:self.firstNameTextField.text andLastName:self.lastNameTextField.text andIcon:[self.imageObj imageId]];
            [self.regisMgr createAccount:self.emailTextField.text andPassword:self.passwordTextField.text andUserProfile:user];
        }else{
            User *user = [[User alloc] initWithFirstName:self.firstNameTextField.text andLastName:self.lastNameTextField.text andIcon:@"0"];
            [self.regisMgr createAccount:self.emailTextField.text andPassword:self.passwordTextField.text andUserProfile:user];
        }
    }
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// when click return or anywhere on the screen to hide keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}
// end
- (IBAction)imageBtn:(id)sender {
    [self performSegueWithIdentifier:@"chooseImage" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ImageViewController *imageVC = [segue destinationViewController];
    if ([imageVC isKindOfClass:[ImageViewController class]]) {
        imageVC.delegate = self;
    }
}
-(void)recieveProfileImage:(NSString *)image{
    self.isPickImage = YES;
    self.imageObj = [[imageModel alloc] initWithName:image];
    UIImage *realImage = [UIImage imageNamed:image];
    [self.imageProfile setImage:realImage forState:UIControlStateNormal];
}

-(void)dismissKeyboard{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
}

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
                         viewFrame.origin.y = keyboardEndFrame.origin.y - viewFrame.size.height + 70;
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

@end
