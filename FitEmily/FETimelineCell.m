//
//  FETimelineCell.m
//  FitEmily
//
//  Created by Aaven Jin on 2/4/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "FETimelineCell.h"

@interface FETimelineCell ()

@property (nonatomic, strong) PFObject *workout;

@end

@implementation FETimelineCell

- (void)updateWithWorkout:(PFObject *)workout {
    if (_workout != workout) {
        _workout = workout;
        
        NSInteger minute = [workout[@"minute"] integerValue];
        if (minute % 60 == 0) {
            self.detailTextLabel.text = [NSString stringWithFormat:@"%ld hr", minute / 60];
        } else if (minute < 90) {
            self.detailTextLabel.text = [NSString stringWithFormat:@"%ld min", minute];
        } else if (minute % 60 == 30) {
            self.detailTextLabel.text = [NSString stringWithFormat:@"%ld.5 hr", minute / 60];
        } else {
            self.detailTextLabel.text = [NSString stringWithFormat:@"%ld hr %ld min", minute / 60, minute % 60];
        }
        __weak FETimelineCell *wself = self;
        PFUser *user = workout[@"user"];
        [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                wself.textLabel.text = [NSString stringWithFormat:@"%@ by %@", workout[@"name"], object[@"nickname"]];
            }
        }];
    }
}

@end
