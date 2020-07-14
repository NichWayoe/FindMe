//
//  Contact.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "Contact.h"

@implementation Contact

    @dynamic telephoneNumber;
    @dynamic name;
    @dynamic user;
    @dynamic email;

+ (nonnull NSString *)parseClassName
{
    return @"Contact";
}

@end
