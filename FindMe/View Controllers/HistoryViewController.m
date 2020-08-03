//
//  HistoryViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"
#import "DatabaseManager.h"

@interface HistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray* traces;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(fetchHistory) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.traces = [NSArray new];
    [self fetchHistory];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchHistory];
}

- (void)fetchHistory
{
    [DatabaseManager fetchTraces:^(NSArray * _Nonnull traces) {
        if (traces) {
            self.traces = traces;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }
        else {
            
        }
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    cell.trace = self.traces[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.traces.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.delegate didSelectCellWithTrace:self.traces[indexPath.row]];
}

@end
