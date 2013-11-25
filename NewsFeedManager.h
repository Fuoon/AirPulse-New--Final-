//
//  NewsFeedManager.h
//  AirPulse
//
//  Created by Fuoon on 11/20/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SessionSingleton.h"
#import "Pulse.h"

@protocol NewsFeedManagerDelegate <NSObject>

@optional

-(void) onSuccessNewsFeedRetrieval: (NSArray*) pulses;

@end

@interface NewsFeedManager : NSObject

@property (nonatomic, assign) id<NewsFeedManagerDelegate> delegate;
- (void)retrieveNewsFeed;

@end
