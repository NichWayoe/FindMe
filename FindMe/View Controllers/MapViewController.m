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
    [self.mylocation getlocation];
    NSLog(@"%@",self.mylocation.currentLocation);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.mylocation.currentLocation.coordinate.latitude
                                                            longitude:self.mylocation.currentLocation.coordinate.longitude
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.mapType = kGMSTypeNormal;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    [self.view addSubview:mapView];
//    GMSMarker *marker = [GMSMarker new];
//    marker.position = CLLocationCoordinate2DMake(self.mylocation.currentLocation.coordinate.latitude, self.mylocation.currentLocation.coordinate.longitude);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView;
//    UIEdgeInsets mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 300.0);
//    mapView.padding = mapInsets;

}


@end
