//
//  CircularProgressLayer.h
//  CircularTimerViewExample
//
//  Created by Ashiqur Rahman on 11/29/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface RingProgressLayer : CALayer
/**
 *  Thickness of the ring;
 */
@property(nonatomic) CGFloat ringLineWidth;

/**
 *  Color of the progress path.
 */
@property(nonatomic) CGColorRef progressPathColor;

/**
 *  Time for the resetting animation.
 */
@property(nonatomic) CFTimeInterval resetAnimationTime;

/**
 *  Set the percentage of the progress path.
 *
 *  @param percentage in range of 0 to 100.
 *  @param animate    if YES then the progress will be animated from the current value.
 */
-(void)setPercentage:(float)percentage animate:(BOOL)animate;
@end
