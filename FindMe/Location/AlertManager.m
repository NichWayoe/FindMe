//
//  AlertManager.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/27/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "AlertManager.h"
#import "Mailgun/Mailgun.h"
#import "DatabaseManager.h"
#import "Contact.h"

@implementation AlertManager

+ (void)makeStringFromPlacemarkAndSendEmail:(CLPlacemark *)decodedLocation withContact:(Contact *)contact
{
    NSString *message = [NSString stringWithFormat: @" \
                         Address : %@ %@ %@ \
                         \
                         city : %@ \
                         \
                         Neighbourhood: %@ \
                         \
                         State : %@ \
                         \
                         Country : %@ \
                         \
                         Your are receiving this notification because put you as emergency Contact. \
                         ",decodedLocation.subThoroughfare, decodedLocation.thoroughfare, decodedLocation.postalCode, decodedLocation.locality, decodedLocation.subLocality, decodedLocation.administrativeArea, decodedLocation.country];
    [AlertManager sendEmail:contact.firstName toEmail:contact.email withMessage:message];
}

+ (void)sendEmail:(NSString *)firstName toEmail:(NSString *)email withMessage:(NSString *)message
{
    Mailgun *mailgun = [Mailgun clientWithDomain:@"" apiKey:@""];
    [mailgun sendMessageTo:email
                      from:@"FindMe <nwayoe@gmail.com>"
                   subject:@"Location Notification Update"
                      body:message];
}

@end

