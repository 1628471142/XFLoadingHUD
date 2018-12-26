//
//  UIView+XFLoadingAnimate.h
//  test2
//
//  Created by 1 on 2018/12/13.
//  Copyright © 2018 weiyian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFLoadingHUD.h"


@interface UIView (XFLoadingAnimate)<CAAnimationDelegate>

//隐藏loading
- (void)hideXFLoading;

/**
 在view上绘制文字动画，字体和frame自适应，起始和结束颜色为默认
 
 @param text 文字
 */
- (void)drawWordAnimationWithText:(NSString *)text;

/**
 在view上绘制文字动画，字体和frame自适应，起始和结束颜色为默认
 
 @param text 文字
 @param fontSize 字体大小
 */
- (void)drawWordAnimationWithText:(NSString *)text fontSize:(CGFloat)fontSize;

/**
 在view上绘制文字动画，字体和frame自适应，起始和结束颜色为默认
 
 @param size 文字所占区域大小
 @param text 文字
 @param position 相对位置
 */
- (void)drawWordAnimationWithSize:(CGSize)size text:(NSString *)text position:(XFLoadingPosition)position;

/**
 在view上绘制文字动画，使用默认字体，设置字体大小
 @param size 文字所占区域大小
 @param text 文字
 @param fontSize 字体大小
 @param position 相对位置
 */
- (void)drawWordAnimationWithSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize position:(XFLoadingPosition)position;


/**
 在view上绘制文字动画，起始和结束颜色为默认
 
 @param size 文字所占区域大小
 @param text 文字
 @param font 字体
 */
- (void)drawWordAnimationWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font position:(XFLoadingPosition)position;

/**
 在view上绘制文字动画
 
 @param size 文字所占区域大小
 @param text 文字
 @param font 字体
 @param startColor 文字路径起始背景色
 @param endColor 文字路径描绘后的颜色
 */
- (void)drawWordAnimationWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/**
 在view上绘制文字动画
 
 @param size 文字所占区域大小
 @param text 文字
 @param font 字体
 @param startColor 文字路径起始背景色
 @param endColor 文字路径描绘后的颜色
 */
- (void)drawWordAnimationWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font startColor:(UIColor *)startColor endColor:(UIColor *)endColor position:(XFLoadingPosition)position;


@end

