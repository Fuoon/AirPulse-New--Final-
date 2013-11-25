//
//  UserManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/19/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "ProfileManager.h"
#import "SessionSingleton.h"
@interface ProfileManager()

@property (nonatomic, copy) NSArray *userArr;

@end
@implementation ProfileManager

-(void) searchUsers: (NSString*) query{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"firstname":   @"firstName",
                                                  @"lastname": @"lastName",
                                                  @"id": @"siteId",
                                                  @"icon_id": @"iconId"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@profiles.json?token=%@&search=%@", [[SessionSingleton getSharedInstance] baseURL],token, query]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        [self setUserArr:[result array]];
        [[self delegate] onSuccessUsersQuery:self.userArr];
        
    } failure:nil];
    
    [operation start];

}

-(void) userUpdate:(User*) user andUserID:(NSInteger)userID
{
    NSDictionary *userDict = @{
                               @"profile[firstname]":   user.firstName,
                               @"profile[lastname]": user.lastName,
                               @"profile[icon_id]": user.iconId
                               };
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[Credential class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager patchObject:nil path:[NSString stringWithFormat:@"profiles/%i?token=%@", userID, [[SessionSingleton getSharedInstance] credential].token] parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [self.delegate onSuccessUserUpdate:YES];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.delegate onSuccessUserUpdate:NO];

    }];
    
}

-(void) getUserById: (NSInteger) userId {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"firstname":   @"firstName",
                                                  @"lastname": @"lastName",
                                                  @"email": @"email",
                                                  @"id": @"siteId",
                                                  @"icon_id": @"iconId"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@profiles/%i.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],userId, token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        [self setUserArr:[result array]];
        [[self delegate] onSuccessUserRetrieval:self.userArr];
        
    } failure:nil];
    
    [operation start];
    
}

-(void) getOwnUser{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"firstname":   @"firstName",
                                                  @"lastname": @"lastName",
                                                  @"id": @"siteId",
                                                  @"email": @"email",
                                                  @"icon_id": @"iconId"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@profiles.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        [self setUserArr:[result array]];
        [[self delegate] onSuccessOwnUserRetrival:self.userArr];
        
    } failure:nil];
    
    [operation start];
    
}

@end
