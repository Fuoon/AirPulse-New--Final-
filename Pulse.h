//
//  Article.h
//  AirPulse
//
//  Created by Opal Thongpetch on 10/11/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Pulse : NSObject

@property (nonatomic, copy) NSString *siteId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString  *userId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *iconId;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) User* author;
-(id)initWithTitle:(NSString *)title andContent:(NSString *)content;
-(id)initWithTitle:(NSString *)title andContent:(NSString *)content andFirstName:(NSString *)fname andLastName:(NSString *)lname;
@end
