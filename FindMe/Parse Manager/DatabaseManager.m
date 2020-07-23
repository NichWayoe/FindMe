//
//  DatabaseManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/21/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+ (void)saveUser:(User *)user withCompletion:(void(^)(NSError *error))completion
{
    PFUser *newUser = [PFUser new];
    newUser.username = user.username;
    newUser.password = user.password;
    newUser[@"firstName"] = user.firstName;
    newUser[@"lastName"] = user.lastName;
    if (user.profileImageData) {
        newUser[@"profilePhoto"] = [PFFileObject fileObjectWithData:user.profileImageData];
    }
    else {
        
    }
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded && error) {
            completion(error);
        }
        else
            completion(nil);
    }];
}

+ (void)uploadContacts:(NSArray *)contacts withCompletion:(void(^)(NSError *error))completion
{
    PFObject *contactsToAlert = [PFObject objectWithClassName:@"contactsToAlert"];
    if (contacts) {
        for (Contact* contact in contacts) {
            contactsToAlert[@"user"] = [PFUser currentUser];
            contactsToAlert[@"firstName"] = contact.firstName;
            contactsToAlert[@"LastName"] = contact.lastName;
            contactsToAlert[@"telephoneNumber"] = contact.telephoneNumber;
            contactsToAlert[@"email"] = contact.email;
            [contactsToAlert saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!succeeded && error ) {
                }
                else {
                }
            }];
        }
    }
    else {
        
    }
}

+ (Contact *)getContactFromPFObject: (PFObject *)contactObject
{
    Contact *contact = [Contact new];
    contact.email = contactObject[@"email"];
    contact.firstName = contactObject[@"firstName"];
    contact.lastName = contactObject[@"LastName"];
    contact.telephoneNumber = contactObject[@"telephoneNumber"];
    return contact;
}

+ (void)fetchContacts:(void(^)(NSArray *contacts))completion
{
    NSMutableArray *fetchedContacts = [NSMutableArray new];
    PFQuery *query = [PFQuery queryWithClassName:@"contactsToAlert"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *contacts, NSError *error) {
        if (error) {
            completion(nil);
        }
        else {
            for (PFObject *contactObject in contacts) {
                Contact *contact = [DatabaseManager getContactFromPFObject:contactObject];
                [fetchedContacts addObject:contact];
            }
            completion((NSArray *) fetchedContacts);
        }
    }];
}

+ (void)logOutUser:(void(^)(NSError *error))completion
{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error) {
            completion(error);
        }
        else {
            completion(nil);
        }
    }];
}

+ (void)logInUser:(NSString *)username withPassword:(NSString *)password withCompletion:(void(^)(NSError *error))completion
{
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if (error) {
            completion(error);
        }
        else {
            completion(nil);
        }
    }];
}

+ (void)checkForPersistentUser: (void(^)(bool isUserloggedIn))completion
{
    if (PFUser.currentUser) {
        completion(YES);
    }
    else {
        completion(NO);
    }
}
@end
