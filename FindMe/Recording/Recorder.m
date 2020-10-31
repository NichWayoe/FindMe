//
//  Recorder.m
//  FindMe
//
//  Created by Nicholas Wayoe on 9/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import "Recorder.h"

@interface Recorder ()

@property (nonatomic, strong) AVAudioRecorder* recorder;

@end

@implementation Recorder

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        NSDictionary *settings = @{
            AVFormatIDKey : @(kAudioFormatMPEG4AAC),
            AVSampleRateKey: @(12000),
            AVNumberOfChannelsKey: @(1),
        };
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [searchPaths objectAtIndex:0];
        NSString *pathToSave = [documentPath stringByAppendingPathComponent:[self dateString]];
        NSURL *outputFileURL = [NSURL fileURLWithPath:pathToSave];
        NSLog(@"%@",outputFileURL);
        self.recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:settings error:&error];
        if (self.recorder) {
        }
        else {
        }
    }
    return self;
}

- (void)start:(void(^)(NSError * error, BOOL isStarted))completion
{
    if (!self.recorder.isRecording) {
        completion(nil, [self.recorder record]);
    }
}

- (void)stop:(void(^)(NSError *error, BOOL isEnded))completion
{
    if (!self.recorder.isRecording) {
        completion(nil, NO);
    }
    else {
        [self.recorder stop];
        completion(nil, YES);
    }
}

- (NSString *)dateString
{
    NSDate *date = [NSDate new];
    date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"ddMMMYYY_hhmmssa";
    NSString *datestring = [[formatter stringFromDate:date] stringByAppendingString:@".m4a"];
    return datestring;
}

@end
