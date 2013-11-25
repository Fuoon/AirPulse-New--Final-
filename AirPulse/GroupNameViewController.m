//
//  GroupNameViewController.m
//  AirPulse
//
//  Created by Fuoon on 10/31/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "GroupNameViewController.h"
#import "GroupPulsesViewController.h"
#import "GroupInfoViewController.h"

@interface GroupNameViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger selectedRow;
- (IBAction)addBtn:(id)sender;
@end

@implementation GroupNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessGroupsRetrieval:(NSArray *)array{
    [SVProgressHUD dismiss];
    self.groupObjects = [[NSMutableArray alloc] initWithArray:array];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // for tab bar recognize swipe gesture
	UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    // end
    
    self.groupMgr = [GroupManager new];
    [self.groupMgr setDelegate:self];
    [self.groupMgr retrieveGroups];

    [self.tableView registerNib:[UINib nibWithNibName:@"GroupNameCell" bundle:nil] forCellReuseIdentifier:@"GroupNameCell"];
    [self hideEmptySeparators];
    
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

////////// TableView ////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return [self.groupObjects count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"GroupNameCell"];
    
    if(self.cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GroupNameCell" owner:self options:nil];
        self.cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self.cell setName:[[self.groupObjects objectAtIndex:indexPath.row] title]];
    [self.cell setDescription:[[self.groupObjects objectAtIndex:indexPath.row] description]];
    self.imageObj = [[imageModel alloc] initWithID:[[self.groupObjects objectAtIndex:indexPath.row] iconId]];
    [self.cell setImage:[self.imageObj image]];
    
    return self.cell;
}
// end

// custom cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
// end

// to swipe right or left and change tab bar
-(void)tappedLeftButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex -1];
}
- (void)tappedRightButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex +1];
}
// end

// go to add group controller and to recieve data back from add controller
- (IBAction)addBtn:(id)sender {
    
    [self performSegueWithIdentifier:@"addGroup" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"selectGroup"]){
        NSString *grpID = [[self.groupObjects objectAtIndex:self.selectedRow] siteId];
        GroupPulsesViewController *grpPulse = [segue destinationViewController];
        grpPulse.grpIDString = grpID;
        grpPulse.grpTitle = [[self.groupObjects objectAtIndex:self.selectedRow] title];
    }
    if([segue.identifier isEqualToString:@"groupInfo"]){
        Group *grp = [self.groupObjects objectAtIndex:self.selectedRow];
        GroupInfoViewController *grpInfoVC = [segue destinationViewController];
        grpInfoVC.grpObj = grp;
        grpInfoVC.isNewUser = NO;
    }
}
// end

- (void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.groupMgr retrieveGroups];
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"selectGroup" sender:self];
}
// to hide seperator of each cell when the cell is empty
- (void)hideEmptySeparators
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];
}
// end

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
        [self.groupMgr retrieveGroups];
        [refreshControl endRefreshing];
    });
}
// end
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showWithStatus:@"Loading"];
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"groupInfo" sender:self];
}


@end
