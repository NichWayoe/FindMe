//
//  Location.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/29/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *neighbourhood;
@property (nonatomic, strong) NSString *country;

- (instancetype)initWithPlacemark:(CLPlacemark *)decodedLocation;

@end

NS_ASSUME_NONNULL_END
