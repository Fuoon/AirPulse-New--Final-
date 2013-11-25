//
//  CommentManager.h
//  AirPulse
//
//  Created by Opal Thongpetch on 11/10/13.
//  Copyright (c) 2013 Opal Thongpetch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SessionSingleton.h"
#import "Comment.h"

#pragma mark - protocol

@protocol CommentManagerDelegate <NSObject>

@optional
-(void) onSuccessCommentsRetrieval: (NSArray*) comments;
-(void) onSuccessCommentCreation: (BOOL) success;
-(void) onSuccessCommentDeletion:(BOOL) success;

@end

#pragma mark - interface

@interface CommentManager : NSObject
@property (nonatomic, assign) id<CommentManagerDelegate> delegate;

-(void) retrieveComments: (NSInteger) pulseId;
-(void) createComment: (Comment*)  comment andPulseId: (NSInteger) pulseId;
-(void) deleteComment: (NSInteger) commentId;
@end
