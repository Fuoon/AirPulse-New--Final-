//
//  message.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/19/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *siteId;
@property (nonatomic, copy) NSString *senderId;
@property (nonatomic, copy) NSString *receiverId;
@property (nonatomic, copy) NSString *senderFirstName;
@property (nonatomic, copy) NSString *senderLastName;
@property (nonatomic, copy) NSString *receiverFirstName;
@property (nonatomic, copy) NSString *receiverLastName;
@property (nonatomic, copy) NSString *senderIconId;
@property (nonatomic, copy) NSString *receiverIconId;
@property (nonatomic, copy) NSString *time;

-(id)initWithBody:(NSString *)body andTitle:(NSString *)title;

@end
