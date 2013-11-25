//
//  imageModel.m
//  AirPulse
//
//  Created by Fuoon on 11/22/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "imageModel.h"

@implementation imageModel

-(id)initWithName:(NSString *)imagename{
    if(self){
        self.imageName = imagename;
        self.image = [UIImage imageNamed:self.imageName];
        NSRange endRange = [imagename rangeOfString:@"."];
        NSRange searchRange = NSMakeRange(0, endRange.location);
        self.imageId = [imagename substringWithRange:searchRange];
    }
    return self;
}

-(id)initWithID:(NSString *)imageID{
    self.imageId = imageID;
    self.imageName = [NSString stringWithFormat:@"%@.png", imageID];
    self.image = [UIImage imageNamed:self.imageName];
    return self;
}

@end
