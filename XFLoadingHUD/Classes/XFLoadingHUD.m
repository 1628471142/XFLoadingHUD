//
//  XFLoadingHUD.m
//  test2
//
//  Created by 1 on 2018/12/5.
//  Copyright © 2018 weiyian. All rights reserved.
//
#import "XFLoadingHUD.h"
#import "UIView+XFLoadingAnimate.h"
#import "UIView+XFCircleLoading.h"
#define XF_RGB_COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface XFLoadingHUD ()
@property (nonatomic, strong) UIView * containerView;//loading控件载体
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, weak) UIView * wordPathView;//文字描绘载体
@property (nonatomic, weak) UIView * circleView;
@property (nonatomic, weak) UIActivityIndicatorView * indicatorView;
@property (nonatomic, assign) BOOL isShowing;//正在展示动画
@property (nonatomic, strong) UIVisualEffectView * visualEffectView;//毛玻璃，添加在loading父容器中
@property (nonatomic, assign) float keyboardOffsetY;// 键盘偏移量

@end

@implementation XFLoadingHUD

+ (XFLoadingHUD *)shareInstance{
    static XFLoadingHUD * _loadingView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _loadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, XFLoadingScreenWidth, XFLoadingScreenHeight)];
        
        _loadingView.bgView = [[UIView alloc] initWithFrame:_loadingView.bounds];
        [_loadingView.bgView setBackgroundColor:XF_RGB_COLOR(0, 0, 0,0)];
        
        _loadingView.containerView = [[UIView alloc] init];
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _loadingView.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_loadingView.containerView addSubview:_loadingView.visualEffectView];
        _loadingView.containerView.layer.cornerRadius = 5.0;
        _loadingView.containerView.layer.masksToBounds = YES;
        
        [_loadingView addSubview:_loadingView.bgView];
        [_loadingView addSubview:_loadingView.containerView];
        [_loadingView configDefault];
        
        [[NSNotificationCenter defaultCenter] addObserver:_loadingView selector:@selector(keyboardDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
        
    });
    return _loadingView;
}

- (UIView *)wordPathView{
    if (_wordPathView == nil) {
        UIView *wordPathView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        _wordPathView = wordPathView;
        [self.containerView addSubview:_wordPathView];
    }
    return _wordPathView;
}

- (UIView *)circleView{
    if (_circleView == nil) {
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake((self.containerView.frame.size.width - self.circleWidth)/2,(self.containerView.frame.size.height - self.circleWidth)/2, self.circleWidth, self.circleWidth)];
        _circleView = circleView;
        [self.containerView addSubview:_circleView];
    }
    return _circleView;
}

- (UIActivityIndicatorView *)indicatorView{
    if (_indicatorView == nil) {
        UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicatorView setFrame:CGRectMake((self.containerView.frame.size.width - self.indicatorWidth)/2,(self.containerView.frame.size.height - self.indicatorWidth)/2, self.indicatorWidth, self.indicatorWidth)];
        _indicatorView = indicatorView;
        [self.containerView addSubview:_indicatorView];
    }
    return _indicatorView;
}

//默认设置
- (void)configDefault{
    self.themeStyle = XFLoadingBackgroundStyleDark;
    self.animateStyle = XFLoadingGraphAnimateStyleCircle;
    self.animateDirection = XFLoadingGraphDirectionEndToEnd;
    self.circleBgColor = [UIColor whiteColor];
    self.circleColor = LoadingBlueColor;
    self.customDuration = 3.0f;
    self.circleDuration = 1.2f;
    self.circleWidth = 35.f;
    self.indicatorWidth = 100.f;
    self.bgAlpha = 0.2;
    self.containerSize = CGSizeMake(100, 100);
    self.keyboardOffsetY = XFLoadingScreenHeight;
}

- (void)setContainerCornerRadius:(float)containerCornerRadius{
    _containerCornerRadius = containerCornerRadius;
    [XFLoadingHUD shareInstance].containerView.layer.cornerRadius = containerCornerRadius;
}

- (void)setContainerSize:(CGSize)containerSize{
    _containerSize = containerSize;
    [self.containerView setFrame:CGRectMake(0, 0, self.containerSize.width, self.containerSize.height)];
    [self.visualEffectView setFrame:CGRectMake(0, 0, self.containerSize.width, self.containerSize.width)];
}


