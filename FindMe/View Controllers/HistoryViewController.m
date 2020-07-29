//
//  HistoryViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"

@interface HistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

@end
