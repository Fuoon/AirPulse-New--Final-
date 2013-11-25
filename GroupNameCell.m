//
//  CustomCell.m
//  GroupTable
//
//  Created by Ronnakrit Kunaviriyasiri on 10/30/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import "GroupNameCell.h"

@implementation GroupNameCell
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

-(void)setImage:(UIImage *)image{
    [self.groupImage setImage:image];
}

-(void)setName:(NSString *)groupName{
    self.groupName.text = groupName;
}

-(void)setDescription:(NSString *)groupDescription{
    self.groupDescription.text = groupDescription;
}

@end
