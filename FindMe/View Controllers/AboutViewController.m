//
//  AboutViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "AboutViewController.h"
#import "DatabaseManager.h"
#import "User.h"
#import "LabelCell.h"
#import "UserDetailCell.h"

@interface AboutViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSArray *userDetails;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    User *user = [DatabaseManager getCurrentUser];
    self.userDetails = @[@"USERNAME", user.username, @"FIRST NAME", user.firstName, @"LAST NAME", user.lastName, @"EMAIL", user.email];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        LabelCell *labelCell = [tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        labelCell.nameLabel.text = self.userDetails[indexPath.row];
        [labelCell.nameLabel.text uppercaseString];
        return labelCell;
    }
    else {
        UserDetailCell *userDetailCell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailCell"];
        userDetailCell.detailLabel.text = self.userDetails[indexPath.row];
        return userDetailCell;
    }
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

@end
