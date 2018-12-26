#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIView+XFCircleLoading.h"
#import "UIView+XFLoadingAnimate.h"
#import "XFLoadingButton.h"
#import "XFLoadingHeader.h"
#import "XFLoadingHUD.h"
#import "XFRefreshHeader.h"

FOUNDATION_EXPORT double XFLoadingHUDVersionNumber;
FOUNDATION_EXPORT const unsigned char XFLoadingHUDVersionString[];

