//
//  ProfileViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "ProfileViewController.h"
#import "DatabaseManager.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIView *bioView;
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

typedef NS_ENUM(NSInteger, Childviews) {
    BioView,
    HistoryView,
    SettingsView,
};

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DatabaseManager currentUser:^(User * _Nonnull user) {
        if (user) {
            self.profileImageView.layer.cornerRadius = 50;
            self.usernameLabel.text = user.username;
            self.profileImageView.image = [UIImage imageWithData:user.profileImageData];
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
        case SettingsView:
            self.bioView.alpha = 0;
            self.historyView.alpha = 0;
            self.settingsView.alpha = 1;
            break;
    }
}


@end
