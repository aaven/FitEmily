//
//  SPApiManager.m
//  Spreadeo
//
//  Created by Aaven Jin on 6/14/14.
//  Copyright (c) 2014 Spreadeo. All rights reserved.
//

#import "AJAPIManager.h"

@interface AJAPIManager ()

@end

@implementation AJAPIManager

+ (AJAPIManager *)sharedManager {
    static dispatch_once_t pred;
    static AJAPIManager *singleton = nil;
    dispatch_once(&pred, ^{
        singleton = [[AJAPIManager alloc] init];
    });
    return singleton;
}

#pragma mark App Logic

- (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                     success:(void (^)())success
                     failure:(void (^)(NSString *))failure {
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"register success: %@", username);
            success();
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"register failed: %@ - %@", username, errorString);
            failure(errorString);
        }
    }];
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)())success
                  failure:(void (^)(NSString *))failure {
    NSError *error = nil;
    [PFUser logInWithUsername:username password:password error:&error];
    if (error != nil) {
        failure([error userInfo][@"error"]);
    } else {
        success();
    }
}

- (void)fetchWorkoutsInGroup:(PFObject *)group
                     success:(void (^)(NSArray *))success
                     failure:(void (^)())failure {
    if (group == nil) {
        NSLog(@"!! error - [fetchWorkoutsInGroup] group should not be nil");
        return;
    }
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    [query whereKey:@"group" equalTo:group];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            success(objects);
        } else {
            failure();
        }
    }];
}

@end
