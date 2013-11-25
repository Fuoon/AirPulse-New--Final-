//
//  CustomCell.h
//  GroupTable
//
//  Created by Ronnakrit Kunaviriyasiri on 10/30/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNameCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *groupImage;
@property (strong, nonatomic) IBOutlet UILabel *groupName;
@property (strong, nonatomic) IBOutlet UILabel *groupDescription;
-(void)setImage:(UIImage *)image;
-(void)setName:(NSString *)groupName;
-(void)setDescription:(NSString *)groupDescription;

@end
