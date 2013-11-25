//
//  CustomCell.m
//  commentTest
//
//  Created by Ronnakrit Kunaviriyasiri on 10/29/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleLabel:(NSString *)title{
    self.title.text = title;
}

-(void)setNameLabel:(NSString *)name{
    self.name.text = name;
    self.name.textColor = [UIColor grayColor];
}

-(void)setCurrentDate:(NSString *)time{
    //2013-11-21T21:46:48.321Z
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
        self.date.text = hourMinute;
    }else{
        self.date.text = dayMonthYear;
    }
//    self.date.text = [nameDate description];
    self.date.font = [UIFont fontWithName:@"Arial" size:9.0f];
    self.date.textColor = [UIColor grayColor];
}

-(void)setImage:(UIImage *)image{
    [self.iconImage setImage:image];
}

-(void)setTextInCellAtIndex:(NSIndexPath *)index WithText:(NSString *)textincell{
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 55, 305, 33)];
    [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:textincell
     attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:14.0f]}];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(305, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               context:nil];
    CGSize size = rect.size;
    CGFloat height = ceil(size.height+17);
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 305, height);
    
    [self.contentView addSubview:textView];
    
    [textView setTag:20];
    //[textView setTag:index.row];
    textView.text = textincell;
    textView.scrollsToTop = YES;
    textView.textColor=[UIColor blackColor];
    textView.editable=NO;
    textView.scrollEnabled = NO;
    self.commentView.center = CGPointMake(160, self.contentView.frame.size.height - 16.5);

}

@end
