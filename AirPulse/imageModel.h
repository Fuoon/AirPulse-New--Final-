//
//  imageModel.h
//  AirPulse
//
//  Created by Fuoon on 11/22/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageModel : NSObject

@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *image;
-(id)initWithName:(NSString *)imagename;
-(id)initWithID:(NSString *)imageID;

@end
