//
//  FELoginViewController.m
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "AppDelegate.h"
#import "AJAPIManager.h"
#import "FELoginViewController.h"
#import "FYWeChatNetwork.h"

@implementation FELoginViewController

- (IBAction)clickLogin:(id)sender {
    [[AJAPIManager sharedManager] loginWithUsername:self.usernameField.text password:self.passwordField.text success:^{
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate navigateWithAuthState];
    } failure:^(NSString *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error message:nil delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (IBAction)onClickLogin:(id)sender {
    [[FYWeChatNetwork sharedManager] loginButtonClicked];
}

@end
