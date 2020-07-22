//
//  ContactsViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "ContactsViewController.h"
#import "MainTabBarViewController.h"
#import "ContactCell.h"
#import "DatabaseManager.h"

@interface ContactsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contacts = [NSMutableArray new];
    [self fetchContacts];
}

- (void)fetchContacts
{
    [DatabaseManager fetchContacts:^(NSArray * _Nonnull contacts){
        if (contacts) {
            self.contacts = (NSMutableArray *)contacts;
            [self.tableView reloadData];
        }
        else {
            [self showAlert];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    cell.contact = self.contacts[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self fetchContacts];
}

- (void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"couldn't fetch contacts"
                                                                   message:@"something went wrong"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"try again"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
