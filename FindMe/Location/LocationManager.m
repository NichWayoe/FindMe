//
//  LocationManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/15/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "LocationManager.h"
#import "DatabaseManager.h"
#import "AlertManager.h"

@interface LocationManager ()

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) LocationPermissionStatus currentLocationPermission;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (nonatomic) BOOL isTracking;

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
        self.geocoder = [CLGeocoder new];
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

+ (NSString *)makeStringFromPlacemarkAndContact:(CLPlacemark *)decodedLocation
{
    NSString *message = [NSString stringWithFormat: @" \
                         Address : %@ %@ %@ \
                         \
                         city : %@ \
                         \
                         Neighbourhood: %@ \
                         \
                         State : %@ \
                         \
                         Country : %@ \
                         \
                         Your are receiving this notification because put you as emergency Contact. \
                         ", decodedLocation.subThoroughfare, decodedLocation.thoroughfare, decodedLocation.postalCode, decodedLocation.locality, decodedLocation.subLocality, decodedLocation.administrativeArea, decodedLocation.country];
    return message;
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
    if (!self.isTracking) {
        [self.locationManager startUpdatingLocation];
        self.isTracking  = YES;
    }
    else {
        return;
    }
}

- (void)stopTracking
{
    if (self.isTracking) {
        [self.locationManager stopUpdatingLocation];
        self.isTracking = NO;
    }
    else {
        return;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self decodeLocation:[locations lastObject] withCompletion:^(CLPlacemark *decodedLocation) {
        if (decodedLocation) {
            NSString *message = [LocationManager makeStringFromPlacemarkAndContact:decodedLocation];
            [DatabaseManager fetchContacts:^(NSArray * _Nonnull contacts) {
                if (contacts.count > 1) {
                    for (Contact *contact in contacts) {
                        [AlertManager sendEmail:contact.firstName toEmail:contact.email withMessage:message];
                    }
                }
                else {
                    return;
                }
            }];
        }
        else {
            return;
        }
    }];
}

- (void)decodeLocation:(CLLocation *)location withCompletion:(void(^)(CLPlacemark *decodedLocation))completion
{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            completion([placemarks firstObject]);
        }
        else {
            completion(nil);
        }
    }];
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
