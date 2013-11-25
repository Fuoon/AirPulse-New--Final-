//
//  GroupManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/7/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//


#import "GroupManager.h"

@interface GroupManager()

@property (nonatomic, copy) NSArray *groupArr;
@property (nonatomic, copy) NSArray *groupQueryArr;
@end

@implementation GroupManager

-(void) createGroup:(Group *)group
{
    NSDictionary *groupDict = @{
                                @"group[title]":  [group title],
                                @"group[description]": [group description],
                                @"group[icon_id]": [group iconId]
                                };

    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[Credential class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];

    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager postObject:group path:[NSString stringWithFormat:@"groups?token=%@", [[SessionSingleton getSharedInstance] credential].token] parameters:groupDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onSuccessGroupCreation:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        [[self delegate] onSuccessGroupCreation:false];
    }];

}


-(void) groupUpdate:(Group*) group andGroupID:(NSInteger)groupID
{
    NSDictionary *groupDict = @{
                               @"group[title]":   group.title,
                               @"group[description]": group.description,
                               @"group[icon_id]": group.iconId
                               };
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager patchObject:nil path:[NSString stringWithFormat:@"groups/%i?token=%@", groupID, [[SessionSingleton getSharedInstance] credential].token] parameters:groupDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        [[self delegate] onSuccessGroupUpdate:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[self delegate] onSuccessGroupUpdate:true];

        
    }];
    
}

-(void) retrieveGroups
{

    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Group class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title":   @"title",
                                                  @"description": @"description",
                                                  @"url": @"url",
                                                  @"id": @"siteId",
                                                  @"creator_id": @"creatorId",
                                                  @"icon_id": @"iconId"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@groups.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self setGroupArr: [[NSArray alloc] initWithArray:[result array]]];
        
        [[self delegate] onSuccessGroupsRetrieval:self.groupArr];
    } failure:nil];
    
    [operation start];
}

-(void)searchGroups: (NSString*) query
{
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Group class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title":   @"title",
                                                  @"description": @"description",
                                                  @"url": @"url",
                                                  @"id": @"siteId",
                                                  @"icon_id": @"iconId",
                                                  @"creator_id": @"creatorId"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@groups.json?token=%@&search=%@", [[SessionSingleton getSharedInstance] baseURL],token, query]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self setGroupQueryArr:[[NSArray alloc] initWithArray:[result array]]];
        
        [[self delegate] onSuccessGroupsQuery:self.groupQueryArr];
    } failure:nil];
    
    [operation start];
}

-(void) deleteGroup:(NSInteger) groupId
{
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[Credential class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager deleteObject:nil path:[NSString stringWithFormat:@"groups/%i?token=%@", groupId, [[SessionSingleton getSharedInstance] credential].token] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onSuccessGroupDeletion:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        [[self delegate] onSuccessGroupDeletion:false];
    }];

}

@end

