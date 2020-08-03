//
//  TraceCell.m
//  FindMe
//
//  Created by Nicholas Wayoe on 8/3/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "TraceCell.h"

@implementation TraceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setLocation:(Location *)location
{
    _location = location;
    self.cityLabel.text = location.city;
    self.addressLabel.text = location.address;
    self.countryLabel.text = location.country;
    self.stateLabel.text = location.state;
}

@end
