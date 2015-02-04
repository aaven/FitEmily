//
//  FEDataManager.h
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AJAPIManager.h"

@interface FEDataManager : NSObject

@property (nonatomic, strong) NSArray *allGroups;
@property (nonatomic, strong) PFObject *currentGroup;

+ (FEDataManager *)sharedManager;
- (void)refreshData;

@end
