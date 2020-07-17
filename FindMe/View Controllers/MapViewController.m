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

@property (strong, nonatomic) LocationManager *mylocation;
@property(strong, nonatomic) CLLocation *coordinate;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mylocation = LocationManager.shared;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.mylocation getlocation];
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
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
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.mylocation.currentLocation.coordinate.latitude
                                                            longitude:self.mylocation.currentLocation.coordinate.longitude
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.mapType = kGMSTypeNormal;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
    
}

@end
