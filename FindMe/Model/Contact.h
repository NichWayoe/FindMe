//
//  Contact.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *email;
    @property (nonatomic, strong) NSString *name;
    @property (nonatomic, strong) PFUser *user;
    @property (nonatomic, strong) NSString *telephoneNumber;

@end

NS_ASSUME_NONNULL_END
