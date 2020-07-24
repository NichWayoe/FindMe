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

- (void)updateLocation:(CLLocation *)location;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

typedef NS_ENUM(NSInteger, LocationPermissionStatus) {
    AllowedWhenInUse,
    Restricted,
    Denied,
    AllowedAlways,
    NotDetermined
};

+ (instancetype)shared;
- (void)requestLocationPermission;
- (void)beginTracking;
- (void)stopTracking;
- (void)getAuthorisationStatus:(void(^)(LocationPermissionStatus status))completion;

@property (nonatomic, weak) id<LocationManagerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
