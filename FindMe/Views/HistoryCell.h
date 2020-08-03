//
//  HistoryCell.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trace.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) Trace *trace;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLocationsLabel;

@end

NS_ASSUME_NONNULL_END
