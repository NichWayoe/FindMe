//
//  HistoryCell.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfContactLabel;

@end

NS_ASSUME_NONNULL_END
