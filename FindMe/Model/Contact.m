//
//  Contact.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "Contact.h"
@import Contacts;
@import ContactsUI;

@implementation Contact

@dynamic telephoneNumber;
@dynamic name;
@dynamic user;
@dynamic email;
@dynamic lastName;

+ (nonnull NSString *)parseClassName
{
    return @"Contact";
}

+ (void)uploadContacts: (NSArray<CNContact*> *)contacts withCompletion: (PFBooleanResultBlock  _Nullable)completion
{
    if(contacts) {
        for (CNContact *contact in contacts) {
            Contact *newContact = [Contact new];
            newContact.name = contact.givenName;
            newContact.user = [PFUser currentUser];
            if(contact.givenName) {
                newContact.lastName = contact.familyName;
            }
            else {
                
            }
            if (contact.emailAddresses) {
                newContact.email = contact.emailAddresses.firstObject.value;
            }
            else {
                
            }
            newContact.telephoneNumber = contact.phoneNumbers.firstObject.value.stringValue;
            [newContact saveInBackgroundWithBlock: completion];
        }
    }
}

@end
