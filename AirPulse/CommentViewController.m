//
//  PulsesViewController.m
//  AirPulse
//
//  Created by Fuoon on 10/31/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CustomTextViewController *textInput;
@property (strong, nonatomic) CustomCell *customCell;
@property (strong, nonatomic) CommentCell *commentCell;
@property (strong, nonatomic) IBOutlet UIView *test;
@property (strong, nonatomic) NSString *label;
@property (nonatomic) CGRect commentSize;
@property  (strong,nonatomic) UITextView *textV;
@property (nonatomic) BOOL isComment;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessCommentCreation:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        [self.commentMgr retrieveComments:self.pulseID];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to comment" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)onSuccessCommentsRetrieval:(NSArray *)comments{
    self.pulseObjects = [[NSMutableArray alloc] initWithObjects:self.tempCom, nil];
    for (int i=0; i<comments.count; i++) {
        [self.pulseObjects addObject:[comments objectAtIndex:i]];
    }
//    self.pulseObjects = [[NSMutableArray alloc] initWithArray:comments];
//    [self.pulseObjects insertObject:self.tempCom atIndex:0];
    NSLog(@"--------------------------------------------------%d", [self.pulseObjects count]);
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
    
}

-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    self.userObj = [ownUser objectAtIndex:0];
}

-(void)receiveUpdateProfile:(User *)profileUpdate{
    [self.tempCom setFirstName:profileUpdate.firstName];
    [self.tempCom setLastName:profileUpdate.lastName];
    [self.tempCom setIconId:profileUpdate.iconId];
    [self.commentMgr retrieveComments:self.pulseID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    self.textInput = [[CustomTextViewController alloc] initWithNibName:@"CustomTextViewController" bundle:nil];
    [self.textInput addView:self.test];
    [self.textInput setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.commentMgr = [CommentManager new];
    [self.commentMgr setDelegate:self];
    [self.commentMgr retrieveComments:self.pulseID];
    
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    [self.profileMgr getOwnUser];
    
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
    return [self.pulseObjects count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
        static NSString *MyIdentifer = @"customCell";
        self.customCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifer];
        [self.customCell setTextInCellAtIndex:indexPath WithText:[[self.pulseObjects objectAtIndex:indexPath.row] content]];
        [self.customCell setTitleLabel:[[self.pulseObjects objectAtIndex:indexPath.row] title]];
        NSString *name = [NSString stringWithFormat:@"%@ %@", [[self.pulseObjects objectAtIndex:indexPath.row] firstName], [[self.pulseObjects objectAtIndex:indexPath.row] lastName]];
        [self.customCell setNameLabel:name];
        self.imageObj = [[imageModel alloc] initWithID:[[self.pulseObjects objectAtIndex:indexPath.row] iconId]];
        [self.customCell setImage:[UIImage imageNamed:self.imageObj.imageName]];
        [self.customCell setCurrentDate:[[self.pulseObjects objectAtIndex:indexPath.row] time]];
        return self.customCell;
    }else{
        static NSString *commentIdentifier = @"commentCell";
        self.commentCell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        [self.commentCell setTextInCellAtIndex:indexPath WithText:[[self.pulseObjects objectAtIndex:indexPath.row] content]];
        NSString *name = [NSString stringWithFormat:@"%@ %@", [[self.pulseObjects objectAtIndex:indexPath.row] firstName], [[self.pulseObjects objectAtIndex:indexPath.row] lastName]];
        [self.commentCell setNameLabel:name];
        self.imageObj = [[imageModel alloc] initWithID:[[self.pulseObjects objectAtIndex:indexPath.row] iconId]];
        [self.commentCell setImage:[UIImage imageNamed:self.imageObj.imageName]];
        [self.commentCell setCurrentDate:[[self.pulseObjects objectAtIndex:indexPath.row] time]];
        return self.commentCell;
    }


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
                         CGRect textFieldFrame = self.test.frame;
                         textFieldFrame.origin.y = keyboardEndFrame.origin.y - textFieldFrame.size.height;
                         self.test.frame = textFieldFrame;
                     }
                     completion:^(BOOL finished) {}];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptions
                     animations:^{
                         CGRect tableViewFrame = self.tableView.frame;
                         tableViewFrame.origin.y = keyboardEndFrame.origin.y - tableViewFrame.size.height - self.test.frame.size.height;
                         self.tableView.frame = tableViewFrame;
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
                         self.test.frame = CGRectMake(0, 479, self.test.frame.size.width, self.test.frame.size.height); //just some hard coded value
                     }
                     completion:^(BOOL finished) {}];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationOptions
                     animations:^{
                         self.tableView.frame = CGRectMake(0, 10, self.tableView.frame.size.width, self.tableView.frame.size.height);                     }
                     completion:^(BOOL finished) {}];
    
}
// end

// to hide keyboard when click return or anywhere on the screen
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textInput resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textInput resignFirstResponder];
}
// end

// custom cell for pulses

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSString *text = [[self.pulseObjects objectAtIndex:indexPath.row] content];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:text
         attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:14.0f]}];
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(305, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   context:nil];
        CGSize size = rect.size;
        CGFloat height = ceil(size.height +18)+87;
        
        return height;

    }else{
        NSString *text = [[self.pulseObjects objectAtIndex:indexPath.row] content];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:text
         attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:14.0f]}];
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(250, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   context:nil];
        CGSize size = rect.size;
        CGFloat height = ceil(size.height + 18)+27;
        
        return height;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath;
    [SVProgressHUD showWithStatus:@"Loading"];
    if([[self.userObj siteId] isEqualToString:[[self.pulseObjects objectAtIndex:indexPath.row] userId]]){
        self.isComment = NO;
        [self performSegueWithIdentifier:@"profile" sender:self];
    }else{
        self.isComment = YES;
        [self performSegueWithIdentifier:@"otherprofile" sender:self];
    }
    
}

//delegate of CsutomTextViewController sumbit button
-(void)submitTextChanges{
    Comment *commentObj = [[Comment alloc] initWithContent:self.textInput.getText];
    self.textInput.textField.text = @"" ;
    [self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    [SVProgressHUD showWithStatus:@"Loading"];
    [self.commentMgr createComment:commentObj andPulseId:self.pulseID];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ProfileViewController *profileVC = [segue destinationViewController];
    if(self.isComment){
        OtherProfileViewController *otherProfileVC = [segue destinationViewController];
        otherProfileVC.isFromSearchUser = NO;
        otherProfileVC.userID = [[self.pulseObjects objectAtIndex:self.selectedIndex.row] userId];
    }else if([profileVC isKindOfClass:[ProfileViewController class]]){
        profileVC.delegate = self;
    }
}
// end

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
        [self.commentMgr retrieveComments:self.pulseID];
        [refreshControl endRefreshing];
    });
}
// end

@end
