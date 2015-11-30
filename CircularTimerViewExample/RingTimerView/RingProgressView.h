//
//  CircularProgressView.h
//  CircularTimerViewExample
//
//  Created by Ashiqur Rahman on 11/29/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, RingProgressState) {
    RingProgressStatePaused,
    RingProgressStateStarted,
    RingProgressStateCompleted,
    RingProgressStateNone
};


@interface RingProgressView : UIView

/**
 *  Current state of the timer;
 */
@property(nonatomic, readonly) RingProgressState state;

/**
 *  Duration in seconds for the timer.
 */
@property(nonatomic, assign) NSTimeInterval timerDuration;

@end
