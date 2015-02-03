//
//  FEPunchInViewController.m
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "AJAPIManager.h"
#import "FEDataManager.h"
#import "FEPunchInViewController.h"

@implementation FEPunchInViewController

- (IBAction)clickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickPublish:(id)sender {
    NSString *name = self.textView.text;
    if (name.length == 0) {
        return;
    }
    CGFloat number = [self.timeField.text floatValue];
    NSInteger minute = number * (self.unitControl.selectedSegmentIndex == 0 ? 1 : 60);
    
    __weak FEPunchInViewController *wself = self;
    [[AJAPIManager sharedManager] punchIn:name
                                  minutes:minute
                                  inGroup:[[FEDataManager sharedManager] currentGroup]
                                  success:^{
                                      NSLog(@"success punched in! %@ for %ld min", name, minute);
                                      [wself dismissViewControllerAnimated:YES completion:nil];
                                  } failure:^{
                                      NSLog(@"!! fail to punch in");
                                  }];
}

@end
