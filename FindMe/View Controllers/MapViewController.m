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

@interface MapViewController () <LocationManagerDelegate>

@property (strong, nonatomic) LocationManager *locationManager;
@property (strong,nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMutablePath *tracePath;
@property (strong, nonatomic) GMSPolyline *traceLine;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self defaultMapView];
    self.locationManager = LocationManager.shared;
    self.locationManager.delegate = self;
    self.tracePath = [GMSMutablePath path];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resolveLocation];
}

- (void)resolveLocation
{
    if ([self.locationManager canGetLocation]) {
        switch ([self.locationManager authorisationStatus]) {
            case Denied:
            case Restricted:
                [self showAlert];
                break;
            case NotDetermined:
                break;
            case AllowedAlways:
            case AllowedWhenInUse:
                [self updateCameraPositionForMapVIew:[self.locationManager location]];
                break;
        }
    }
    else {
        [self showAlert];
        
    }
}

- (void)authorisationStatusDidChange:(LocationPermissionStatus)status
{
    switch (status) {
        case Denied:
        case Restricted:
            [self showAlert];
            break;
        case NotDetermined:
            break;
        case AllowedAlways:
        case AllowedWhenInUse:
            [self updateCameraPositionForMapVIew:[self.locationManager location]];
    }
}

- (void)updateCameraPositionForMapVIew:(CLLocation *)location
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:15];
    [self.mapView setCamera:camera];
}

- (void)defaultMapView
{
    self.mapView = [[GMSMapView alloc] initWithFrame:self.view.frame];
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    [self.locationManager requestLocationPermission];
    self.mapView.myLocationEnabled = YES;
    [self.view addSubview:self.mapView];
}

- (void)didChangeLocation:(CLLocation *)location
{
    [self.tracePath addCoordinate:location.coordinate];
    self.traceLine = [GMSPolyline polylineWithPath:self.tracePath];
    self.traceLine.strokeWidth = 5;
    self.traceLine.map = self.mapView;
}

- (void)didStartTrace:(BOOL)isStarted
{
    if (isStarted) {
        [self.mapView clear];
    }
    else {
        return;
    }
}

- (void)didEndTrace:(NSArray<CLLocation *> *)locations
{
    GMSCircle *circle =[GMSCircle circleWithPosition:[locations lastObject].coordinate radius:100];
    circle.map = self.mapView;
    circle.radius = 100;
    circle.strokeColor = [UIColor redColor];
    circle.strokeWidth = 5;
    [self.tracePath removeAllCoordinates];
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

