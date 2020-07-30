//
//  Tracking.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/29/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trace : NSObject

@property (nonatomic, strong) NSDate *dateStarted;
@property (nonatomic, strong) NSDate *dateEnded;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) NSString *duration;

- (void)start;
- (void)stop:(NSArray *)locations;

@end

NS_ASSUME_NONNULL_END
