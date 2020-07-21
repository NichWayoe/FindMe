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
@dynamic username;
@dynamic email;
@dynamic password;
@dynamic profileImage;

+ (nonnull NSString *)parseClassName
{
    return @"User";
}

+ (void)createUser: (NSDictionary *)userDetails  withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    User *user = [User new];
    user.username =userDetails[@"username"];
    user.password = userDetails[@"password"];
    user.firstName= userDetails[@"firstName"];
    user.lastName= userDetails[@"lastName"];
    if (userDetails[@"profilePhotoData"]) {
        user.profileImage = [PFFileObject fileObjectWithData:userDetails[@"profilePhotoData"]];
    }
    else {
        
    }
    [user saveInBackgroundWithBlock: completion];}

@end