- (void)setThemeStyle:(XFLoadingBackgroundStyle)themeStyle{
    _themeStyle = themeStyle;
    if (themeStyle == XFLoadingBackgroundStyleDark) {
        self.circleBgColor = [UIColor whiteColor];
        self.visualEffectView.hidden = NO;
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        [self.visualEffectView setEffect:effect];
    }
    if (themeStyle == XFLoadingBackgroundStyleLight) {
        self.circleBgColor = LoadingGrayColor;
        self.visualEffectView.hidden = NO;
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        [self.visualEffectView setEffect:effect];
    }
    if (themeStyle == XFLoadingBackgroundStyleNone) {
        self.circleBgColor = LoadingGrayColor;
        self.visualEffectView.hidden = YES;
    }
}

- (void)setAnimateStyle:(XFLoadingGraphAnimateStyle)animateStyle{
    _animateStyle = animateStyle;
}

+ (void)showXFLoadingInView:(UIView *)view{
    [[self shareInstance] showXFLoadingInView:view];
}

+ (void)showXFLoading{
    [[self shareInstance] showXFLoadingInView:[UIApplication sharedApplication].keyWindow];
}

+ (void)show{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showInView:(UIView *)view{
    [[self shareInstance] showInView:view];
}

- (void)showInView:(UIView *)view{
    [self layoutSubviewsCenterInView:view];
    if (self.animateStyle == XFLoadingGraphAnimateStyleCircle) {
        [self.circleView drawCircleAnimateWithFrame:CGRectMake(0,0, self.circleWidth, self.circleWidth)];
    }
    else if (self.animateStyle == XFLoadingGraphAnimateStyleIndicator){
        [self.indicatorView startAnimating];
    }
    else if (self.animateStyle == XFLoadingGraphAnimateStyleWordPath){
        [self.wordPathView drawWordAnimationWithText:@"XF"];
    }
    [self showBgViewAnimation];
    self.isShowing = YES;
}


- (void)showXFLoadingInView:(UIView *)view{
    [self layoutSubviewsCenterInView:view];
    [self.wordPathView drawWordAnimationWithText:@"XF"];
    [self showBgViewAnimation];
}

//默认居中布局
- (void)layoutSubviewsCenterInView:(UIView *)view{
    [view addSubview:self];
    CGFloat height = view.frame.size.height != XFLoadingScreenHeight ? view.frame.size.height : self.keyboardOffsetY;
    self.frame = CGRectMake(view.bounds.origin.x, view.bounds.origin.y, view.frame.size.width, height);
    self.containerView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

//背景渐现动画
- (void)showBgViewAnimation{
    [UIView animateWithDuration:0.25 animations:^{
        [self.bgView setBackgroundColor:XF_RGB_COLOR(0, 0, 0, self.bgAlpha)];
    }];
}

+ (void)hide{
    
    if (![self shareInstance].isShowing) return;
    [self shareInstance].isShowing = NO;
    
    if ([self shareInstance].animateStyle == XFLoadingGraphAnimateStyleCircle) {
        [[self shareInstance].circleView hideCircle];
        [[self shareInstance].circleView removeFromSuperview];
        [self shareInstance].circleView = nil;
    }
    else if ([self shareInstance].animateStyle == XFLoadingGraphAnimateStyleIndicator){
        [[self shareInstance].indicatorView removeFromSuperview];
        [self shareInstance].indicatorView = nil;
    }
    else if ([self shareInstance].animateStyle == XFLoadingGraphAnimateStyleWordPath){
        [[self shareInstance].wordPathView hideXFLoading];
        [[self shareInstance].wordPathView removeFromSuperview];
        [self shareInstance].wordPathView = nil;
    }
    
    [[self shareInstance].bgView setBackgroundColor:XF_RGB_COLOR(0, 0, 0, 0)];
    [[self shareInstance] removeFromSuperview];
    
}

#pragma mark - keyboard notification
- (void)keyboardDidChange:(NSNotification*)notification
{
    NSDictionary * userInfo = [notification userInfo];
    NSValue * aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardOffsetY = [aValue CGRectValue].origin.y;
}

@end
