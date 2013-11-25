//
//  MembershipManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/16/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SessionSingleton.h"

@protocol MembershipManagerDelegate <NSObject>

@optional
-(void) onMembershipCreationSuccess: (BOOL) success;
-(void) onMembershipDeletionSuccess: (BOOL) success;
-(void) onMembershipRetrieveSuccess: (NSArray *) array;

@end

@interface MembershipManager : NSObject
@property (nonatomic, assign) id<MembershipManagerDelegate> delegate;

-(void) createMembership: (NSInteger) groupId;
-(void) deleteMembership: (NSInteger) groupId;
-(void) retrieveMembershipsByGroup: (NSInteger) groupId;

@end
