//
//  DatabaseManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/21/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "DatabaseManager.h"
#import "DateTools.h"

@implementation DatabaseManager

+ (void)saveUser:(User *)user withCompletion:(void(^)(NSError *error))completion
{
    PFUser *newUser = [PFUser new];
    newUser.username = user.username;
    newUser.password = user.password;
    newUser[@"firstName"] = user.firstName;
    newUser[@"lastName"] = user.lastName;
    newUser[@"email"] = user.email;
    if (user.profileImageData) {
        PFFileObject *imageFile = [PFFileObject fileObjectWithName:@"profileImage.png" data:user.profileImageData];
        newUser[@"profilePhoto"] = imageFile;
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

+ (void)getCurrentUser:(void(^)(User *user))completion
{
    PFUser *user = [PFUser currentUser];
    User *currentUser = [User new];
    currentUser.firstName = user[@"firstName"];
    currentUser.lastName = user[@"lastName"];
    currentUser.email = user[@"email"];
    currentUser.username = user[@"username"];
    PFFileObject *userProfileImage = user[@"profilePhoto"];
    [userProfileImage getDataInBackgroundWithBlock:^(NSData * _Nullable ImageData, NSError * _Nullable error) {
        if (!error) {
            currentUser.profileImageData = ImageData;
            completion(currentUser);
        }
        else {
        }
    }];
    completion(currentUser);
}

+ (Trace *)getTraceFromPFObject:(PFObject *)PFTrace
{
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *locatonsArray =[NSMutableArray new];
    Trace *trace = [Trace new];
    trace.duration = PFTrace[@"duration"];
    trace.dateStarted = PFTrace[@"dateStarted"];
    trace.dateEnded = PFTrace[@"dateEnded"];
    for (PFObject *object in PFTrace[@"locations"])
    {
        dispatch_group_enter(group);
        [DatabaseManager getPFLocationWithObjectID:object.objectId withCompletion:^(PFObject * _Nonnull PFLocation) {
            if (PFLocation) {
                [locatonsArray addObject:[DatabaseManager getLocationFromPFObject:PFLocation]];
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        trace.locations = locatonsArray;
    });
    return trace;
}

+ (Location *)getLocationFromPFObject:(PFObject *)PFLocation
{
    Location *location = [Location new];
    location.city = PFLocation[@"city"];
    location.address = PFLocation[@"address"];
    location.country = PFLocation[@"country"];
    location.state = PFLocation[@"state"];
    return location;
}

+ (void) getPFLocationWithObjectID:(NSString *)objectID withCompletion:(void(^)(PFObject *PFLocation))completion
{
    PFQuery *query = [PFQuery queryWithClassName:@"TracedLocations"];
    [query whereKey:@"objectId" equalTo:objectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects) {
            completion([objects lastObject]);
        }
        else {
            completion(nil);
        }
    }];
}

+ (void)fetchTraces:(void(^)(NSArray *traces))completion
{
    NSMutableArray *fetchedTraces = [NSMutableArray new];
    PFQuery *query = [PFQuery queryWithClassName:@"Traces"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects) {
            for (PFObject *trace in objects) {
                [fetchedTraces addObject:[DatabaseManager getTraceFromPFObject:trace]];
            }
            completion((NSArray *)fetchedTraces);
        }
        else {
            completion(nil);
        }
    }];
}

+ (void)saveContacts:(NSArray *)contacts withCompletion:(void(^)(NSError *error))completion
{
    PFObject *contactsToAlert = [PFObject objectWithClassName:@"contactsToAlert"];
    if (contacts) {
        for (Contact* contact in contacts) {
            contactsToAlert[@"user"] = [PFUser currentUser];
            contactsToAlert[@"firstName"] = contact.firstName;
            contactsToAlert[@"LastName"] = contact.lastName;
            contactsToAlert[@"email"] = contact.email;
            if (contact.profileImageData) {
                PFFileObject *imageFile = [PFFileObject fileObjectWithName:@"profileImage.png" data:contact.profileImageData];
                contactsToAlert[@"profileImage"] = imageFile;
            }
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

+ (void)saveTrace:(Trace *)trace
{
    PFObject *traces = [PFObject objectWithClassName:@"Traces"];
    traces[@"user"] = [PFUser currentUser];
    traces[@"locations"] = trace.locations;
    traces[@"duration"] = trace.duration;
    traces[@"dateEnded"] = trace.dateEnded;
    traces[@"dateStarted"] = trace.dateStarted;
    [traces saveInBackground];
}

+ (PFObject *)getPFObjectFromLocation:(Location *)decodedLocation
{
    PFObject *location = [PFObject objectWithClassName:@"TracedLocations"];
    location[@"user"] = [PFUser currentUser];
    location[@"city"] = decodedLocation.city;
    location[@"country"] = decodedLocation.country;
    location[@"state"] = decodedLocation.state;
    location[@"address"] = decodedLocation.address;
    return location;
}

+ (void)getContactFromPFObject:(PFObject *)contactObject withCompletion:(void(^)(Contact* contact))completion
{
    Contact *contact = [Contact new];
    contact.email = contactObject[@"email"];
    contact.firstName = contactObject[@"firstName"];
    contact.lastName = contactObject[@"LastName"];
    PFFileObject *contactImageFile = contactObject[@"profileImage"];
    [contactImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable ImageData, NSError * _Nullable error) {
        if (!error) {
            contact.profileImageData = ImageData;
            completion(contact);
        }
    }];
}

+ (void)fetchContacts:(void(^)(NSArray *contacts))completion
{
    dispatch_group_t group = dispatch_group_create();
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
                dispatch_group_enter(group);
                [DatabaseManager getContactFromPFObject:contactObject withCompletion:^(Contact * _Nonnull contact) {
                    if (contact) {
                        [fetchedContacts addObject:contact];
                    }
                    dispatch_group_leave(group);
                }];
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                completion((NSArray *) fetchedContacts);
            });
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
