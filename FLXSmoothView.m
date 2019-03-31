//
//  FLXSmoothView.m
//  SmoothCorners
//
//  Created by Felix Lapalme on 2019-03-24.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

#import "FLXSmoothView.h"

@interface FLXSmoothView()

@property (nonatomic, assign) CGFloat flx_lastSetRadius;
@property (nonatomic, strong) CAShapeLayer *flx_smoothMask;

@end

@implementation FLXSmoothView

-(void)setFlx_smoothCorners:(BOOL)flx_smoothCorners {
    _flx_smoothCorners = flx_smoothCorners;
    
    [self flx_updateMaskIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.flx_smoothCorners) {
        [self flx_updateMaskIfNeeded];
    }
}

- (void)flx_updateMaskIfNeeded {
    if (self.flx_smoothCorners) {
        if (self.flx_smoothMask) {
            // If it already exists we only update it if it changed
            if (!CGRectEqualToRect(CGPathGetPathBoundingBox(self.flx_smoothMask.path), self.bounds)
                || self.flx_lastSetRadius != self.layer.cornerRadius) {
                [self flx_updateMaskShape];
            }
        } else {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                                cornerRadius:self.layer.cornerRadius];
            CAShapeLayer *mask = [CAShapeLayer layer];
            mask.path = maskPath.CGPath;
            self.layer.mask = mask;
            self.flx_smoothMask = mask;
            self.flx_lastSetRadius = self.layer.cornerRadius;

            [self.layer addObserver:self
                         forKeyPath:NSStringFromSelector(@selector(cornerRadius))
                            options:0
                            context:nil];
        }
    }
    else if (self.flx_smoothMask) {
        self.layer.mask = nil;
        self.flx_smoothMask = nil;

        @try {
            [self.layer removeObserver:self forKeyPath:NSStringFromSelector(@selector(cornerRadius))];
        }
        @catch (NSException * __unused exception) {}
    }
}

- (void)flx_updateMaskShape {
    self.flx_smoothMask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:self.layer.cornerRadius].CGPath;
    self.flx_lastSetRadius = self.layer.cornerRadius;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(cornerRadius))]) {
        [self flx_updateMaskIfNeeded];
    }
}

@end
