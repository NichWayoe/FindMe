//
//  Contact.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Parse/Parse.h>
@import Contacts;
@import ContactsUI;

NS_ASSUME_NONNULL_BEGIN

@interface Contact : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *email;
    @property (nonatomic, strong) NSString *name;
    @property (nonatomic, strong) NSString *lastName;
    @property (nonatomic, strong) PFUser *user;
    @property (nonatomic, strong) NSString *telephoneNumber;

+ (void)uploadContacts: (NSArray<CNContact*> *)contacts withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end
NS_ASSUME_NONNULL_END
