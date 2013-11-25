//
//  CustomCell.h
//  commentTest
//
//  Created by Ronnakrit Kunaviriyasiri on 10/29/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
-(void)setTitleLabel:(NSString *)name;
-(void)setTextInCellAtIndex:(NSIndexPath *)index WithText:(NSString *)textincell;
-(void)setImage:(UIImage *)image;
-(void)setNameLabel:(NSString *)name;
-(void)setCurrentDate:(NSString *)time;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (nonatomic) CGRect commentSize;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (strong, nonatomic) IBOutlet UILabel *name;


@end
