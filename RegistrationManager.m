//
//  RegistrationManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/16/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "RegistrationManager.h"

@implementation RegistrationManager

-(void) createAccount: (NSString*) email andPassword: (NSString*) password andUserProfile: (User*) profile {
    NSDictionary *accountDict = @{
                                @"user[email]":  email,
                                @"user[password]": password,
                                @"profile[firstname]": [profile firstName],
                                @"profile[lastname]" : [profile lastName],
                                @"profile[icon_id]": [profile iconId]
                                };
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager postObject:nil path:[NSString stringWithFormat:@"users"] parameters:accountDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onSuccessAccountCreation:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[self delegate] onSuccessAccountCreation:false];
    }];
}

@end
