//
//  AppDelegate.h
//  FitEmily
//
//  Created by Aaven Jin on 2/2/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYWeChatNetwork.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)navigateWithAuthState;

@end

