//
//  FYWeChatNetwork.h
//  FitEmily
//
//  Created by Fiona Yang on 2/4/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYWeChatInfoViewController.h"
#import "WXApi.h"

@interface FYWeChatNetwork : NSObject

@property (weak, nonatomic) FYWeChatInfoViewController *FYWeChatInfoVC;

+ (FYWeChatNetwork *)sharedManager;
- (void)loginButtonClicked;
- (void)getWeiXinCodeFinishedWithResp:(BaseResp *)resp;

@end
