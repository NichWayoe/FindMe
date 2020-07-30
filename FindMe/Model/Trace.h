//
//  Tracking.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/29/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tracking : NSObject

@property (nonatomic, strong) NSDate *dateStarted;
@property (assign) int numberOfContacts;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) NSString *duration;

@end

NS_ASSUME_NONNULL_END
