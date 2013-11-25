//
//  SessionManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/10/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Credential.h"
#import "User.h"

@interface SessionSingleton : NSObject

@property (nonatomic, retain) User* currentUser;
@property (nonatomic, retain) Credential* credential;
@property (nonatomic, retain) NSString *baseURL;

+ (SessionSingleton*) getSharedInstance;

- (void)setCredential:(Credential *)credential;
- (void)setCurrentUser:(User *)currentUser;

@end
