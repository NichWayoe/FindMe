//
//  HistoryViewController.h
//  FindMe
//
//  Created by Nicholas Wayoe on 7/28/20.
//  Copyright © 2020 Nicholas Wayoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trace.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HistoryViewControllerDelegate <NSObject>

- (void)didSelectCellWithTrace:(Trace *)trace;

@end

@interface HistoryViewController : UIViewController

@property (nonatomic, weak) id<HistoryViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
