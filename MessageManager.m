//
//  MessageManager.m
//  AirPulse
//
//  Created by Opal Thongpetch on 11/19/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import "MessageManager.h"
#import "SessionSingleton.h"

@interface MessageManager()
@property (nonatomic, assign) NSArray *messages;
@end

@implementation MessageManager

-(void) createMessage: (Message*) message and: (NSInteger) receiver_id {
    NSDictionary *messageDict = @{
                                  @"message[title]" : [message title],
                                @"message[body]":  [message body],
                                };
    
    NSURL* url = [[NSURL alloc] initWithString:[[SessionSingleton getSharedInstance] baseURL]];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:url];
    
    RKObjectMapping *noMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:noMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager postObject:nil path:[NSString stringWithFormat:@"messages?token=%@&receiver_id=%i", [[SessionSingleton getSharedInstance] credential].token, receiver_id] parameters:messageDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Some codes
        [[self delegate] onSuccessMessageCreation:true];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        [[self delegate] onSuccessMessageCreation:false];
    }];

}
-(void) retrieveMessages{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Message class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title":   @"title",
                                                  @"body": @"body",
                                                  @"sender_id": @"senderId",
                                                  @"receiver_id": @"receiverId",
                                                  @"sender_firstname": @"senderFirstName",
                                                  @"sender_lastname": @"senderLastName",
                                                  @"receiver_firstname": @"receiverFirstName",
                                                  @"receiver_lastname": @"receiverLastName",
                                                  @"sender_icon_id": @"senderIconId",
                                                  @"receiver_icon_id": @"receiverIconId",
                                                  @"created_at": @"time"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    NSString *token = [[[SessionSingleton getSharedInstance] credential] token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@messages.json?token=%@", [[SessionSingleton getSharedInstance] baseURL],token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        [self setMessages:[result array]];
        [[self delegate] onSuccessMesssagesRetrieval: self.messages];
    } failure:nil];
    
    [operation start];

}

@end
