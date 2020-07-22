//
//  User.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/22/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSData   *profileImageData;

- (instancetype)initWithDictionary:(NSDictionary *)userDetails;
@end

NS_ASSUME_NONNULL_END
