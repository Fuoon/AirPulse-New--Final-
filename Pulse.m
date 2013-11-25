//
//  Article.m
//  AirPulse
//
//  Created by Opal Thongpetch on 10/11/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "Pulse.h"


@implementation Pulse

-(id)initWithTitle:(NSString *)title andContent:(NSString *)content{
    
    [self setTitle:title];
    [self setContent:content];
    
    return self;
}

-(id)initWithTitle:(NSString *)title andContent:(NSString *)content andFirstName:(NSString *)fname andLastName:(NSString *)lname{
    
    [self setTitle:title];
    [self setContent:content];
    [self setFirstName:fname];
    [self setLastName:lname];
    
    return self;
}

@end
