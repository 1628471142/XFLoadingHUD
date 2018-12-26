//
//  XFRefreshHeader.m
//  XFOA
//
//  Created by 1 on 2018/12/17.
//  Copyright © 2018 weiyian. All rights reserved.
//
#define HeaderDefaultHeight 54
#define  IndicatorWidth 20
#import "NSBundle+MJRefresh.h"
#import "XFRefreshHeader.h"
#import "UIView+XFCircleLoading.h"
#import "UIView+XFLoadingAnimate.h"

@interface XFRefreshHeader()
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation XFRefreshHeader

#pragma mark - 懒加载子控件
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.hidesWhenStopped = YES;
        [loadingView setFrame:CGRectMake((self.bounds.size.width - IndicatorWidth)/2, (self.bounds.size.height - IndicatorWidth)/2, 20, 20)];
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}
#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        [self hideLoading];
    } else if (state == MJRefreshStatePulling) {
        [self hideLoading];
    } else if (state == MJRefreshStateRefreshing) {
        [self showLoading];
    }
}

- (void)showLoading{
    if (self.animateStyle == XFLoadingGraphAnimateStyleCircle) {
        [self drawCircleAnimateWithWidth:20.f];
    }
    else if (self.animateStyle == XFLoadingGraphAnimateStyleIndicator){
        [self.loadingView startAnimating];
    }
    else{
        [self drawWordAnimationWithText:@"XF" fontSize:20];
    }
}

- (void)hideLoading{
    if (self.animateStyle == XFLoadingGraphAnimateStyleIndicator) {
        [self.loadingView stopAnimating];
        [self.loadingView removeFromSuperview];//为了切换动画时，释放loadingview。防止移除的图层对象没有释放，再次走removeFromSuperlayer方法报错
    }
    else if (self.animateStyle == XFLoadingGraphAnimateStyleWordPath){
        [UIView animateWithDuration:0.25 animations:^{
            [self hideXFLoading];
        }];
    }
    else{
        [self.layer removeAllAnimations];
        NSLog(@"circle.sublayers.count = %ld",self.layer.sublayers.count);
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
}

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action animateStyle:(XFLoadingGraphAnimateStyle)animateStyle{
    
    XFRefreshHeader * header = (XFRefreshHeader *)[super headerWithRefreshingTarget:target refreshingAction:action];
    header.animateStyle = animateStyle;
    return header;
    
}

- (void)setAnimateStyle:(XFLoadingGraphAnimateStyle)animateStyle{
    
    [self hideLoading];
    _animateStyle = animateStyle;
    
}


@end
