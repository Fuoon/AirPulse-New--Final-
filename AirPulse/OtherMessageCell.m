//
//  MessageCell.m
//  AirPulse
//
//  Created by Fuoon on 11/4/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "OtherMessageCell.h"

@implementation OtherMessageCell

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

-(void)setProfileImage:(UIImage *)profileImage{
    self.image.image = profileImage;
}
-(void)setTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:9.0f];
    self.label.text = [currentDate description];
}
-(void)setMessageAtIndex:(NSIndexPath *)index WithText:(NSString *)message{
    //----------------TextView field
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 10, 240, 30)];
    [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:14.0f]}];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(240, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               context:nil];
    CGSize size = rect.size;
    CGFloat height = ceil(size.height + 17);
    NSLog(@"%f", height);
    
    [textView setBackgroundColor:[UIColor redColor]];
    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 240, height);
    [self.contentView addSubview:textView];
    
    [textView setTag:index.row];
    textView.text = message;
    textView.scrollsToTop = YES;
    textView.textColor=[UIColor blackColor];
    textView.editable=NO;
    textView.scrollEnabled = NO;
    [self setTime];
    
}
@end
