//
//  User.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/22/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "User.h"

@implementation User

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
