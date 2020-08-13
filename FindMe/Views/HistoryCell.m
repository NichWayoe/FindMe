//
//  HistoryCell.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setTrace:(Trace *)trace
{
    _trace = trace;
    self.durationLabel.text = trace.duration;
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.numberOfLocationsLabel.text = [NSString stringWithFormat:@"%ld", trace.locations.count];
    self.endDateLabel.text = [dateFormater stringFromDate:trace.dateEnded];
    self.startDateLabel.text = [dateFormater stringFromDate:trace.dateStarted];
}

@end
