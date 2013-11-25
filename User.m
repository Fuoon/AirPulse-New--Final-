//
//  User.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/7/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andIcon:(NSString *)iconId{
    
    [self setFirstName:firstName];
    [self setLastName:lastName];
    [self setIconId:iconId];
    
    return self;
}

-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName{
    
    [self setFirstName:firstName];
    [self setLastName:lastName];
    
    return self;
}

@end
