//
//  FEMeViewController.m
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "AppDelegate.h"
#import "FEMeViewController.h"

@interface FEMeViewController ()

@end

@implementation FEMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickLogOut:(id)sender {
    [PFUser logOut];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate navigateWithAuthState];
}

@end
