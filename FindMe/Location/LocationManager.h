//
//  LocationManager.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/15/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
NS_ASSUME_NONNULL_BEGIN

@protocol LocationManagerDelegate <NSObject>

typedef NS_ENUM(NSInteger, LocationPermissionStatus) {
    AllowedWhenInUse,
    Restricted,
    Denied,
    AllowedAlways,
    NotDetermined
};

- (void)authorisationStatusDidChange:(LocationPermissionStatus )status;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

+ (instancetype)shared;
- (void)requestLocationPermission;
- (void)beginTracking;
- (void)stopTracking;
- (CLLocation *)location;
- (LocationPermissionStatus)authorisationStatus;
- (BOOL)canGetLocation;
+ (NSString *)makeStringFromPlacemarkAndContact:(CLPlacemark *)decodedLocation;

@property (nonatomic, weak) id<LocationManagerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
