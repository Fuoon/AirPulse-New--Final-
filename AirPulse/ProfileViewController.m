//
//  ProfileViewController.m
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController ()

@property (strong, nonatomic) NSString *grpID;

@end

@implementation ProfileViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessDestroySession:(BOOL)success{
    [SVProgressHUD dismiss];
    if(success){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Sign out" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}

-(void)onSuccessUserUpdate:(BOOL)success{
    [SVProgressHUD dismiss];
    if(success){
        [self.delegate receiveUpdateProfile:self.userObj];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Edit Profile" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}
-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    self.userObj = [ownUser objectAtIndex:0];
    self.firstNameLabel.text = [self.userObj firstName];
    self.lastNameLabel.text = [self.userObj lastName];
    self.emailLabel.text = [self.userObj email];
    self.imageObj = [[imageModel alloc] initWithID:[self.userObj iconId]];
    [self.profileImage setImage:[self.imageObj image] forState:UIControlStateNormal];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.profileMgr getOwnUser];
    
    self.authenObj = [AuthenticationManager new];
    [self.authenObj setDelegate:self];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
}

-(void)tappedLeftButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex -1];
}
- (void)tappedRightButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex +1];
}

-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.profileMgr getOwnUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        [SVProgressHUD showWithStatus:@"Loading"];
        [self.authenObj destroySession];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"firstname"]){
        NSString *name = self.firstNameLabel.text;
        FirstNameViewController *firstVC = [segue destinationViewController];
        firstVC.userObj = self.userObj;
        firstVC.name = name;
        
    }else if([segue.identifier isEqualToString:@"lastname"]){
        NSString *lastName = self.lastNameLabel.text;
        LastNameViewController *lastVC = [segue destinationViewController];
        lastVC.userObj = self.userObj;
        lastVC.lastName = lastName;
    }else if([[segue destinationViewController] isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ImageVC = [segue destinationViewController];
        ImageVC.delegate = self;
    }
}

-(void)addObjectViewController:(id)controller didFinishEnteringItem:(NSString *)item{
    if([controller isKindOfClass:[FirstNameViewController class]]){
        self.firstNameLabel.text = item;
    }else if([controller isKindOfClass:[LastNameViewController class]]){
        self.lastNameLabel.text = item;
    }else{
        self.emailLabel.text = item;
    }
}

- (IBAction)imageBtn:(id)sender {
    [self performSegueWithIdentifier:@"changeImage" sender:self];
}

-(void)recieveProfileImage:(NSString *)image{
    imageModel *profileimg = [[imageModel alloc] initWithName:image];
    [self.profileImage.imageView setImage:profileimg.image];
    [self.userObj setIconId:profileimg.imageId];
    [self.profileMgr userUpdate:self.userObj andUserID:self.userObj.siteId.intValue];
}

@end
