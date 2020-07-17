//
//  FindMeViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "FindMeViewController.h"
#import "LocationManager.h"

@interface FindMeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LocationManager *mylocation;

@end

@implementation FindMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mylocation = LocationManager.shared;
    [self.mylocation begintracking];
   
}
- (IBAction)onFindMe:(id)sender {
}


@end
