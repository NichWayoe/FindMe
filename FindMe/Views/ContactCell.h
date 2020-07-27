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
@property(nonatomic,strong)Contact *contact;
@property (weak, nonatomic) IBOutlet UILabel *emailField;

@end

NS_ASSUME_NONNULL_END
