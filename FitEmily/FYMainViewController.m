//
//  ViewController.m
//  FitEmily
//
//  Created by Aaven Jin on 2/2/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "FYMainViewController.h"
#import "FYWeChatNetwork.h"

@interface FYMainViewController ()

@end

@implementation FYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonOnClick:(id)sender {
    [[FYWeChatNetwork sharedManager] loginButtonClicked];
}

@end
