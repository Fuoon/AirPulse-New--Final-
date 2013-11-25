//
//  ConversationViewController.m
//  AirPulse
//
//  Created by Fuoon on 10/31/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "MessageViewController.h"
#import "imageModel.h"

@interface MessageViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)newMessageBtn:(id)sender;

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessMesssagesRetrieval:(NSArray *)array{
    self.conversation = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count ; i++) {
        [self.conversation insertObject:[array objectAtIndex:i] atIndex:0];
    }
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    self.ownUser = [ownUser objectAtIndex:0];
    [self.messageMgr retrieveMessages];
}

-(void)tappedLeftButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex -1];
}
- (void)tappedRightButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex +1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.messageMgr = [MessageManager new];
    [self.messageMgr setDelegate:self];
    
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    [self.profileMgr getOwnUser];
    
    // pull down to refresh data
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    // end
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.conversation count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifer = @"customCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifer];
    imageModel *receiverimageObj = [[imageModel alloc] initWithID:[[self.conversation objectAtIndex:indexPath.row] receiverIconId]];
    imageModel *senderimageObj = [[imageModel alloc] initWithID:[[self.conversation objectAtIndex:indexPath.row] senderIconId]];
    
    if ([self.ownUser.siteId isEqualToString:[[self.conversation objectAtIndex:indexPath.row] senderId]]) {
        //I'm sending to other
        //[self.cell setTextInCellAtIndex:indexPath WithText:[[self.conversation objectAtIndex:indexPath.row] body]];
        NSString *name = [NSString stringWithFormat:@"To: %@ %@", [[self.conversation objectAtIndex:indexPath.row] receiverFirstName], [[self.conversation objectAtIndex:indexPath.row] receiverLastName]];
        [self.cell setNameLabel:name];
        [self.cell setTitleLabel:[[self.conversation objectAtIndex:indexPath.row] title]];
        [self.cell setImage:receiverimageObj.image];
        [self.cell.layer setBorderWidth:0.5];
        [self.cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.cell.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.cell setCurrentDate:[[self.conversation objectAtIndex:indexPath.row] time]];
        return self.cell;
    }else if(![self.ownUser.siteId isEqualToString:[[self.conversation objectAtIndex:indexPath.row] senderId]] && [[[self.conversation objectAtIndex:indexPath.row] title] isEqualToString:@"Invitation"]){
        //Invitation from other
        //[self.cell setTextInCellAtIndex:indexPath WithText:[[self.conversation objectAtIndex:indexPath.row] body]];
        NSString *name = [NSString stringWithFormat:@"From: %@ %@", [[self.conversation objectAtIndex:indexPath.row] senderFirstName], [[self.conversation objectAtIndex:indexPath.row] senderLastName]];
        [self.cell setNameLabel:name];
        [self.cell setTitleLabel:[[self.conversation objectAtIndex:indexPath.row] title]];
        [self.cell setImage:senderimageObj.image];
        [self.cell.layer setBorderWidth:0.5];
        [self.cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.cell setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:134.0/255.0 blue:48.0/255.0 alpha:0.3]];
        [self.cell setCurrentDate:[[self.conversation objectAtIndex:indexPath.row] time]];
        return self.cell;
    }else{
        //I'm a receiver
        //[self.cell setTextInCellAtIndex:indexPath WithText:[[self.conversation objectAtIndex:indexPath.row] body]];
        NSString *name = [NSString stringWithFormat:@"From: %@ %@", [[self.conversation objectAtIndex:indexPath.row] senderFirstName], [[self.conversation objectAtIndex:indexPath.row] senderLastName]];
        [self.cell setNameLabel:name];
        [self.cell setTitleLabel:[[self.conversation objectAtIndex:indexPath.row] title]];
        [self.cell setImage:senderimageObj.image];
        [self.cell setBackgroundColor:[UIColor colorWithRed:105.0/255.0 green:210.0/255.0 blue:231.0/255.0 alpha:0.2]];
        [self.cell.layer setBorderWidth:0.5];
        [self.cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.cell setCurrentDate:[[self.conversation objectAtIndex:indexPath.row] time]];
        return self.cell;
    }
    
}
// end

-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.profileMgr getOwnUser];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
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
        [self.profileMgr getOwnUser];
        [refreshControl endRefreshing];
    });
}
// end

- (IBAction)newMessageBtn:(id)sender {
    [self performSegueWithIdentifier:@"searchName" sender:self];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell = indexPath;
    [self performSegueWithIdentifier:@"showMessage" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"searchName"]) {
        SearchViewController *searchVC = [segue destinationViewController];
        searchVC.isFromMessage = YES;
        searchVC.isFromNewsFeed = NO;
    }else if ([[segue identifier] isEqualToString:@"showMessage"]) {
        
        MessageContentViewController *messageContentVC = [segue destinationViewController];
        messageContentVC.messageObj = [self.conversation objectAtIndex:self.selectedCell.row];
    }
}
@end
