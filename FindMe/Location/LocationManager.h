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

+ (instancetype)shared;
- (void)requestLocationPermission;
- (void)getLocation:(void(^)(CLLocation *location))completion;
- (void)beginTracking;

@end

NS_ASSUME_NONNULL_END
