//
//  GroupViewController.m
//  AirPulse
//
//  Created by Fuoon on 10/30/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "GroupPulsesViewController.h"
#import "CommentViewController.h"
#import "Pulse.h"


@interface GroupPulsesViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *label;
@property (nonatomic) CGRect commentSize;
@property (nonatomic) NSInteger i;
@property  (strong,nonatomic) UITextView *textV;
- (IBAction)addMemberBtn:(id)sender;
@property (strong, nonatomic) CustomCell *customCell;
@property (nonatomic) NSInteger selectedCell;
- (IBAction)addPulseBtn:(id)sender;
- (IBAction)seeMemberBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addPulseButton;
@property (strong, nonatomic) IBOutlet UIButton *seeMemberButton;
@property (nonatomic)  NSInteger index;

@end

@implementation GroupPulsesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)onSuccessPulsesDeletion:(BOOL)success{
    if (success) {
        [SVProgressHUD dismiss];
        [self.pulseMgr retrievePulses:[self.grpIDString intValue]];
    }else{
        [SVProgressHUD dismiss];
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Delete Pulse Failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}
-(void)onSuccessPulsesRetrieval:(NSArray *)pulses{
    [SVProgressHUD dismiss];
    self.groupPulses = [[NSMutableArray alloc] initWithArray:pulses];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.addPulseButton.layer.cornerRadius = 5;
    self.seeMemberButton.layer.cornerRadius =5;
    
    self.pulseMgr = [PulseManager new];
    [self.pulseMgr setDelegate:self];
    [self.pulseMgr retrievePulses:[self.grpIDString intValue]];
    
    
    [self hideEmptySeparators];
    // pull down to refresh data
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    // end
    
    [self.addPulseBtn.layer setCornerRadius:5];
    [self.seeMemberBtn.layer setCornerRadius:5];
    [self.addPulseBtn.layer setBorderWidth:0.5];
    [self.seeMemberBtn.layer setBorderWidth:0.5];
    [self.seeMemberBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.addPulseBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
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
    return [self.groupPulses count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifer = @"customCell";
    self.customCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifer];
    NSString *name = [NSString stringWithFormat:@"%@ %@", [[self.groupPulses objectAtIndex:indexPath.row] firstName], [[self.groupPulses objectAtIndex:indexPath.row] lastName]];
    [self.customCell setNameLabel:name];
    [self.customCell setTextInCellAtIndex:indexPath WithText:[[self.groupPulses objectAtIndex:indexPath.row] content]];
    [self.customCell setTitleLabel:[[self.groupPulses objectAtIndex:indexPath.row] title]];
    self.imageObj = [[imageModel alloc] initWithID:[[self.groupPulses objectAtIndex:indexPath.row] iconId]];
    [self.customCell setImage:[UIImage imageNamed:self.imageObj.imageName]];
    [self.customCell setCurrentDate:[[self.groupPulses objectAtIndex:indexPath.row] time]];
    
    return self.customCell;
    
}
// end
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *txt = [[self.groupPulses objectAtIndex:indexPath.row] content];
    return [self textViewHeightForText:txt];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showWithStatus:@"Loading"];
    self.selectedCell = indexPath.row;
    [self performSegueWithIdentifier:@"showPulses" sender:self];
}

- (IBAction)addMemberBtn:(id)sender {
    [self performSegueWithIdentifier:@"addPeople" sender:self];
}

- (IBAction)addPulseBtn:(id)sender {
    [self performSegueWithIdentifier:@"addPulse" sender:self];
}

- (IBAction)seeMemberBtn:(id)sender {
    [SVProgressHUD showWithStatus:@"Loading"];
    [self performSegueWithIdentifier:@"showMember" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    CommentViewController *commentVC = segue.destinationViewController;
    if([commentVC isKindOfClass:[CommentViewController class]]){
        Pulse *pulse = [self.groupPulses objectAtIndex:self.selectedCell];
        commentVC.tempCom = pulse;
        commentVC.pulseID = [[[self.groupPulses objectAtIndex:self.selectedCell] siteId] intValue];
    }
    SearchViewController *searchVC = segue.destinationViewController;
    if([searchVC isKindOfClass:[SearchViewController class]]){
        searchVC.isFromNewsFeed = NO;
        searchVC.isFromMessage = NO;
        searchVC.grpIDString = self.grpIDString;
        searchVC.grpTitle = self.grpTitle;
    }
    
    AddPulseViewController *pulseVC = segue.destinationViewController;
    if([pulseVC isKindOfClass:[AddPulseViewController class]]){
        pulseVC.grpIDString = self.grpIDString;
    }
    
    ShowMemberViewController *showMemberVc = segue.destinationViewController;
    if ([showMemberVc isKindOfClass:[ShowMemberViewController class]]) {
        showMemberVc.grdIDString = self.grpIDString;
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
        [self.pulseMgr retrievePulses:[self.grpIDString intValue]];
        [refreshControl endRefreshing];
    });
}
// end

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

// alert view to ask for confirmation when delete and swipe to delete cell
-  (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexDelete = indexPath;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete this Pulse?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [SVProgressHUD showWithStatus:@"Loading"];
        [self.pulseMgr deletePulse:[[[self.groupPulses objectAtIndex:self.indexDelete.row] siteId] intValue] and:[self.grpIDString intValue]];
    }
}
// end

-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.pulseMgr retrievePulses:[self.grpIDString intValue]];
}

@end
