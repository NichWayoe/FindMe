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

+ (void)sendEmail:(NSString *)firstName toEmail:(NSString *)email withMessage:(NSString *)message
{
    Mailgun *mailgun = [Mailgun clientWithDomain:@"" apiKey:@""];
    [mailgun sendMessageTo:email
                      from:@"FindMe <nwayoe@gmail.com>"
                   subject:@"Location Notification Update"
                      body:message];
}

@end

