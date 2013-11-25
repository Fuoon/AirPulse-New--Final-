//
//  AuthenticationManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/10/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "AuthenticationManager.h"

@implementation AuthenticationManager

-(void) authenticate:(NSString *)email and:(NSString *)password {
    NSDictionary *credential = @{
                                @"user[email]":  email,
                                @"user[password]": password ,
                                };
    
    NSURL* url = [[NSURL alloc] initWithString: [[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *credentialMapping = [RKObjectMapping mappingForClass:[Credential class]];
    [credentialMapping addAttributeMappingsFromDictionary:@{
                                                  @"token":   @"token",
                                                  @"user_email": @"user_email",
                                                  }];

    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:credentialMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager postObject:nil path:@"users/sign_in" parameters:credential success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        Credential *credential = [[mappingResult array] objectAtIndex:0];
        NSLog(@"token = %@", credential.token);
        [[SessionSingleton getSharedInstance] setCredential:credential];
        NSLog(@"token == %@", [[SessionSingleton getSharedInstance] credential].token);
        [[self delegate] onSuccessAuthentication:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[self delegate] onSuccessAuthentication:false];
    }];
}

-(void) destroySession {
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKMapping *emptyMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:emptyMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager deleteObject:nil path:@"users/sign_out" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [[self delegate] onSuccessDestroySession:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[self delegate] onSuccessDestroySession:false];
    }];

}

@end
