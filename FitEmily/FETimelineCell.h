//
//  FETimelineCell.h
//  FitEmily
//
//  Created by Aaven Jin on 2/4/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface FETimelineCell : UITableViewCell

- (void)updateWithWorkout:(PFObject *)workout;

@end
