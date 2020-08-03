//
//  Tracking.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/29/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "Trace.h"
#import "DateTools.h"

@implementation Trace

- (void)start
{
    self.dateStarted = [NSDate date];
}

- (void)stop:(NSArray *)locations
{
    self.locations = locations;
    self.dateEnded = [NSDate date];
    self.duration = [self.dateStarted shortTimeAgoSinceNow];
}

@end
