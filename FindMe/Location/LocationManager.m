//
//  LocationManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/15/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) LocationPermissionStatus currentLocationPermission;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation LocationManager

+ (instancetype)shared
{
    static LocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 100;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    return self;
}

- (void)getAuthorisationStatus:(void(^)(LocationPermissionStatus status))completion
{
    completion(self.currentLocationPermission);
}

- (void)requestLocationPermission
{
    if (CLLocationManager.locationServicesEnabled) {
        if (self.currentLocationPermission == NotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        else if (self.currentLocationPermission == AllowedWhenInUse) {
            [self.locationManager requestAlwaysAuthorization];
        }
        else {
            
        }
    }
    else {
        
    }
}

- (void)beginTracking
{
    if (self.currentLocationPermission == AllowedAlways) {
        [self.locationManager startUpdatingLocation];
    }
    else {
        [self requestLocationPermission];
    }
}

- (void)stopTracking
{
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (locations.count >= 1) {
    }
    else {
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusRestricted:
            self.currentLocationPermission = Restricted;
            break;
        case kCLAuthorizationStatusDenied:
            self.currentLocationPermission = Denied;
            break;
        case kCLAuthorizationStatusNotDetermined:
            self.currentLocationPermission = NotDetermined;
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            self.currentLocationPermission = AllowedAlways;
            [self.delegate updateCameraPositionWithLocation:self.locationManager.location];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            self.currentLocationPermission = AllowedWhenInUse;
            [self.delegate updateCameraPositionWithLocation:self.locationManager.location];
            break;
    }
}

@end
