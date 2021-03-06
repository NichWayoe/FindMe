//
//  ContactCell.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/20/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setContact:(Contact *)contact
{
    _contact = contact;
    self.contactProfileImageView.layer.cornerRadius = 25;
    self.contactNameLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    self.emailField.text = contact.email;
    if (contact.profileImageData) {
        self.contactProfileImageView.image = [UIImage imageWithData:contact.profileImageData];
    }
    else {
        self.contactProfileImageView.image = [UIImage systemImageNamed:@"person" ];
    }
}

@end
