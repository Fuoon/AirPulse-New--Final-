//
//  CommentCell.m
//  commentTest
//
//  Created by Ronnakrit Kunaviriyasiri on 11/4/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        self.date.text = hourMinute;
    }else{
        self.date.text = dayMonthYear;
    }
    self.date.font = [UIFont fontWithName:@"Arial" size:9.0f];
    self.date.textColor = [UIColor grayColor];
}

-(void)setImage:(UIImage *)image{
    [self.iconImage setImage:image];
}

-(void)setNameLabel:(NSString *)name{
    self.name.text = name;
}


-(void)setTextInCellAtIndex:(NSIndexPath *)index WithText:(NSString *)textincell{
    //----------------TextView field
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(59, 28, 250, 33)];
    [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:textincell
     attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:14.0f]}];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(250, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               context:nil];
    CGSize size = rect.size;
    CGFloat height = ceil(size.height+17);
    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 250, height);
    
    [self.contentView addSubview:textView];
    
    [textView setTag:index.row];
    textView.text = textincell;
    textView.scrollsToTop = YES;
    textView.textColor=[UIColor blackColor];
    textView.editable=NO;
    textView.scrollEnabled = NO;
}

@end
