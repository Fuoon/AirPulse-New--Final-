//
//  MessageCell.h
//  AirPulse
//
//  Created by Fuoon on 11/4/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherMessageCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UILabel *label;

-(void)setProfileImage:(UIImage *)profileImage;
-(void)setMessageAtIndex:(NSIndexPath *)index WithText:(NSString *)message;
-(void)setTime;

@end
