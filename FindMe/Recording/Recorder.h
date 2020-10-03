//
//  Recorder.h
//  FindMe
//
//  Created by Nicholas Wayoe on 9/14/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface Recorder : NSObject

@property (nonatomic) BOOL isRecording;

- (void)start:(void(^)(NSError * error, BOOL isStarted))completion;
- (void)stop:(void(^)(NSError *error, BOOL isEnded))completion;

@end

NS_ASSUME_NONNULL_END
