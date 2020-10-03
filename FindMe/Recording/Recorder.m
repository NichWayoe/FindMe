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
        NSURL *baseUrl = [NSURL fileURLWithPath:@"file:/Users/nwayoe/Documents/"];
        NSURL *url =[NSURL URLWithString:@"record.mp3" relativeToURL:baseUrl];
        self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
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


@end
