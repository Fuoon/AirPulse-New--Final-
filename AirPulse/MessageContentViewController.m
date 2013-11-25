//
//  MessageContentViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/23/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "MessageContentViewController.h"

@interface MessageContentViewController ()

@end

@implementation MessageContentViewController

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
    
    if ([[self.userObj siteId] isEqualToString:[self.messageObj receiverId]]) {
        self.messageImage = [[imageModel alloc] initWithID:[self.messageObj senderIconId]];
        self.imageView.image = [self.messageImage image];
        self.messageTitle.text = [self.messageObj title];
        NSString *name = [NSString stringWithFormat:@"%@ %@", [self.messageObj senderFirstName], [self.messageObj senderLastName]];
        self.messageName.text = name;
        [self setCurrentDate:[self.messageObj time]];
        self.contentTextView.text = [self.messageObj body];
    }else{
        self.messageImage = [[imageModel alloc] initWithID:[self.messageObj receiverIconId]];
        self.imageView.image = [self.messageImage image];
        self.messageTitle.text = [self.messageObj title];
        NSString *name = [NSString stringWithFormat:@"%@ %@", [self.messageObj receiverFirstName], [self.messageObj receiverLastName]];
        self.messageName.text = name;
        [self setCurrentDate:[self.messageObj time]];
        self.contentTextView.text = [self.messageObj body];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.messageMgr = [MessageManager new];
    [self.messageMgr setDelegate:self];
    self.profileMgr = [ProfileManager new];
    [self.profileMgr setDelegate:self];
    [self.profileMgr getOwnUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)replyBtn:(id)sender {
    [self performSegueWithIdentifier:@"replyMessage" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"replyMessage"]) {
        CreateNewMessageViewController *createMessageVC = [segue destinationViewController];
        createMessageVC.userObject = self.messageObj;
        createMessageVC.isFromMessageContent = YES;
    }
}

-(void)setCurrentDate:(NSString *)time{
    NSRange searchRangeYear = NSMakeRange(0, 4);
    NSString *year = [time substringWithRange:searchRangeYear];
    
    NSRange searchRangeMonth = NSMakeRange(5, 2);
    NSString *month = [time substringWithRange:searchRangeMonth];
    
    NSRange searchRangeDay = NSMakeRange(8, 2);
    NSString *day = [time substringWithRange:searchRangeDay];
    
    NSRange searchRangeHour = NSMakeRange(11, 2);
    NSString *hour = [time substringWithRange:searchRangeHour];
    
    
    NSRange searchRangeMinute = NSMakeRange(14, 2);
    NSString *minute = [time substringWithRange:searchRangeMinute];
    
    NSString *dayMonthYear = [NSString stringWithFormat:@"%@/%@/%@", day, month, year];
    NSString *hourMinute = [NSString stringWithFormat:@"%@:%@", hour, minute];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *todayDate = [formatter stringFromDate:[NSDate date]];
    
    if ([todayDate isEqualToString:dayMonthYear]) {
        self.messageDate.text = hourMinute;
    }else{
        self.messageDate.text = dayMonthYear;
    }
    self.messageDate.font = [UIFont fontWithName:@"Arial" size:9.0f];
    self.messageDate.textColor = [UIColor grayColor];
}

@end
