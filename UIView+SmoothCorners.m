//
//  UIView+SmoothCorners.m
//  SmoothCorners
//
//  Created by Felix Lapalme on 2019-03-16.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

#import "UIView+SmoothCorners.h"
#import <objc/runtime.h>

@implementation UIView (SmoothCorners)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL defaultSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(flx_layoutSubviews);

        Method defaultMethod = class_getInstanceMethod(UIView.class, defaultSelector);
        Method swizzledMethod = class_getInstanceMethod(UIView.class, swizzledSelector);

        BOOL methodExists = !class_addMethod(UIView.class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

        if (methodExists) {
            method_exchangeImplementations(defaultMethod, swizzledMethod);
        }
        else {
            class_replaceMethod(UIView.class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
        }
    });
}

- (void)flx_layoutSubviews {
    [self flx_layoutSubviews];

    if (self.flx_continuousCorners
        && [self.layer.mask isKindOfClass:CAShapeLayer.class]) {
        CAShapeLayer *mask = ((CAShapeLayer *)self.layer.mask);

        if (!CGRectEqualToRect(mask.bounds, self.bounds)) {
            mask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   cornerRadius:self.layer.cornerRadius].CGPath;
        }
    }
}

- (void)flx_updateMask {
    if (self.flx_continuousCorners) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                            cornerRadius:self.layer.cornerRadius];
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path = maskPath.CGPath;
        self.layer.mask = mask;
    }
    else {
        self.layer.mask = nil;
    }
}

#pragma mark - Setters

- (void)setFlx_continuousCorners:(BOOL)flx_continuousCorners {
    BOOL changed = (self.flx_continuousCorners != flx_continuousCorners);
    objc_setAssociatedObject(self, @selector(flx_continuousCorners), @(flx_continuousCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (changed) {
        [self flx_updateMask];
    }
}

#pragma mark - Getters

- (BOOL)flx_continuousCorners {
    NSNumber *enableContinuousCorners = objc_getAssociatedObject(self, @selector(flx_continuousCorners));
    return enableContinuousCorners.boolValue;
}

@end
