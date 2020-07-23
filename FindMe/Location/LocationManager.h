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

@interface LocationManager : NSObject <CLLocationManagerDelegate>

typedef NS_ENUM(NSInteger, locationPermissionStatus) {
    allowedWhenInUse,
    restricted,
    denied,
    allowedAlways,
    notDetermined
};

+ (instancetype)shared;
- (void)requestLocationPermission;
- (void)beginTracking;
- (void)stopTracking;
- (void)getAuthorisationStatus:(void(^)(locationPermissionStatus status))completion;

@end

NS_ASSUME_NONNULL_END
