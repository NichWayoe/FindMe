//
//  FindMeViewController.m
//  FindMe
//
//  Created by Nicholas Wayoe on 7/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "FindMeViewController.h"
#import "LocationManager.h"
#import "RecordingSession.h"
#import "Recorder.h"

@interface FindMeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *trackingButton;
@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) Recorder *recorder;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (assign) int seconds;
@property (assign) int fractions;
@property (assign) int hours;
@property (assign) int minutes;
@property (weak, nonatomic) IBOutlet UILabel *factionsLabel;

@end

@implementation FindMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeTimer];
    self.locationManager = LocationManager.shared;
    self.trackingButton.layer.cornerRadius = 75;
    [self designTrackingButtonWithState:@"unselected"];
    [self permissionsStatusActions];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self permissionsStatusActions];
}

- (IBAction)onFindMe:(id)sender
{
    if (!self.trackingButton.isSelected) {
        if ([self.locationManager authorisationStatus] == AllowedAlways) {
            [self designTrackingButtonWithState:@"selected"];
            [self.locationManager beginTracking];
            [RecordingSession activateSession:^(NSError * _Nonnull error, BOOL isActivated) {
                if (isActivated) {
                    self.recorder = [Recorder new];
                    [self.recorder start:^(NSError * _Nonnull error, BOOL isStarted) {
                        if (isStarted) {
                            
                        }
                        else {
                            [self showAlert];
                        }
                    }];
                }
                else {
                    [self showAlert];
                }
            }];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
        }
        else {
            [self showAlert];
        }
    }
    else {
        [self.recorder stop:^(NSError * _Nonnull error, BOOL isEnded) {
        }];
        [self designTrackingButtonWithState:@"unselected"];
        [self.timer invalidate];
        [self.locationManager stopTracking];
        [self initializeTimer];
    }
}

- (void)initializeTimer
{
    self.hours = 0;
    self.seconds = 0;
    self.minutes = 0;
    self.fractions = 0;
    self.factionsLabel.text = @".00";
    self.timeLabel.text = @"00:00:00";
}

- (void)startTimer
{
    self.fractions += 1;
    if (self.fractions > 99) {
        self.seconds += 1;
        self.fractions = 0;
    }
    if (self.seconds > 60) {
        self.minutes += 1;
        self.seconds = 0;
    }
    if (self.minutes > 60) {
        self.minutes = 0;
        self.hours += 1;
    }
    [self setTimerLabel:self.hours withMinutes:self.minutes withSeconds:self.seconds withfractions:self.fractions];
}

- (void)setTimerLabel:(int )hours withMinutes:(int )minutes withSeconds:(int )seconds withfractions:(int)fractions {
    NSString *secondsText;
    NSString *fractionsText;
    NSString *hoursText;
    NSString *minutesText;
    if (self.seconds <= 9) {
        secondsText = [NSString stringWithFormat:@"0%i", seconds];
    }
    else {
        secondsText = [NSString stringWithFormat:@"%i", seconds];
    }
    if (self.fractions <= 9) {
        fractionsText = [NSString stringWithFormat:@".0%i", fractions];
    }
    else {
        fractionsText = [NSString stringWithFormat:@".%i", fractions];
    }
    if (self.hours <= 9) {
        hoursText = [NSString stringWithFormat:@"0%i", hours];
    }
    else {
        hoursText = [NSString stringWithFormat:@"%i", hours];
    }
    if (self.minutes <= 9) {
        minutesText = [NSString stringWithFormat:@"0%i", minutes];
    }
    else {
        minutesText = [NSString stringWithFormat:@"%i", minutes];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hoursText, minutesText, secondsText];
    self.factionsLabel.text = fractionsText;
}

- (void)permissionsStatusActions
{
    if ([self.locationManager canGetLocation]) {
        switch ([self.locationManager authorisationStatus]) {
            case AllowedAlways:
                break;
            case AllowedWhenInUse:
                [self.locationManager requestLocationPermission];
                break;
            case Denied:
            case Restricted:
                [self showAlert];
                break;
            case NotDetermined:
                break;
        }
    }
    else {
        [self showAlert];
    }
}

- (void)designTrackingButtonWithState:(NSString *)state
{
    if ([state isEqualToString:@"selected"]) {
        self.trackingButton.selected = YES;
        self.trackingButton.titleLabel.text = @"STOP";
        self.trackingButton.highlighted = NO;
        self.trackingButton.backgroundColor = [UIColor redColor];
    }
    else {
        self.trackingButton.selected = NO;
        self.trackingButton.titleLabel.textColor = [UIColor whiteColor];
        self.trackingButton.titleLabel.text = @"SS";
        self.trackingButton.backgroundColor = [UIColor greenColor];
    }
}

- (void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission not Allowed"
                                                                   message:@"We need your permission to show you on the map. TO allow, open settings and enable locations"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"Open Settings"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [application openURL:settingURL options:@{} completionHandler:^(BOOL success) {
            if (success) {
            }
        }];
    }];
    [alert addAction:settingAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
