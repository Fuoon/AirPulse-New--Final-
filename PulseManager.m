//
//  PulseManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/8/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "PulseManager.h"

@interface PulseManager()

@property (nonatomic, copy) NSArray* pulseArr;

@end

@implementation PulseManager

- (void) createPulse:(Pulse *)pulse andGroupId: (NSInteger) groupId{
    
    NSDictionary *pulseDict = @{
                                @"pulse[title]":  [pulse title],
                                @"pulse[content]": [pulse content] ,
                                };
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[Credential class]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [objectManager postObject:pulse path:[NSString stringWithFormat:@"groups/%d/pulses?token=%@", groupId, [[SessionSingleton getSharedInstance] credential].token] parameters:pulseDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onSuccessPulsesCreation:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        [[self delegate] onSuccessPulsesCreation:false];
    }];
    

}

- (void)retrievePulses:(NSInteger) groupId {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Pulse class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title":   @"title",
                                                  @"content": @"content",
                                                  @"id" : @"siteId",
                                                  @"user_id": @"userId",
                                                  @"firstname": @"firstName",
                                                  @"lastname": @"lastName",
                                                  @"icon_id": @"iconId",
                                                  @"created_at": @"time"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@groups/%d/pulses.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],groupId ,[[[SessionSingleton getSharedInstance] credential] token]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self setPulseArr: [[NSArray alloc] initWithArray:[result array]]];
        [[self delegate] onSuccessPulsesRetrieval:self.pulseArr];
    } failure:nil];
    
    [operation start];

}

- (void)deletePulse:(NSInteger)pulseId and: (NSInteger) groupId {
      NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    [objectManager deleteObject:nil path:[NSString stringWithFormat:@"groups/%d/pulses/%d", groupId, pulseId] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onSuccessPulsesDeletion:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        [[self delegate] onSuccessPulsesDeletion:false];
    }];
    
    

}

@end
