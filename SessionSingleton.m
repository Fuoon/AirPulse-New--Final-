//
//  SessionManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/10/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "SessionSingleton.h"

@implementation SessionSingleton

+ (SessionSingleton*) getSharedInstance {
    static SessionSingleton *_sharedInstance = nil;
//    static SessionSingleton *_sharedInstance;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SessionSingleton alloc]init];
        //192.168.43.94:3000
        //http://airpulse.heroku.com/
        [_sharedInstance setBaseURL:@"http://192.168.43.94:3000/"];
    });
    
    return _sharedInstance;
}

- (void)setCredential:(Credential *)credential{
    _credential = credential;
}

- (void)setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
}

@end
