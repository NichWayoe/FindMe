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
typedef NS_ENUM(NSInteger, locationPermissionStatus) {
    allowedWhenInUse,
    restricted,
    denied,
    allowedAlways,
    notDetermined
};
@property (nonatomic, assign) locationPermissionStatus currentLocationPermission;

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
        self.locationManager.distanceFilter = 5;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    return self;
}

- (CLLocation* )getLocation
{
    if ((self.currentLocationPermission == allowedWhenInUse) || (self.currentLocationPermission == allowedAlways)) {
        return self.locationManager.location;
    }
    else {
        return nil;
    }
}

- (void)requestLocationPermission
{
    if (CLLocationManager.locationServicesEnabled) {
        if (self.currentLocationPermission == notDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        else if (self.currentLocationPermission == allowedWhenInUse) {
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
    if (self.currentLocationPermission == allowedAlways) {
        [self.locationManager startUpdatingLocation];
    }
    else {
        
    }
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
            self.currentLocationPermission = restricted;
            break;
        case kCLAuthorizationStatusDenied:
            self.currentLocationPermission = denied;
            break;
        case kCLAuthorizationStatusNotDetermined:
            self.currentLocationPermission = notDetermined;
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            self.currentLocationPermission = allowedAlways;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            self.currentLocationPermission = allowedWhenInUse;
            break;
    }
}

@end
