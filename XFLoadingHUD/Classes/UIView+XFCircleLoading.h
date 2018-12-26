//
//  UIView+WYACircleLoading.h
//  test2
//
//  Created by 1 on 2018/12/19.
//  Copyright © 2018 weiyian. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XFCircleLoading)

- (void)drawCircleAnimate;
- (void)drawCircleAnimateWithWidth:(CGFloat)width;
- (void)drawCircleAnimateWithWidth:(CGFloat)width isLeft:(BOOL)isLeft;
- (void)drawCircleAnimateWithFrame:(CGRect)frame;

- (void)hideCircle;

@end

NS_ASSUME_NONNULL_END
