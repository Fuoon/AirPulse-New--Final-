//
//  GroupManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/7/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SessionSingleton.h"
#import "Group.h"

#pragma mark - protocol

@protocol GroupManagerDelegate <NSObject>

@optional
-(void) onSuccessGroupsQuery: (NSArray*) array;
-(void) onSuccessGroupsRetrieval :(NSArray*) array;
-(void) onSuccessGroupCreation: (BOOL) success;
-(void) onSuccessGroupDeletion: (BOOL) success;
-(void) onSuccessGroupUpdate: (BOOL) success;
@end

#pragma mark - interface
@interface GroupManager : NSObject

@property (nonatomic, assign) id<GroupManagerDelegate> delegate;

-(void) createGroup: (Group*) group;
-(void) retrieveGroups;
-(void) deleteGroup: (NSInteger) groupId;
-(void)searchGroups: (NSString*) query;
-(void) groupUpdate:(Group*) group andGroupID:(NSInteger)groupID;

@end

