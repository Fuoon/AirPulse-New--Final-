//
//  AddPeopleViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/8/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (strong, nonatomic) NSIndexPath *selectedIndex;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.isFromNewsFeed){
        self.groupMng = [GroupManager new];
        [self.groupMng setDelegate:self];
    }else if(self.isFromMessage){
        self.profileMng = [ProfileManager new];
        [self.profileMng setDelegate:self];
        [self.profileMng getOwnUser];
    }else{
        self.profileMng = [ProfileManager new];
        [self.profileMng setDelegate:self];
        [self.profileMng getOwnUser];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

////////// TableView ////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.queries count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(self.isFromNewsFeed) {
        cell.textLabel.text = [[self.queries objectAtIndex:indexPath.row] title];
    }else if(self.isFromMessage){
        if ([[self.userObj siteId] isEqualToString:[[self.queries objectAtIndex:indexPath.row] siteId]]) {
        }else{
            NSString *fullName = [NSString stringWithFormat:@"%@ %@", [[self.queries objectAtIndex:indexPath.row] firstName], [[self.queries objectAtIndex:indexPath.row] lastName]];
            cell.textLabel.text = fullName;
        }
        
    }else{
        if ([[self.userObj siteId] isEqualToString:[[self.queries objectAtIndex:indexPath.row] siteId]]) {
        }else{
            NSString *fullName = [NSString stringWithFormat:@"%@ %@", [[self.queries objectAtIndex:indexPath.row] firstName], [[self.queries objectAtIndex:indexPath.row] lastName]];
            cell.textLabel.text = fullName;
        }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath;
    if (self.isFromNewsFeed) {
        [self performSegueWithIdentifier:@"groupInfo" sender:self];
    }else if(self.isFromMessage){
        [self performSegueWithIdentifier:@"sendNewMessage" sender:self];
    }else{
        [self performSegueWithIdentifier:@"addpeople" sender:self];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    OtherProfileViewController *otherVC = [segue destinationViewController];
    if([otherVC isKindOfClass:[OtherProfileViewController class]]){
        NSString *userID = [[self.queries objectAtIndex:self.selectedIndex.row] siteId];
        otherVC.userID = userID;
        otherVC.isFromSearchUser = YES;
        otherVC.grpIDString = self.grpIDString;
        otherVC.grpTitle = self.grpTitle;
    }else if ([[segue identifier] isEqualToString:@"groupInfo"]){
        GroupInfoViewController *groupInfo = [segue destinationViewController];
        groupInfo.isNewUser = YES;
        groupInfo.grpObj = [self.queries objectAtIndex:self.selectedIndex.row];
    }else if ([[segue identifier] isEqualToString:@"sendNewMessage"]){
        CreateNewMessageViewController *newMessageVC = [segue destinationViewController];
        newMessageVC.userObject = [self.queries objectAtIndex:self.selectedIndex.row];
    }
    
}

-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    self.userObj = [ownUser objectAtIndex:0];
}

-(void)onSuccessUsersQuery:(NSArray *)array{
    self.queries = [[NSMutableArray alloc] initWithArray:array];
    [self.tableView reloadData];
}

-(void) onSuccessGroupsQuery: (NSArray*) array{
    self.queries = [[NSMutableArray alloc] initWithArray:array];
    [self.tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        [self.queries removeAllObjects];
        [self.tableView reloadData];
    }else{
        if(self.isFromNewsFeed){
            [self.groupMng searchGroups:searchText];
        }else if(self.isFromMessage){
            [self.profileMng searchUsers:searchText];
        }else{
            [self.profileMng searchUsers:searchText];
            
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// to show or to hide keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    
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
                         self.searchBar.frame = CGRectMake(0, 20, self.searchBar.frame.size.width, self.searchBar.frame.size.height); //just some hard coded value

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
                         self.searchBar.frame = CGRectMake(0, 20, self.searchBar.frame.size.width, self.searchBar.frame.size.height); //just some hard coded value
                     }
                     completion:^(BOOL finished) {}];
    
}
// end


@end
