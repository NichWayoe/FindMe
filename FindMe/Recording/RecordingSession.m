//
//  RecordingSession.m
//  FindMe
//
//  Created by Nicholas Wayoe on 9/26/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "RecordingSession.h"


@interface RecordingSession ()

@property (nonatomic, strong) AVAudioSession* session;
@property (nonatomic) BOOL isActive;

@end

@implementation RecordingSession

- (instancetype)init{
    self = [super init];
    if (self) {
        self.session = [AVAudioSession sharedInstance];
    }
    return self;
}

- (void)setUpRecordingSession:(void(^)(NSError * error, BOOL isSuccessful))completion
{
    NSError *error;
    BOOL success = [self.session setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeDefault options:0 error:&error];
    if (!success) {
        completion(error, NO);
    }
    else {
        completion(nil, YES);
    }
}

- (void)activateSession:(void(^)(NSError * error, BOOL isActivated))completion
{
    NSError *error;
    if (self.isActive) {
    }
    else {
        BOOL sucess = [self.session setActive:YES error:&error];
        if (!sucess) {
            completion(error, NO);
        }
        else {
            completion(nil, YES);
        }
    }
}

- (void)deactivateSucession:(void(^)(NSError * error, BOOL isDeactivated))completion
{
    NSError *error;
    if (self.isActive) {
        BOOL success = [self.session setActive:YES error:&error];
        if (!success) {
            completion(error, NO);
        }
        else {
            completion(nil, YES);
        }
    }
}

@end


