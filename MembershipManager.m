//
//  MembershipManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/16/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "MembershipManager.h"

@interface MembershipManager()

@property (nonatomic, copy) NSArray* array;

@end

@implementation MembershipManager

-(void) createMembership: (NSInteger) groupId{

    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager postObject:nil path:[NSString stringWithFormat:@"groups/%d/memberships?token=%@", groupId, [[SessionSingleton getSharedInstance] credential].token] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onMembershipCreationSuccess:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[self delegate] onMembershipCreationSuccess:false];
    }];

}

-(void) deleteMembership: (NSInteger) groupId{
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[Credential class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager deleteObject:nil path:[NSString stringWithFormat:@"groups/%i/memberships/1?token=%@", groupId, [[SessionSingleton getSharedInstance] credential].token] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onMembershipDeletionSuccess:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[self delegate] onMembershipDeletionSuccess:false];
    }];
    

}

-(void) retrieveMembershipsByGroup: (NSInteger) groupId {
    
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id" : @"siteId",
                                                  @"firstname": @"firstName",
                                                  @"lastname": @"lastName",
                                                  @"icon_id": @"iconId",
                                                  @"email": @"email"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@groups/%i.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],groupId ,[[[SessionSingleton getSharedInstance] credential] token]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self setArray: [[NSArray alloc] initWithArray:[result array]]];
        [[self delegate] onMembershipRetrieveSuccess:self.array];
    } failure:nil];
    
    [operation start];

}


@end
