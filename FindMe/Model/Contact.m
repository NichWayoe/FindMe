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
            self.firstName = @"";
        }
        if (contact.familyName) {
            self.lastName = contact.familyName;
        }
        else {
            self.firstName = @"";
        }
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        if ([emailTest evaluateWithObject:contact.emailAddresses.firstObject.value]) {
            self.email = contact.emailAddresses.firstObject.value;
        }
        else {
            self.email = @"";
        }
        if (contact.imageDataAvailable) {
            self.profileImageData = contact.thumbnailImageData;
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
