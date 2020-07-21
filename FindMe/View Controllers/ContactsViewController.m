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
#import "Parse/Parse.h"

@interface ContactsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contacts = [NSMutableArray new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchContacts];
}

- (void)fetchContacts
{
    PFQuery *query = [PFQuery queryWithClassName:@"Contact"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *contacts, NSError *error) {
        if (contacts != nil) {
            self.contacts = (NSMutableArray *) contacts;
            [self.tableView reloadData];
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    NSLog(@"%@",self.contacts[indexPath.row]);
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

@end
