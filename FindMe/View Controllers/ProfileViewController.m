//
//  ProfileViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "ProfileViewController.h"
#import "DatabaseManager.h"
#import "HistoryViewController.h"
#import "HistoryDetailViewController.h"

@interface ProfileViewController () <HistoryViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *bioView;
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) HistoryViewController *historyViewController;
@property (strong, nonatomic) Trace *trace;
typedef NS_ENUM(NSInteger, Childviews) {
    BioView,
    HistoryView,
};

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.historyViewController = [self.childViewControllers firstObject];
    self.historyViewController.delegate = self;
    [DatabaseManager getCurrentUser:^(User * _Nonnull user) {
        if (user) {
            self.profileImageView.layer.cornerRadius = 75;
            self.usernameLabel.text = user.username;
            if (user.profileImageData) {
                self.profileImageView.image = [UIImage imageWithData:user.profileImageData];
            }
            else {
                self.profileImageView.image = [UIImage systemImageNamed:@"person"];
            }
        }
    }];
}

- (IBAction)switchViews:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case BioView:
            self.bioView.alpha = 1;
            self.historyView.alpha = 0;
            self.settingsView.alpha = 0;
            break;
        case HistoryView:
            self.bioView.alpha = 0;
            self.historyView.alpha = 1;
            self.settingsView.alpha = 0;
            break;
    }
}

- (void)didSelectCellWithTrace:(Trace *)trace
{
    self.trace = trace;
    [self performSegueWithIdentifier:@"historyDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"historyDetails"]) {
        HistoryDetailViewController *historyDetailViewConroller = [segue destinationViewController];
        historyDetailViewConroller.trace = self.trace;
    }
}

@end
