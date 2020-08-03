//
//  DatabaseManager.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/21/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Contact.h"
#import "User.h"
#import "Trace.h"
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseManager : NSObject

+ (void)saveUser:(User *)user withCompletion:(void(^)(NSError *error))completion;
+ (void)fetchContacts:(void(^)(NSArray *contacts))completion;
+ (void)fetchTraces:(void(^)(NSArray *traces))completion;
+ (void)logOutUser:(void(^)(NSError * error))completion;
+ (void)logInUser:(NSString *)usernane withPassword:(NSString *)password withCompletion:(void(^)(NSError * error))completion;
+ (void)saveContacts:(NSArray *)contacts withCompletion:(void(^)(NSError *error))completion;
+ (void)getContactFromPFObject:(PFObject *)contactObject withCompletion:(void(^)(Contact* contact))completion;
+ (void)checkForPersistentUser: (void(^)(bool isUserloggedIn))completion;
+ (void)getCurrentUser:(void(^)(User *user))completion;
+ (Trace *)getTraceFromPFObject:(PFObject *)PFTrace;
+ (void) getPFLocationWithObjectID:(NSString *)objectID withCompletion:(void(^)(PFObject *PFLocation))completion;
+ (Location *)getLocationFromPFObject:(PFObject *)PFLocation;
+ (void)saveTrace:(Trace *)trace;
+ (PFObject *)getPFObjectFromLocation:(Location *)decodedLocation;

@end
NS_ASSUME_NONNULL_END
