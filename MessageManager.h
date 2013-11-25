//
//  MessageManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/19/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Message.h"

@protocol MessageManagerDelegate <NSObject>

@optional
-(void) onSuccessMessageCreation:(BOOL) success;
-(void) onSuccessMesssagesRetrieval:(NSArray*) array;

@end

@interface MessageManager : NSObject
@property (nonatomic, assign) id <MessageManagerDelegate> delegate;
-(void) createMessage: (Message*) message and: (NSInteger) receiver_id;
-(void) retrieveMessages;
@end
