//
//  UIView+XFCircleLoading.m
//  test2
//
//  Created by 1 on 2018/12/19.
//  Copyright © 2018 weiyian. All rights reserved.
//

#import "UIView+XFCircleLoading.h"
#import "XFLoadingHUD.h"
@implementation UIView (XFCircleLoading)

- (void)drawCircleAnimate{
    
    CGFloat itemWidth = self.bounds.size.width > self.bounds.size.height ? self.bounds.size.height : self.bounds.size.width;
    [self drawCircleAnimateWithFrame:CGRectMake((self.bounds.size.width - itemWidth)/2, (self.bounds.size.height - itemWidth)/2, itemWidth, itemWidth)];
    
}

- (void)drawCircleAnimateWithWidth:(CGFloat)width{
    
    [self drawCircleAnimateWithFrame:CGRectMake((self.bounds.size.width - width)/2, (self.bounds.size.height - width)/2, width, width)];
    
}

- (void)drawCircleAnimateWithWidth:(CGFloat)width isLeft:(BOOL)isLeft{
    
    if (!isLeft) {
        [self drawCircleAnimateWithWidth:width];
    }else{
        [self drawCircleAnimateWithFrame:CGRectMake(self.bounds.size.width/5, (self.bounds.size.height - width)/2, width, width)];
    }
    
}

- (void)drawCircleAnimateWithFrame:(CGRect)frame{
    
    CALayer * bgLayer = [CALayer layer];
    bgLayer.frame = frame;
    [self.layer addSublayer:bgLayer];
    
    CAShapeLayer * bgLine =  [CAShapeLayer layer];
    CGMutablePathRef bgPath =  CGPathCreateMutable();
    bgLine.lineWidth = frame.size.width/10.0 ;
    bgLine.strokeColor = ([XFLoadingHUD shareInstance].circleBgColor?:LoadingGrayColor).CGColor;
    bgLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(bgPath, nil, CGRectMake(0, 0, frame.size.width, frame.size.height));
    bgLine.path = bgPath;
    CGPathRelease(bgPath);
    [bgLayer addSublayer:bgLine];
    
    CAShapeLayer * partLine =  [CAShapeLayer layer];
    partLine.lineWidth = frame.size.width/10.0 ;
    partLine.strokeColor = ([XFLoadingHUD shareInstance].circleColor?:LoadingBlueColor).CGColor;
    partLine.fillColor = [UIColor clearColor].CGColor;
    CGFloat radius = frame.size.width / 2;
    CGPoint center = CGPointMake(frame.size.width/2, frame.size.height/2);
    NSLog(@"center = %@",NSStringFromCGPoint(center));
    UIBezierPath * partPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.f endAngle:M_PI * 2 * 0.3  clockwise:YES];
    partLine.path = partPath.CGPath;
    [bgLayer addSublayer:partLine];
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = [XFLoadingHUD shareInstance].circleDuration;
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = FLT_MAX;
    [bgLayer addAnimation:animation forKey:@"rotationAnimation"];
    
}

- (void)hideCircle{
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
}

@end
