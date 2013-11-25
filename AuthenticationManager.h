//
//  AuthenticationManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/10/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionSingleton.h"
#import "Credential.h"

@protocol AuthenticationManagerDelegate <NSObject>

@optional

-(void) onSuccessAuthentication: (BOOL) success;
-(void) onSuccessDestroySession: (BOOL) success;


@end
@interface AuthenticationManager : NSObject
@property (nonatomic, assign) id<AuthenticationManagerDelegate> delegate;

- (void) authenticate: (NSString*) email and: (NSString*) password;
- (void) destroySession;
@end
