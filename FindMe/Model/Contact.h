//
//  Contact.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "User.h"
@import Contacts;
@import ContactsUI;

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSData *profileImageData;
@property (nonatomic, strong) NSDate *dateCreated;

+ (NSMutableArray *)contactsWithArray:(NSArray *)selectedContacts;

@end
NS_ASSUME_NONNULL_END
