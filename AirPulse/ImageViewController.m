//
//  ImageViewController.m
//  AirPulse
//
//  Created by Fuoon on 11/21/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()



@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.images = [[NSMutableArray alloc] initWithObjects: @"0.png", @"1.png", @"2.png", @"3.png", @"4.png", @"5.png", @"6.png", @"7.png", @"8.png", @"9.png", @"10.png", @"11.png", @"12.png", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.images count];
}
- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:1];
    recipeImageView.image = [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
    [cell.layer setCornerRadius:20];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate recieveProfileImage:[self.images objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
