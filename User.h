//
//  User.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/7/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString* siteId;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *iconId;
-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName;
-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andIcon:(NSString *)iconId;

@end
