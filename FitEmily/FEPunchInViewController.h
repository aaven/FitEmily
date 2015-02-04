//
//  FEPunchInViewController.h
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "AJViewController.h"

@interface FEPunchInViewController : AJViewController

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *timeField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *unitControl;

- (IBAction)clickCancel:(id)sender;
- (IBAction)clickPublish:(id)sender;

@end
