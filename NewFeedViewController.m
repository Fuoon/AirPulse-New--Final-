//
//  NewFeedViewController.m
//  AirPulse
//
//  Created by Fuoon on 10/30/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "NewFeedViewController.h"
#import "SearchViewController.h"

@interface NewFeedViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessNewsFeedRetrieval:(NSArray *)pulses{
    [SVProgressHUD dismiss];
    self.newsFeedObjs = [[NSMutableArray alloc] initWithArray:pulses];
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
    
    self.newsFeedMgr = [NewsFeedManager new];
    [self.newsFeedMgr setDelegate:self];
    [self.newsFeedMgr retrieveNewsFeed];
    
    // pull down to refresh data
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    // end
    
    [self hideEmptySeparators];

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
    return [self.newsFeedObjs count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifer = @"customCell";
    self.customCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifer];
    [self.customCell setTextInCellAtIndex:indexPath WithText:[[self.newsFeedObjs objectAtIndex:indexPath.row] content]];
    NSString *name = [NSString stringWithFormat:@"%@ %@", [[self.newsFeedObjs objectAtIndex:indexPath.row] firstName], [[self.newsFeedObjs objectAtIndex:indexPath.row] lastName]];
    [self.customCell setNameLabel:name];
    [self.customCell setTitleLabel:[[self.newsFeedObjs objectAtIndex:indexPath.row] title]];
    imageModel *imageObj = [[imageModel alloc] initWithID:[[self.newsFeedObjs objectAtIndex:indexPath.row] iconId]];
    UIImage *image = [UIImage imageNamed:imageObj.imageName];
    [self.customCell setImage:image];
    [self.customCell setCurrentDate:[[self.newsFeedObjs objectAtIndex:indexPath.row] time]];
    
    return self.customCell;
}
// end
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *txt = [[self.newsFeedObjs objectAtIndex:indexPath.row] content];
    return [self textViewHeightForText:txt];
}

- (CGFloat)textViewHeightForText:(NSString *)text
{
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:14.0f]}];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(305, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               context:nil];
    CGSize size = rect.size;
    CGFloat height = ceil(size.height +18)+54;
    return height;
}
// to swipe right or left and change tab bar
-(void)tappedLeftButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex +3];
}
- (void)tappedRightButton:(id)sender{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex +1];
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
    [self.newsFeedMgr retrieveNewsFeed];
    [refreshControl endRefreshing];
    });
}
// end

// to select row from tableView
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell = indexPath;
    [self performSegueWithIdentifier:@"showPulses" sender:self];
}
//end

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchGroup"]){
        SearchViewController *searchVC = [segue destinationViewController];
        searchVC.isFromNewsFeed = YES;
        searchVC.isFromMessage = NO;
    }
    if ([segue.identifier isEqualToString:@"showPulses"]) {
        CommentViewController *commentVC = [segue destinationViewController];
        commentVC.tempCom = [self.newsFeedObjs objectAtIndex:self.selectedCell.row];
        commentVC.pulseID = [[[self.newsFeedObjs objectAtIndex:self.selectedCell.row] siteId] intValue];
    }
}

// to hide seperator of each cell when the cell is empty
- (void)hideEmptySeparators
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:v];
}
// end

-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.newsFeedMgr retrieveNewsFeed];
}

@end
