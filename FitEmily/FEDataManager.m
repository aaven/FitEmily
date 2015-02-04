//
//  FEDataManager.m
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "FEConstants.h"
#import "FEDataManager.h"

@implementation FEDataManager

+ (FEDataManager *)sharedManager {
    static dispatch_once_t pred;
    static FEDataManager *singleton = nil;
    dispatch_once(&pred, ^{
        singleton = [[FEDataManager alloc] init];
    });
    return singleton;
}

- (void)refreshData {
    __weak FEDataManager *wself = self;
    [[AJAPIManager sharedManager] fetchWorkoutsInGroup:self.currentGroup success:^(NSArray *workouts) {
        wself.workouts = workouts;
        [[NSNotificationCenter defaultCenter] postNotificationName:FEDidFetchDataNotification object:nil];
    } failure:^{
        NSLog(@"!! failed to refresh data");
    }];
}

@end
