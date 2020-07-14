//
//  User.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/13/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *email;
    @property (nonatomic, strong) NSString *password;
    @property (nonatomic, strong) NSString *firstName;
    @property (nonatomic, strong) NSString *lastName;
    @property (nonatomic, strong) UIImage *profileImage;

@end

NS_ASSUME_NONNULL_END
