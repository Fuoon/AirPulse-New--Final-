//
//  Comment.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/8/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Comment : NSObject

@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* siteId;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* iconId;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) User* author;
@property (nonatomic, copy) NSString* time;
-(id)initWithContent:(NSString *)content;

@end
