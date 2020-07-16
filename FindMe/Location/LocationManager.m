//
//  LocationManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/15/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "LocationManager.h"

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

- (instancetype) init
{
    self = [super init];
    if (self != nil) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void) getlocation
{
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager requestWhenInUseAuthorization];
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
            self.currentLocation = self.locationManager.location;
        }
    }
}

-(void) begintracking
{
    if ([CLLocationManager locationServicesEnabled]){
        [self.locationManager requestAlwaysAuthorization];
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways){
            //I will implement functionality here
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.currentLocation = [locations lastObject];
    NSLog(@"%f",self.currentLocation.coordinate.latitude);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%i",status);
    switch (status) {
        case kCLAuthorizationStatusRestricted:
            NSLog(@"%i",status);
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"%i",status);
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"%i",status);
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
    }
    
}

@end
