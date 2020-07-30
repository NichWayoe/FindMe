//
//  Tracking.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/29/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "Tracking.h"

@implementation Tracking

- (instancetype)initWithDictionary:(NSDictionary *)userDetails
{
    self = [super init];
    if (self) {
        self.username = userDetails[@"username"];
        self.email = userDetails[@"email"];
        self.password = userDetails[@"password"];
        self.firstName = userDetails[@"firstName"];
        self.lastName = userDetails[@"lastName"];
        if (userDetails[@"profileImage"]) {
            self.profileImageData = userDetails[@"profileImage"];
        }
        else {
            
        }
    }
    return self;
}


@end
