//
//  TraceCell.h
//  FindMe
//
//  Created by Nicholas Wayoe on 8/3/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface TraceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) Location* location;

@end

NS_ASSUME_NONNULL_END
