//
//  OtherProfileViewController.m
//  AirPulse
//
//  Created by Ronnakrit Kunaviriyasiri on 11/6/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "OtherProfileViewController.h"

@interface OtherProfileViewController ()

@property (strong, nonatomic) NSIndexPath *selectedIndex;

@end

@implementation OtherProfileViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessUserRetrieval:(NSArray *)users{
    [SVProgressHUD dismiss];
    self.userObj = [users objectAtIndex:0];
    self.firstNameLabel.text = self.userObj.firstName;
    self.lastNameLabel.text = self.userObj.lastName;
    self.emailLabel.text = self.userObj.email;
    self.imageObj = [[imageModel alloc] initWithID:[self.userObj iconId]];
    self.profileImg.image = [self.imageObj image];
}

-(void)onSuccessUsersQuery:(NSArray *)array{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profileMng = [ProfileManager new];
    [self.profileMng setDelegate:self];
    [self.profileMng getUserById:[self.userID intValue]];
    
    self.messageMgr = [MessageManager new];
    [self.messageMgr setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(!self.isFromSearchUser){
        return 1;
    }else{
        return 2;
    }
}

-(void)onSuccessMessageCreation:(BOOL)success{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath;
    if (indexPath.section == 1) {
        if(indexPath.row == 0){
            NSString *body = [NSString stringWithFormat:@"The invitation of ''%@'' group. Please kindly accept.", self.grpTitle];
            Message *message = [[Message alloc] initWithBody:body andTitle:@"Invitation"];
            [self.messageMgr createMessage:message and:[self.userID intValue]];
        }
        else{
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}



@end
