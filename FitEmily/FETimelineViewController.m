//
//  FETimelineViewController.m
//  FitEmily
//
//  Created by Aaven Jin on 2/3/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "FEConstants.h"
#import "FETimelineViewController.h"
#import "FEDataManager.h"
#import "FETimelineCell.h"

@interface FETimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *workouts;

@end

@implementation FETimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.workouts = [[FEDataManager sharedManager] workouts];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNewData:)
                                                 name:FEDidFetchDataNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh {
    [self.tableView reloadData];
}

- (void)didReceiveNewData:(NSNotification *)notif {
    self.workouts = [[FEDataManager sharedManager] workouts];
}

- (void)setWorkouts:(NSArray *)workouts {
    if ([workouts isEqual:_workouts] && workouts.count == _workouts.count) {
        return;
    }
    _workouts = workouts;
    [self refresh];
}

#pragma mark UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.workouts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FETimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workout"];
    [cell updateWithWorkout:self.workouts[indexPath.row]];
    return cell;
}

@end
