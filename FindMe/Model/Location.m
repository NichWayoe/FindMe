//
//  Location.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/29/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithPlacemark:(CLPlacemark *)decodedLocation
{
    self = [super init];
    if (self) {
        self.city = decodedLocation.locality;
        self.state = decodedLocation.administrativeArea;
        self.country = decodedLocation.country;
        self.latitude = decodedLocation.location.coordinate.latitude;
        self.longtitude = decodedLocation.location.coordinate.longitude;
        self.address = [ NSString stringWithFormat:@"%@ %@", decodedLocation.thoroughfare, decodedLocation.postalCode];
    }
    return self;
}

@end
