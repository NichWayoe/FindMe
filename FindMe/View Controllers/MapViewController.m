//
//  MapViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "MapViewController.h"
#import "LocationManager.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) LocationManager *myLocationManager;
@property (strong, nonatomic) CLLocation *mylocation;
@property (strong,nonatomic) GMSMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myLocationManager = LocationManager.shared;
    self.mapView = [[GMSMapView alloc] initWithFrame:self.view.frame];
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.myLocationEnabled= YES;
    [self.view addSubview:self.mapView];
    [self.myLocationManager requestLocationPermission];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.mylocation = [self.myLocationManager getLocation];
    if (self.mylocation != nil) {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:self.mylocation.coordinate zoom:15];
        [self.mapView setCamera:camera];
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission not Allowed"
                                                                       message:@"We need your permission to show you on the map. TO allow, open settings and enable locations"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"Open Settings"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action)
                                        {
            UIApplication *application = [UIApplication sharedApplication];
            NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [application openURL:settingURL options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"settings opened");
                }
            }];
        }];
        [alert addAction:settingAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
}

@end
