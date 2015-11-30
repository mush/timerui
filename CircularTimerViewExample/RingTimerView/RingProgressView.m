//
//  CircularProgressView.m
//  CircularTimerViewExample
//
//  Created by Ashiqur Rahman on 11/29/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "RingProgressView.h"
#import "RingProgressLayer.h"

static CGFloat const kCircleLineWidth = 15.0f;
static CFTimeInterval const kResetAnimationTime = 0.3f;

@interface RingProgressView ()
@property(nonatomic) CADisplayLink *displayLink;
@property(nonatomic) double elapsedTime;
@property(nonatomic) RingProgressState state;

@property(nonatomic) RingProgressLayer *timerLayer;
@property(nonatomic) CAShapeLayer *bgLayer;

@end

@implementation RingProgressView{
    

}
#pragma mark - Private
-(void)setup{
    
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:gesture];
    
    self.timerDuration = 5.0;
    self.state = RingProgressStateNone;
    
    //background layer setup
    self.bgLayer = [CAShapeLayer layer];
    self.bgLayer.fillColor = [UIColor whiteColor].CGColor;
    self.bgLayer.strokeColor = [UIColor grayColor].CGColor;
    self.bgLayer.lineWidth = kCircleLineWidth;
    self.bgLayer.lineJoin = kCALineJoinBevel;
    [self.layer addSublayer:self.bgLayer];
    
    
    //progress timer layer setup
    self.timerLayer = [RingProgressLayer layer];
    self.timerLayer.ringLineWidth = kCircleLineWidth;
    self.timerLayer.progressPathColor = [UIColor blackColor].CGColor;
    self.timerLayer.resetAnimationTime = kResetAnimationTime;
    [self.layer addSublayer:self.timerLayer];    
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{

    //draw the bg path.
    self.bgLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.bgLayer.lineWidth, self.bgLayer.lineWidth)];
    [self.bgLayer setPath:path.CGPath];
    
    self.timerLayer.frame = self.bounds;
}

-(void)stopLoop{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

-(void)startLoop{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    self.displayLink.frameInterval = 1;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark - UIGestureCallback
-(void)tap:(UITapGestureRecognizer*)gesture{
    switch (self.state) {
        case RingProgressStateNone:
            [self startLoop];
            self.state = RingProgressStateStarted;
            break;
        case RingProgressStateStarted:
            [self stopLoop];
            self.state = RingProgressStatePaused;
            break;
        case RingProgressStatePaused:
            [self startLoop];
            self.state = RingProgressStateStarted;
            break;
        case RingProgressStateCompleted:
            self.elapsedTime = 0;
            [self.timerLayer setPercentage:0 animate:YES];
            self.state = RingProgressStateNone;
            break;
        default:
            break;
    }
}
#pragma mark CADisplay Tick
-(void)tick:(CADisplayLink*)displayLink{
    
    self.elapsedTime += self.displayLink.duration * self.displayLink.frameInterval;
    
    [self.timerLayer setPercentage:(self.elapsedTime/self.timerDuration)*100.0 animate:NO];
    
    if(self.elapsedTime >= self.timerDuration){
        self.state = RingProgressStateCompleted;
        [self stopLoop];
    }
    
}
#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}
@end
