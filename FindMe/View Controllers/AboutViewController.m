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
#import "UserDetailCell.h"

@interface AboutViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSArray *userDetails;
@property (strong, nonatomic) User *user;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DatabaseManager getCurrentUser:^(User * _Nonnull user) {
        if (user) {
            self.user = user;
        }
    }];
    self.userDetails = @[self.user.username, self.user.firstName, self.user.lastName,self.user.email];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
        UserDetailCell *userDetailCell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailCell"];
        userDetailCell.detailLabel.text = self.userDetails[indexPath.section];
        return userDetailCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *sectionNames = @[@"Username", @"First Name", @"Last Name", @"Email"];
    return sectionNames[section];
    
}

@end
