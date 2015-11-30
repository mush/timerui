//
//  CircularProgressLayer.m
//  CircularTimerViewExample
//
//  Created by Ashiqur Rahman on 11/29/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "RingProgressLayer.h"

@interface RingProgressLayer ()
@property(nonatomic) float progressPercentage;
@property(nonatomic) BOOL animate;
@end

@implementation RingProgressLayer{

}
@dynamic progressPercentage;
@dynamic ringLineWidth;
@dynamic animate;
@dynamic progressPathColor;
@dynamic resetAnimationTime;

#pragma mark - NSObject
-(instancetype)init{
    if(self = [super init]){
        self.ringLineWidth = 10.0f;
        self.resetAnimationTime = 0.3;
    }
    return self;
}

#pragma mark - Private
-(void)setPercentage:(float)percentage animate:(BOOL)animate{
    if((int)percentage < 0){
        percentage = 0;
    }
    if((int)percentage > 100){
        percentage = 100;
    }
    self.animate = animate;
    self.progressPercentage = percentage;
    
}

-(void)drawCircleInContext:(CGContextRef)ctx
                startAngle:(float)startAngle
                  endAngle:(float)endAngle
                 lineWidth:(CGFloat)lineWidth
                 fillColor:(CGColorRef)fillColor
               strokeColor:(CGColorRef)strokeColor{


    CGRect rect = CGContextGetClipBoundingBox(ctx);
    CGSize rectSize = rect.size;
    
    CGMutablePathRef arc = CGPathCreateMutable();
    CGPathAddArc(arc,
                 NULL,
                 rectSize.width/2,
                 rectSize.height/2,
                 MIN(rectSize.width,rectSize.height)/2 - lineWidth,
                 startAngle,
                 endAngle,
                 NO);
        
    CGPathRef strokedArc = CGPathCreateCopyByStrokingPath(arc,
                                   NULL,
                                   lineWidth,
                                   kCGLineCapButt,
                                   kCGLineJoinMiter,
                                   1);
    
    CGContextSetFillColorWithColor(ctx, fillColor);
    CGContextSetStrokeColorWithColor(ctx, strokeColor);
    
    CGContextAddPath(ctx, strokedArc);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGPathRelease(arc);
    CGPathRelease(strokedArc);
}
#pragma mark - CALayer
-(void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
    
    float startAngle = -M_PI/2;
    float endAngle = (2*M_PI/100.0)*self.progressPercentage - M_PI/2;
    
    //draw the progress circle
    [self drawCircleInContext:ctx
                   startAngle:startAngle
                     endAngle:endAngle
                    lineWidth:self.ringLineWidth
                    fillColor:self.progressPathColor
                  strokeColor:self.progressPathColor];
    
    
}

+(BOOL)needsDisplayForKey:(NSString *)key{
    if([key isEqualToString:@"progressPercentage"]){
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event{

    if([event isEqualToString:@"progressPercentage" ] && self.animate){
        CABasicAnimation *anim = [CABasicAnimation
                                  animationWithKeyPath:@"progressPercentage"];
        anim.fromValue = [[self presentationLayer]
                          valueForKey:@"progressPercentage"];
        anim.duration = self.resetAnimationTime;
        return anim;
    }
    
    return [super actionForKey:event];
}
@end
