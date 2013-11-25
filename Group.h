//
//  Group.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/7/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, copy) NSString* siteId;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* creatorId;
@property (nonatomic, copy) NSString* iconId;

@end
