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

- (instancetype)initWithContact:(CNContact *)contact
{
    self = [super init];
    if (self) {
        self.firstName = contact.givenName;
        if (contact.familyName) {
            self.lastName = contact.familyName;
        }
        else {
            
        }
        if (contact.emailAddresses) {
            self.email = contact.emailAddresses.firstObject.value;
        }
        else {
        }
        self.telephoneNumber = contact.phoneNumbers.firstObject.value.stringValue;
    }
    return self;
}

+ (NSMutableArray *)contactsWithArray:(NSArray *)selectedContacts
{
    NSMutableArray *contacts = [NSMutableArray new];
    if (selectedContacts) {
        for (CNContact *contact in selectedContacts) {
            Contact *newContact = [[Contact alloc] initWithContact:contact];
            [contacts addObject:newContact];
        }
        return contacts;
    }
    else
        return nil;
}

@end
