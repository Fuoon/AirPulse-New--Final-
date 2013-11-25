///Users/Fuoon/Documents/X Code/AirPulse-New/NewsFeedManager.m
//  NewsFeedManager.m
//  AirPulse
//
//  Created by Fuoon on 11/20/2556 BE.
//  Copyright (c) 2556 Fuoon. All rights reserved.
//

#import "NewsFeedManager.h"

@interface NewsFeedManager()

@property (nonatomic, copy) NSArray *newsFeedArr;

@end

@implementation NewsFeedManager

- (void)retrieveNewsFeed{
    
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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@newsfeed.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],[[[SessionSingleton getSharedInstance] credential] token]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        [self setNewsFeedArr: [[NSArray alloc] initWithArray:[result array]]];
        [[self delegate] onSuccessNewsFeedRetrieval:self.newsFeedArr];
        
    } failure:nil];
    
    [operation start];
    
}


@end
