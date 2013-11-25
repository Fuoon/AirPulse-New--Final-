//
//  CreateNewMessageViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/23/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "CreateNewMessageViewController.h"

@interface CreateNewMessageViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;

@end

@implementation CreateNewMessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onSuccessOwnUserRetrival:(NSArray *)ownUser{
    self.userObj = [ownUser objectAtIndex:0];
    if ([[self.userObj siteId] isEqualToString:[self.userObject receiverId]]) {
        NSString *name = [NSString stringWithFormat:@"%@ %@", [self.userObject senderFirstName], [self.userObject senderLastName]];
        self.nameLabel.textLabel.text = name;

    }else{
        NSString *name = [NSString stringWithFormat:@"%@ %@", [self.userObject receiverFirstName], [self.userObject receiverLastName]];
        self.nameLabel.textLabel.text = name;

    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.MsgMng = [MessageManager new];
    [self.MsgMng setDelegate:self];
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    [self.profileMgr getOwnUser];
    
    [self.messageTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.messageTextView.layer setBorderWidth:1];
    [self.messageTextView.layer setCornerRadius:5.0];
    [self.titleTextField.layer setBorderWidth:1];
    [self.titleTextField.layer setCornerRadius:5.0];
    [self.titleTextField.layer setBorderColor:[[UIColor lightGrayColor] CGColor] ];
    [self.cancelBtn.layer setBorderWidth:1];
    [self.cancelBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.cancelBtn.layer setCornerRadius:5];
    [self.sendBtn.layer setCornerRadius:5];
    [self.sendBtn.layer setBorderWidth:1];
    [self.sendBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.nameCell.layer setBorderWidth:1];
    [self.nameCell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    //[self.cancelBtn.layer setCornerRadius:5];

    
    [self hideEmptySeparators];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard{
    [self.messageTextView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
}

-(void)onSuccessMessageCreation:(BOOL)success{
    [SVProgressHUD dismiss];
    if (success) {
        if (self.isFromMessageContent) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send a message" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)sendBtn:(id)sender {
    if (self.titleTextField.text.length > 0 && self.messageTextView.text.length > 0) {
        [SVProgressHUD showWithStatus:@"Loading"];
        Message *message = [[Message alloc] initWithBody:self.messageTextView.text andTitle:self.titleTextField.text];
        [self.MsgMng createMessage:message and:[[self.userObject siteId] intValue]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Title and Message is required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)cancelBtn:(id)sender {
    if (self.isFromMessageContent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

// when click return or anywhere on the screen to hide keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.titleTextField resignFirstResponder];
    return YES;
}
-(BOOL)textViewShouldReturn:(UITextView *)textView{
    [self.messageTextView resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.messageTextView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
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
@end
