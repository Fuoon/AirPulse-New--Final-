//
//  UserManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/19/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "User.h"

@protocol ProfileManagerDelegate <NSObject>

@optional
-(void) onSuccessUsersQuery: (NSArray*) array;
-(void) onSuccessUserRetrieval: (NSArray*) users;
-(void) onSuccessOwnUserRetrival: (NSArray *)ownUser;
-(void) onSuccessUserUpdate:(BOOL)success;

@end

@interface ProfileManager : NSObject

@property (nonatomic, assign) id <ProfileManagerDelegate> delegate;
-(void) searchUsers: (NSString*) query;
-(void) getUserById: (NSInteger) userId;
-(void) getOwnUser;
-(void) userUpdate:(User*) user andUserID:(NSInteger)userID;
@end
