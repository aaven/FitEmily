//
//  FELoginViewController.h
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "AJViewController.h"

@interface FELoginViewController : AJViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *weChatLoginButton;

- (IBAction)clickLogin:(id)sender;

@end
