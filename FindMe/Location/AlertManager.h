//
//  AlertManager.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/27/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlertManager : NSObject

+ (void)makeStringFromPlacemarkAndSendEmail:(CLPlacemark *)location withContact:(Contact *)contact;
+ (void)sendEmail:(NSString *)firstName toEmail:(NSString *)email withMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
