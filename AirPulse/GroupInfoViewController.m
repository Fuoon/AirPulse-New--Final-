//
//  GroupInfoViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/20/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "GroupInfoViewController.h"

@interface GroupInfoViewController ()

@property (strong, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *desCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *creatorCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cancelCell;

@end

@implementation GroupInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    [SVProgressHUD dismiss];
    if([[self.grpObj creatorId] isEqualToString:[[ownUser objectAtIndex:0] siteId]]){
        [self.descriptionCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        self.deleteCell.textLabel.text = @"Delete Group";
        [self.deleteCell setBackgroundColor:[UIColor redColor]];
        [self setIsCreator:YES];
    }else{
        if (self.isNewUser) {
            self.deleteCell.textLabel.text = @"Join Group";
            [self.deleteCell setBackgroundColor:[UIColor greenColor]];
        }else{
            self.deleteCell.textLabel.text = @"Leave Group";
            [self.deleteCell setBackgroundColor:[UIColor redColor]];
            [self setIsCreator:NO];
        }
    }
}

-(void) onSuccessUserRetrieval: (NSArray*) users{
    [SVProgressHUD dismiss];
    self.creatorObj = [users objectAtIndex:0];
    NSString *name = [NSString stringWithFormat:@"%@ %@", [self.creatorObj firstName], [self.creatorObj lastName]];
    self.creatorCell.textLabel.text = name;
}

-(void)onSuccessGroupDeletion:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Delete Group Failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}
-(void)onMembershipDeletionSuccess:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Leave Group Failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}
-(void)onMembershipCreationSuccess:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Join Group Failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.profileMng = [ProfileManager new];
    [self.profileMng setDelegate:self];
    [self.profileMng getUserById:[[self.grpObj creatorId] intValue]];
    [self.profileMng getOwnUser];
    
    self.groupMgr = [GroupManager new];
    [self.groupMgr setDelegate:self];
    
    self.memberMgr = [MembershipManager new];
    [self.memberMgr setDelegate:self];
    
    self.titleCell.textLabel.text = [self.grpObj title];
    self.desCell.textLabel.text = [self.grpObj description];
    self.imageObj = [[imageModel alloc] initWithID:[self.grpObj iconId]];
    [self.profileImage.imageView setImage:self.imageObj.image];
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.isCreator) {
//        [self.descriptionCell setAccessoryType:UITableViewCellAccessoryNone];
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            if(!self.isNewUser){
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            if (self.isCreator) {
                [self.groupMgr deleteGroup:[[self.grpObj siteId] intValue]];
            }else{
                if (self.isNewUser) {
                    [self.memberMgr createMembership:[[self.grpObj siteId] intValue]];
                }else{
                    [self.memberMgr deleteMembership:[[self.grpObj siteId] intValue]];
                }
            }
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 1) {
            if (self.isCreator) {
                [self performSegueWithIdentifier:@"editDescription" sender:self];
            }else{
                [self.descriptionCell setAccessoryType:UITableViewCellAccessoryNone];
            }
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)imageBtn:(id)sender {
    [self performSegueWithIdentifier:@"changeImage" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ImageViewController *imageVC = [segue destinationViewController];
    DescriptionViewController *desVC = [segue destinationViewController];
    if ([imageVC isKindOfClass:[ImageViewController class]]) {
        imageVC.delegate = self;
    }else if([desVC isKindOfClass:[DescriptionViewController class]]){
        desVC.delegate = self;
        desVC.groupObj = self.grpObj;
    }
}
-(void)recieveProfileImage:(NSString *)image{
    imageModel *profileimg = [[imageModel alloc] initWithName:image];
    [self.profileImage.imageView setImage:profileimg.image];
    [self.grpObj setIconId:profileimg.imageId];
    [self.groupMgr groupUpdate:self.grpObj andGroupID:self.grpObj.siteId.intValue];
}
-(void)receiveDescription:(NSString *)description{
    self.desCell.textLabel.text = description;
}
-(void)onSuccessGroupUpdate:(BOOL)success{
    if (success) {
    }else{
        NSLog(@"error");
    }
}
@end
