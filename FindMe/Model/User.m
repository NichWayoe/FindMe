//
//  User.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "User.h"

@implementation User

    @dynamic firstName;
    @dynamic lastName;
    @dynamic email;
    @dynamic password;
    @dynamic profileImage;

+ (nonnull NSString *)parseClassName
{
    return @"User";
}

@end
