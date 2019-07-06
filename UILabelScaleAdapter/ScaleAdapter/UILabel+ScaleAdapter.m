//
//  UILabel+ScaleAdapter.m
//  UILabelScaleAdapter
//
//  Created by 田淳 on 2019/7/6.
//  Copyright © 2019 田淳. All rights reserved.
//

#import "UILabel+ScaleAdapter.h"
#import <objc/runtime.h>
//UI设计图宽度
#define DesignWidth 414.0
//缩放比例
#define Scaling ((CGFloat)([UIScreen mainScreen].bounds.size.width / DesignWidth))

@implementation UILabel (ScaleAdapter)

// 利用runtime机制，在load方法中实现让 jx_awakeFromNib 和 awakeFromNib 方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //要特别注意你替换的方法到底是哪个性质的方法（实例方法：Class class = [self class]; 类方法：Class class = object_getClass((id)self);）
        //类方法的写法
        Class class = [self class];
        // 获取系统的selector
        SEL   originalSelector = @selector(awakeFromNib);
        // 自己要交换的selector
        SEL   swizzledSelector = @selector(tc_awakeFromNib);
        // 两个方法的地址
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        //  动态添加方法
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)tc_awakeFromNib {
    [self tc_awakeFromNib];
    self.font = [UIFont fontWithDescriptor:self.font.fontDescriptor size:self.font.pointSize * Scaling];
}
@end
