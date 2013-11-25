//
//  ImageViewController.h
//  AirPulse
//
//  Created by Fuoon on 11/21/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

@class ImageViewController;
@protocol imageViewDelegate <NSObject>

- (void)recieveProfileImage:(NSString *)image;

@end

#import <UIKit/UIKit.h>
#import "imageModel.h"

@interface ImageViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) id<imageViewDelegate>delegate;

@end
