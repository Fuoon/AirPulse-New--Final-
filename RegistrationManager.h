//
//  RegistrationManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/16/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SessionSingleton.h"
#import "User.h"
@protocol RegistrationManagerDelegate <NSObject>

@optional

-(void) onSuccessAccountCreation :(BOOL) success;

@end

@interface RegistrationManager : NSObject

@property (nonatomic, assign) id<RegistrationManagerDelegate> delegate;

-(void) createAccount: (NSString*) email andPassword: (NSString*) password andUserProfile: (User*) profile;
@end
