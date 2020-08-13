//
//  ContactsViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactCell.h"
#import "DatabaseManager.h"

@interface ContactsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *contacts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]
                                      initWithFrame:CGRectZero];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(fetchContacts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.contacts = [NSMutableArray new];
    [self fetchContacts];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchContacts];
}

- (void)fetchContacts
{
    [DatabaseManager fetchContacts:^(NSArray * _Nonnull contacts) {
        if (contacts) {
            self.contacts = [contacts mutableCopy];
            [self.refreshControl endRefreshing];
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

- (void)didSelectContacts:(NSArray<CNContact *> *)contacts {
    NSMutableArray *selectedContacts = [Contact contactsWithArray:contacts];
    for (Contact *contact in selectedContacts) {
        [self.contacts addObject:contact];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [DatabaseManager deleteContact:self.contacts[indexPath.row]];
        [self.contacts removeObjectAtIndex:(indexPath.row)];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        completionHandler(YES);
    }];
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    return configuration;
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
