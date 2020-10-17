//
//  RecordingSession.h
//  FindMe
//
//  Created by Nicholas Wayoe on 9/26/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface RecordingSession : NSObject

- (void)setUpRecordingSession:(void(^)(NSError * error, BOOL isSuccessful))completion;
- (void)activateSession:(void(^)(NSError * error, BOOL isActivated))completion;
- (void)deactivateSucession:(void(^)(NSError * error, BOOL isDeactivated))completion;

@end

NS_ASSUME_NONNULL_END


