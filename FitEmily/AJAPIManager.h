//
//  SPApiManager.h
//  Spreadeo
//
//  Created by Aaven Jin on 6/14/14.
//  Copyright (c) 2014 Spreadeo. All rights reserved.
//

#import <Parse/Parse.h>

static NSString *const AJAuthFailNotif = @"AuthFailNotif";
static CGFloat const AJTimeoutInterval = 10.0;

@interface AJAPIManager : NSObject

/**
 Creates a "AJAPIManager" singleton.
 
 @return The newly-created AJAPIManager singleton
 */
+ (AJAPIManager *)sharedManager;

/**
 Registers with username and password.
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the auth token.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a one argument: the error describing the network or parsing error that occurred.
 */
- (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                     success:(void (^)())success
                     failure:(void (^)(NSString *))failure;

/**
 Logs in with username and password.
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the auth token.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a one argument: the error describing the network or parsing error that occurred.
 */
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)())success
                  failure:(void (^)(NSString *))failure;
/**
 Fetches
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: an response array of task dictionaries.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a one argument: the error describing the network or parsing error that occurred.
 */
- (void)fetchWorkoutsInGroup:(PFObject *)group
                     success:(void (^)(NSArray *))success
                     failure:(void (^)())failure;

@end
