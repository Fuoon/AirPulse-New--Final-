//
//  ShowMemberViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/8/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "ShowMemberViewController.h"

@interface ShowMemberViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShowMemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onMembershipRetrieveSuccess:(NSArray *)array{
    [SVProgressHUD dismiss];
    self.memberObject = [[NSMutableArray alloc] initWithArray:array];
    [self.tableView reloadData];
}

-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    self.userObj = [ownUser objectAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.memberMgr = [MembershipManager new];
    [self.memberMgr setDelegate:self];
    [self.memberMgr retrieveMembershipsByGroup:[self.grdIDString intValue]];
    
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    [self.profileMgr getOwnUser];
    
    // pull down to refresh data
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    // end
    
}

-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.memberMgr retrieveMembershipsByGroup:[self.grdIDString intValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.memberObject count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *name = [NSString stringWithFormat:@"%@ %@", [[self.memberObject objectAtIndex:indexPath.row] firstName], [[self.memberObject objectAtIndex:indexPath.row] lastName]];
    [cell.textLabel setText:name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.userObj siteId] isEqualToString:[[self.memberObject objectAtIndex:indexPath.row] siteId]]) {
        [self performSegueWithIdentifier:@"profile" sender:self];
    }else{
        self.selectedCell = indexPath;
        [self performSegueWithIdentifier:@"otherProfile" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"otherProfile"]) {
        OtherProfileViewController *otherVC = [segue destinationViewController];
        otherVC.userID = [[self.memberObject objectAtIndex:self.selectedCell.row] siteId];
    }
//    else if([segue.identifier isEqualToString:@"profile"]){
//        ProfileViewController *profileVC = [segue destinationViewController];
//        profileVC.userObj = self.userObj;
//    }
}

// pull down to refresh data in table view
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)TableView:(UITableView *)TableView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't connect. Please check your internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 2.0;
    // multithread
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [SVProgressHUD showWithStatus:@"Loading"];
        [self.memberMgr retrieveMembershipsByGroup:[self.grdIDString intValue]];
        [refreshControl endRefreshing];
    });
}
// end


@end
