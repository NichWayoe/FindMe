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
        if (contact.givenName) {
            self.firstName = contact.givenName;
        }
        else {
            
        }
        if (contact.familyName) {
            self.lastName = contact.familyName;
        }
        else {
            
        }
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        if ([emailTest evaluateWithObject:contact.emailAddresses.firstObject.value]) {
            self.email = contact.emailAddresses.firstObject.value;
        }
        else {
        }
        NSString *phoneRegrex = @"^\\d{3}-\\d{3}-\\d{4}$";
        NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegrex];
        if ([phoneNumberTest evaluateWithObject:contact.phoneNumbers.firstObject.value.stringValue]) {
            self.telephoneNumber = contact.phoneNumbers.firstObject.value.stringValue;
        }
        else {
        }
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
