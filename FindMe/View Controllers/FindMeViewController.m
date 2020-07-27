//
//  FindMeViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "FindMeViewController.h"
#import "LocationManager.h"

@interface FindMeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *trackingButton;
@property (strong, nonatomic) LocationManager *mylocation;

@end

@implementation FindMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mylocation = LocationManager.shared;
    self.trackingButton.backgroundColor = [UIColor redColor];
    self.trackingButton.layer.cornerRadius = 75;
}

- (IBAction)onFindMe:(id)sender
{
    if (!self.trackingButton.isSelected) {
        [self designTrackingButtonWithState:@"selected"];
        [self.mylocation beginTracking];
    }
    else {
        [self designTrackingButtonWithState:@"unselected"];
        [self.mylocation stopTracking];
    }
}

- (void)designTrackingButtonWithState:(NSString *)state
{
    if ([state isEqualToString:@"selected"]) {
        self.trackingButton.selected = YES;
        self.trackingButton.highlighted = NO;
        self.trackingButton.backgroundColor = [UIColor greenColor];
    }
    else {
        self.trackingButton.selected = NO;
        self.trackingButton.highlighted = NO;
        self.trackingButton.backgroundColor = [UIColor redColor];
    }
}

@end
