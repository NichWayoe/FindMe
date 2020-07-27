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

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseManager : NSObject

+ (void)saveUser:(User *)user withCompletion:(void(^)(NSError *error))completion;
+ (void)fetchContacts:(void(^)(NSArray *contacts))completion;
+ (void)logOutUser:(void(^)(NSError * error))completion;
+ (void)logInUser:(NSString *)usernane withPassword:(NSString *)password withCompletion:(void(^)(NSError * error))completion;
+ (void)uploadContacts:(NSArray *)contacts withCompletion:(void(^)(NSError *error))completion;
+ (Contact *)getContactFromPFObject: (PFObject *)contactObject;
+ (void)checkForPersistentUser: (void(^)(bool isUserloggedIn))completion;
+ (User *)getCurrentUser;

@end
NS_ASSUME_NONNULL_END
