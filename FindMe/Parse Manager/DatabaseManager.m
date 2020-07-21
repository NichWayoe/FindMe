//
//  DatabaseManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/21/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "DatabaseManager.h"
#import "Parse/Parse.h"

@implementation DatabaseManager

+ (void)createUser:(NSDictionary *)userDetails withCompletion:(void(^)(NSError *error))completion
{
    PFUser *user = [PFUser new];
    user.username = userDetails[@"username"];
    user.password = userDetails[@"password"];
    user[@"firstName"] = userDetails[@"firstName"];
    user[@"lastName"] = userDetails[@"lastName"];
    if (userDetails[@"profilePhotoData"]) {
        user[@"profilePhoto"] = [PFFileObject fileObjectWithData:userDetails[@"profilePhotoData"]];
    }
    else {
        
    }
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error) {
            completion(error);
        }
        else
            completion(nil);
    }];
}

+ (void)getUser:(void(^)(PFUser * user))completion
{
    PFUser *user = [PFUser currentUser];
    if(user) {
        completion(user);
    }
    else {
        completion(nil);
    }
}

+ (void)fetchContacts:(void(^)(NSArray *contacts, bool gotContacts))completion
{
    PFQuery *query = [PFQuery queryWithClassName:@"Contact"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *contacts, NSError *error) {
        if (error) {
            completion(nil, NO);
        }
        else {
            completion(contacts, YES);
        }
    }];
}

+ (void)logOutUser:(void(^)(bool didLogOut, NSError * error))completion
{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error) {
            completion(NO, error);
        }
        else {
            completion(YES, nil);
        }
    }];
}

+ (void)logInUser:(NSString *)username withPassword:(NSString *)password withCompletion:(void(^)(bool didLogIn, NSError * error))completion
{
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error) {
            completion(NO, error);
        }
        else {
            completion(YES, nil);
        }
    }];
}

@end
