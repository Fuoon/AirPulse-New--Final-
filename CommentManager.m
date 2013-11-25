//
//  CommentManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/10/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "CommentManager.h"

@interface CommentManager()

@property (strong, nonatomic) NSArray *pulseArr;

@end

@implementation CommentManager

-(void) createComment: (Comment*) comment andPulseId: (NSInteger) pulseId{
    NSDictionary *commentDict = @{
                                  @"comment[content]": [comment content] ,
                                    };
    NSURL *url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[Credential class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];

    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager postObject:comment path:[NSString stringWithFormat:@"pulses/%d/comments?token=%@", pulseId, [[SessionSingleton getSharedInstance] credential].token] parameters:commentDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        [[self delegate] onSuccessCommentCreation:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        [[self delegate] onSuccessCommentCreation:false];
        
    }];
    

}

-(void) retrieveComments: (NSInteger) pulseId {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Comment class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"content":   @"content",
                                                  @"id": @"siteId",
                                                  @"firstname": @"firstName",
                                                  @"lastname": @"lastName",
                                                  @"icon_id": @"iconId",
                                                  @"user_id": @"userId",
                                                  @"created_at": @"time"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@pulses/%d/comments.json?token=%@", [[SessionSingleton getSharedInstance] baseURL], pulseId, token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        [self setPulseArr:[[NSArray alloc] initWithArray:[result array]]];
        [[self delegate] onSuccessCommentsRetrieval:self.pulseArr];
        
    } failure:nil];
    
    [operation start];

}

-(void) deleteComment: (NSInteger) commentId{
    
}

@end
