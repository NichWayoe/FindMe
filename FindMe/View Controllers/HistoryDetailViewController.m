//
//  HistoryDetailViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 8/3/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "DatabaseManager.h"
#import "LocationCell.h"
#import "HistoryCell.h"

@interface HistoryDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *locations;

@end

@implementation HistoryDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locations = [NSMutableArray new];
    for (id location in self.trace.locations) {
        [self.locations addObject:location];
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
        cell.trace = self.trace;
        return cell;
    }
    else {
        LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
        cell.location = self.locations[indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return  1;
    }
    else {
        return self.locations.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Trace Details";
    }
    else {
        return @"Locations";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

@end
