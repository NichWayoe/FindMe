//
//  TraceMapViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 8/11/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "TraceMapViewController.h"
#import "Location.h"
#import <GoogleMaps/GoogleMaps.h>

@interface TraceMapViewController ()

@property (strong,nonatomic) GMSMapView *mapView;

@end

@implementation TraceMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Location *location = [self.coordinates firstObject];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.latitude longitude:location.longtitude zoom:15];
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    [self.view addSubview:self.mapView];
    [self drawPath];
}

- (void)drawPath
{
    GMSMutablePath *tracePath = [GMSMutablePath new];
    for (Location *location in self.coordinates) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(location.latitude, location.longtitude);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.title = @"alert shared";
        marker.snippet = [NSString stringWithFormat:@"%@ %@ %@", location.address, location.city, location.state];
        marker.map = self.mapView;
        [tracePath addCoordinate:position];
    }
    GMSPolyline *traceLine = [GMSPolyline polylineWithPath:tracePath];
    traceLine.strokeWidth = 5;
    traceLine.map = self.mapView;
    
}

@end
