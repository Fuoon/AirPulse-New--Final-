//
//  PulseManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/8/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SessionSingleton.h"
#import "Pulse.h"

#pragma mark - protocol

@protocol PulseManagerDelegate <NSObject>

@optional
-(void) onSuccessPulsesRetrieval: (NSArray*) pulses;
-(void) onSuccessPulsesCreation: (BOOL) success;
-(void) onSuccessPulsesDeletion: (BOOL) success;

@end

#pragma mark - interface
@interface PulseManager : NSObject

@property (nonatomic, assign) id<PulseManagerDelegate> delegate;

-(void) createPulse: (Pulse*) pulse andGroupId: (NSInteger) groupId;
-(void) retrievePulses: (NSInteger) groupId;
-(void) deletePulse: (NSInteger) pulseId and:(NSInteger) groupId;
@end
