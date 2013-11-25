//
//  CommentCell.h
//  commentTest
//
//  Created by Ronnakrit Kunaviriyasiri on 11/4/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) NSString *label;
-(void)setNameLabel:(NSString *)name;
-(void)setTextInCellAtIndex:(NSIndexPath *)index WithText:(NSString *)textincell;
-(void)setImage:(UIImage *)image;
-(void)setCurrentDate:(NSString *)time;
@end
