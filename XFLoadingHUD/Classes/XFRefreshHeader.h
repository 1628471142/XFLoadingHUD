//
//  XFRefreshHeader.h
//  test2
//
//  Created by 1 on 2018/12/24.
//  Copyright © 2018 weiyian. All rights reserved.
//

#import "MJRefreshHeader.h"
#import "XFLoadingHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface XFRefreshHeader : MJRefreshHeader
@property (assign, nonatomic) XFLoadingGraphAnimateStyle animateStyle;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action animateStyle:(XFLoadingGraphAnimateStyle)animateStyle;
@end

NS_ASSUME_NONNULL_END
