//
//  DatabaseManager.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/21/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseManager : NSObject

+ (void)createUser:(NSDictionary *)userDetails withCompletion:(void(^)(NSError *error))completion;
+ (void)fetchContacts:(void(^)(NSArray *contacts, bool gotContacts))completion;
+ (void)logOutUser:(void(^)(bool didLogOut, NSError * error))completion;
+ (void)logInUser:(NSString *)usernane withPassword:(NSString *)password withCompletion:(void(^)(bool didLogIn, NSError * error))completion;
                    
@end
NS_ASSUME_NONNULL_END
