//
//  message.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/19/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "Message.h"

@implementation Message

-(id)initWithBody:(NSString *)body andTitle:(NSString *)title{
    
    [self setBody:body];
    [self setTitle:title];
    
    return self;
}

@end
