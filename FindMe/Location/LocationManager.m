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
        self.locationManager.distanceFilter = 5;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    return self;
}

- (void)getLocation:(void(^)(CLLocation *location))completion
{
    [self requestLocationPermission];
    if ((self.currentLocationPermission == allowedWhenInUse) || (self.currentLocationPermission == allowedAlways)) {
        completion(self.location);
    }
    else {
        completion(nil);
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

- (void)broadcastNotification
{
    CLLocation *location;
    if (self.currentLocationPermission == allowedAlways || self.currentLocationPermission == allowedWhenInUse) {
        location = self.locationManager.location;
    }
    else {
        location = nil;
    }
    NSDictionary *userInfo = @{@"location": self.locationManager.location};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationNotification" object:nil userInfo:userInfo];
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
            [self broadcastNotification];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            self.currentLocationPermission = allowedWhenInUse;
            [self broadcastNotification];
            break;
    }
}

@end
