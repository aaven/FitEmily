//
//  ViewController.m
//  FitEmily
//
//  Created by Aaven Jin on 2/2/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import <Parse/Parse.h>
#import "ViewController.h"
#import "AJAPIManager.h"
#import "FEDataManager.h"

enum FEAlertType {
    FEAlertInvitation,
    FEAlertChooseGroup
};

@interface ViewController () <UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Check if the user already belongs to a group. If not, ask for invitation code.
    __weak ViewController *wself = self;
    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationForKey:@"groups"];
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            
        } else {
            if (objects.count == 0) {
                [wself askForInvitationCode:@"Do you have an invitation code?"];
            } else {
                [[FEDataManager sharedManager] setCurrentGroup:[objects firstObject]];
                [[FEDataManager sharedManager] refreshData];
            }
        }
    }];
}

- (void)askForInvitationCode:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self
                                          cancelButtonTitle:@"No" otherButtonTitles:@"Yes!", nil];
    alert.tag = FEAlertInvitation;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == FEAlertInvitation) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            // Fetch all the groups from server
            NSArray *allGroups = [[FEDataManager sharedManager] allGroups];
            if (allGroups == nil) {
                PFQuery *query = [PFQuery queryWithClassName:@"Group"];
                allGroups = [query findObjects];
                [[FEDataManager sharedManager] setAllGroups:allGroups];
            }
            
            // Verify the code
            NSString *code = [alertView textFieldAtIndex:0].text;
            BOOL valid = NO;
            for (PFObject *group in allGroups) {
                if ([group[@"code"] isEqualToString:code]) {
                    valid = YES;
                    
                    // Update the group and user info
                    PFUser *user = [PFUser currentUser];
                    PFRelation *relation = [user relationForKey:@"groups"];
                    [relation addObject:group];
                    [user saveInBackground];
                    relation = [group relationForKey:@"users"];
                    [relation addObject:user];
                    [group saveInBackground];
                    
                    // Show this group
                    [[FEDataManager sharedManager] setCurrentGroup:group];
                    [[FEDataManager sharedManager] refreshData];
                    NSLog(@"You will soon be seeing group %@", group[@"name"]);
                }
            }
            if (!valid) {
                // No group is found. The code is invalid.
                [self askForInvitationCode:@"Invalid code. Please try again."];
            }
        }
        
    }
}

@end
