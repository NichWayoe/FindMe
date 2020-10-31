//
//  RecordingSession.m
//  FindMe
//
//  Created by Nicholas Wayoe on 9/26/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "RecordingSession.h"

@implementation RecordingSession

+ (void)setUpRecordingSession:(void(^)(NSError * error, BOOL isSuccessful))completion
{
    AVAudioSession *session = [AVAudioSession new];
    NSError *error;
    BOOL success = [session setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeDefault options:0 error:&error];
    if (!success) {
        completion(error, NO);
    }
    else {
        [session requestRecordPermission:^(BOOL granted) {
        }];
        completion(nil, YES);
    }
}

+ (void)activateSession:(void(^)(NSError * error, BOOL isActivated))completion
{
        NSError *error;
        AVAudioSession *session = [AVAudioSession new];
        BOOL sucess = [session setActive:YES error:&error];
        if (!sucess) {
            completion(error, NO);
        }
        else {
            completion(nil, YES);
        }
    }

+ (void)deactivateSucession:(void(^)(NSError * error, BOOL isDeactivated))completion
{
    NSError *error;
    AVAudioSession *session = [AVAudioSession new];
    BOOL sucess = [session setActive:NO error:&error];
    if (!sucess) {
        completion(error, NO);
    }
    else {
        completion(nil, YES);
    }
}

@end


