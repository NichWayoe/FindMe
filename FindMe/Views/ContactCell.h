//
//  ContactCell.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/20/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contactProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneNumberLabel;
@property(nonatomic,strong)Contact *contact;

@end

NS_ASSUME_NONNULL_END
