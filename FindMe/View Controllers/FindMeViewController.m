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

@property (weak, nonatomic) IBOutlet UIButton *trackingButton;
@property (strong, nonatomic) LocationManager *locationManager;

@end

@implementation FindMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = LocationManager.shared;
    self.trackingButton.backgroundColor = [UIColor redColor];
    self.trackingButton.layer.cornerRadius = 75;
    [self permissionsStatusActions];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self permissionsStatusActions];
}

- (IBAction)onFindMe:(id)sender
{
    if (!self.trackingButton.isSelected) {
        if ([self.locationManager authorisationStatus] == AllowedAlways) {
            [self designTrackingButtonWithState:@"selected"];
            [self.locationManager beginTracking];
        }
        else {
            [self showAlert];
        }
    }
    else {
        [self designTrackingButtonWithState:@"unselected"];
        [self.locationManager stopTracking];
    }
}

- (void)permissionsStatusActions
{
    if ([self.locationManager canGetLocation]) {
        switch ([self.locationManager authorisationStatus]) {
            case AllowedAlways:
                break;
            case AllowedWhenInUse:
                [self.locationManager requestLocationPermission];
                break;
            case Denied:
            case Restricted:
                [self showAlert];
                break;
            case NotDetermined:
                break;
        }
    }
    else {
        [self showAlert];
    }
}

- (void)designTrackingButtonWithState:(NSString *)state
{
    if ([state isEqualToString:@"selected"]) {
        self.trackingButton.selected = YES;
        self.trackingButton.highlighted = NO;
        self.trackingButton.backgroundColor = [UIColor greenColor];
    }
    else {
        self.trackingButton.selected = NO;
        self.trackingButton.highlighted = NO;
        self.trackingButton.backgroundColor = [UIColor redColor];
    }
}

- (void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission not Allowed"
                                                                   message:@"We need your permission to show you on the map. TO allow, open settings and enable locations"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"Open Settings"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [application openURL:settingURL options:@{} completionHandler:^(BOOL success) {
            if (success) {
            }
        }];
    }];
    [alert addAction:settingAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
