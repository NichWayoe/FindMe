//
//  LabelCell.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "LabelCell.h"

@implementation LabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor lightGrayColor];    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
