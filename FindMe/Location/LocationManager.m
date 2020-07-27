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

- (LocationPermissionStatus)authorisationStatus
{
    return self.currentLocationPermission;
}

- (CLLocation *)location;
{
    return self.locationManager.location;
}

- (void)requestLocationPermission
{
    if (CLLocationManager.locationServicesEnabled) {
        switch (self.currentLocationPermission) {
            case NotDetermined:
                [self.locationManager requestWhenInUseAuthorization];
                break;
            case AllowedWhenInUse:
                [self.locationManager requestAlwaysAuthorization];
            case AllowedAlways:
            case Restricted:
            case Denied:
                break;
        }
    }
    else {
        return;
    }
}

- (BOOL)canGetLocation
{
    return [CLLocationManager locationServicesEnabled];
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
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            self.currentLocationPermission = AllowedAlways;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            self.currentLocationPermission = AllowedWhenInUse;
            break;
    }
    [self.delegate authorisationStatusDidChange:self.currentLocationPermission];
}

@end
