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
    self.contactNameLabel.text = [contact.lastName stringByAppendingString:contact.firstName];
    self.emailField.text = contact.email;
    self.contactProfileImageView.image = [UIImage imageWithData:contact.profileImageData];
}

@end
