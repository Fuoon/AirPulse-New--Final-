//
//  ViewController.m
//  AirPulse
//
//  Created by Fuoon on 10/29/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "ViewController.h"
#import "NewFeedViewController.h"


@interface ViewController ()

- (IBAction)signInBtn:(id)sender;
- (IBAction)signUpBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *signIn;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation ViewController

- (void)onSuccessAuthentication:(BOOL)success {
   [SVProgressHUD dismiss];
    if(success == YES){
        [self performSegueWithIdentifier:@"tabBar" sender:self];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to sign in" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.usernameTextField.text = @"";
    self.pwdTextField.text = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.usernameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    self.usernameTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.pwdTextField setBorderStyle:UITextBorderStyleRoundedRect];
    self.pwdTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.signIn.layer.cornerRadius = 5.0f;
    self.signUpBtn.layer.cornerRadius = 5.0f;
    [self.signInBtn.layer setBorderWidth:1];
    [self.signInBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.signUpBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.signUpBtn.layer setBorderWidth:1];
    [self.signUpBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.authMgr = [AuthenticationManager new];
    [self.authMgr setDelegate:self];
    self.feedData = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)signInBtn:(id)sender {
    
    if([self.pwdTextField.text length] > 7){
        [SVProgressHUD showWithStatus:@"Loading"];
        [self.authMgr authenticate:self.usernameTextField.text and:self.pwdTextField.text];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password needs to have at least 8 characters" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

- (IBAction)signUpBtn:(id)sender {
    [self performSegueWithIdentifier:@"signUp" sender:self];
}

// to pass data from json in array to tabcontroller and other controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"tabBar"]) {
        UITabBarController *tbc = [segue destinationViewController];
        UINavigationController *navigationController = (UINavigationController *)[[tbc viewControllers] objectAtIndex:0];
        NewFeedViewController *NFController = (NewFeedViewController *)[[navigationController viewControllers] objectAtIndex:0];
        NFController.newsFeedObjs = self.feedData;
    }
}
// end

// when click return or anywhere on the screen to hide keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.usernameTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.usernameTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}
// end

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


@end
