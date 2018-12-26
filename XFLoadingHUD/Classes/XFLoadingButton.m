//
//  XFLoadingButton.m
//  test2
//
//  Created by 1 on 2018/12/20.
//  Copyright © 2018 weiyian. All rights reserved.
//

#import "XFLoadingButton.h"
#import <objc/runtime.h>
@implementation XFLoadingButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self lyz_ivar];
        [self lyz_propery];
        
    }
    return self;
    
}



/** 成员变量 */
- (void)lyz_ivar{
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([UIScrollView class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"\n类型为 %s 的 %s ",type, name);
    }
    
    free(ivars);
    
}


/** 属性列表 */
- (void)lyz_propery{
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList([UIScrollView class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //属性名
        const char * name = property_getName(property);
        //属性描述
        const char * propertyAttr = property_getAttributes(property);
        NSLog(@"\n属性描述为 %s 的 %s ", propertyAttr, name);
        
        //属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
        for (unsigned int j = 0; j < attrCount; j ++) {
            objc_property_attribute_t attr = attrs[j];
            const char * name = attr.name;
            const char * value = attr.value;
            NSLog(@"\n属性的描述：%s 值：%s", name, value);
        }
        free(attrs);
        NSLog(@"\n");
    }
    free(properties);
}


//- (void)addControlStateObserver{
//    
//    [self addObserver:self forKeyPath:@"_lastDrawingControlState" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    
//    if ([keyPath isEqualToString:@"_lastDrawingControlState"]) {
//        NSLog(@"change = %@",change);
//    }
//    
//}
//
//- (void)dealloc{
//    
//    [self removeObserver:self forKeyPath:@"_lastDrawingControlState"];
//    
//}

@end
