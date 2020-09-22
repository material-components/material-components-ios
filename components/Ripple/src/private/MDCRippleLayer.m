// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCRippleLayer.h"

#import "MaterialAnimationTiming.h"
#import "MDCRippleLayerDelegate.h"

static const CGFloat kExpandRippleBeyondSurface = 10;
static const CGFloat kRippleStartingScale = (CGFloat)0.6;
static const CGFloat kRippleTouchDownDuration = (CGFloat)0.225;
static const CGFloat kRippleTouchUpDuration = (CGFloat)0.15;
static const CGFloat kRippleFadeInDuration = (CGFloat)0.075;
static const CGFloat kRippleFadeOutDuration = (CGFloat)0.075;
static const CGFloat kRippleFadeOutDelay = (CGFloat)0.15;

static NSString *const kRippleLayerOpacityString = @"opacity";
static NSString *const kRippleLayerPositionString = @"position";
static NSString *const kRippleLayerScaleString = @"transform.scale";

static CGFloat GetInitialRippleRadius(CGRect rect) {
  return MAX(CGRectGetWidth(rect), CGRectGetHeight(rect)) * kRippleStartingScale / 2.f;
}

static CGFloat GetFinalRippleRadius(CGRect rect) {
  return (CGFloat)(hypot(CGRectGetMidX(rect), CGRectGetMidY(rect)) + kExpandRippleBeyondSurface);
}

@implementation MDCRippleLayer

- (void)setNeedsLayout {
  [super setNeedsLayout];

  [self calculateRadiusAndSetPath];
  self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)calculateRadiusAndSetPath {
  [self setPathFromRadii:[self calculateRadius]];
}

- (void)setPathFromRadii:(CGFloat)radius {
  CGRect ovalRect = CGRectMake(CGRectGetMidX(self.bounds) - radius,
                               CGRectGetMidY(self.bounds) - radius, radius * 2, radius * 2);
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  self.path = circlePath.CGPath;
}

- (CGFloat)calculateRadius {
  return self.maximumRadius > 0 ? self.maximumRadius : GetFinalRippleRadius(self.bounds);
}

- (void)startRippleAtPoint:(CGPoint)point
                  animated:(BOOL)animated
                completion:(MDCRippleCompletionBlock)completion {
  [self.rippleLayerDelegate rippleLayerTouchDownAnimationDidBegin:self];
  CGFloat finalRadius = [self calculateRadius];
  [self setPathFromRadii:finalRadius];
  self.opacity = 1;
  self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  if (!animated) {
    if (completion) {
      completion();
    }
    [self.rippleLayerDelegate rippleLayerTouchDownAnimationDidEnd:self];
  } else {
    _startAnimationActive = YES;

    CGFloat startingScale = GetInitialRippleRadius(self.bounds) / finalRadius;
    CABasicAnimation *scaleAnim = [[CABasicAnimation alloc] init];
    scaleAnim.keyPath = kRippleLayerScaleString;
    scaleAnim.fromValue = @(startingScale);
    scaleAnim.toValue = @1;
    scaleAnim.timingFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionStandard];

    UIBezierPath *centerPath = [UIBezierPath bezierPath];
    CGPoint startPoint = point;
    CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [centerPath moveToPoint:startPoint];
    [centerPath addLineToPoint:endPoint];
    [centerPath closePath];

    CAKeyframeAnimation *positionAnim = [[CAKeyframeAnimation alloc] init];
    positionAnim.keyPath = kRippleLayerPositionString;
    positionAnim.path = centerPath.CGPath;
    positionAnim.keyTimes = @[ @0, @1 ];
    positionAnim.values = @[ @0, @1 ];
    positionAnim.timingFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionStandard];

    CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
    fadeInAnim.keyPath = kRippleLayerOpacityString;
    fadeInAnim.fromValue = @0;
    fadeInAnim.toValue = @1;
    fadeInAnim.duration = kRippleFadeInDuration;
    fadeInAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    [CATransaction begin];
    CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
    animGroup.animations = @[ scaleAnim, positionAnim, fadeInAnim ];
    animGroup.duration = kRippleTouchDownDuration;
    [CATransaction setCompletionBlock:^{
      self->_startAnimationActive = NO;
      if (completion) {
        completion();
      }
      [self.rippleLayerDelegate rippleLayerTouchDownAnimationDidEnd:self];
    }];
    [self addAnimation:animGroup forKey:nil];
    _rippleTouchDownStartTime = CACurrentMediaTime();
    [CATransaction commit];
  }
}

- (void)fadeInRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [CATransaction begin];
  CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
  fadeInAnim.keyPath = kRippleLayerOpacityString;
  fadeInAnim.fromValue = @0;
  fadeInAnim.toValue = @1;
  fadeInAnim.duration = animated ? kRippleFadeInDuration : 0;
  fadeInAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeInAnim.fillMode = kCAFillModeForwards;
  fadeInAnim.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    if (completion) {
      completion();
    }
  }];
  [self addAnimation:fadeInAnim forKey:nil];
  [CATransaction commit];
}

- (void)fadeOutRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [CATransaction begin];
  CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
  fadeInAnim.keyPath = kRippleLayerOpacityString;
  fadeInAnim.fromValue = @1;
  fadeInAnim.toValue = @0;
  fadeInAnim.duration = animated ? kRippleFadeOutDuration : 0;
  fadeInAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeInAnim.fillMode = kCAFillModeForwards;
  fadeInAnim.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    if (completion) {
      completion();
    }
  }];
  [self addAnimation:fadeInAnim forKey:nil];
  [CATransaction commit];
}

- (void)endRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  CGFloat delay = 0;
  if (self.startAnimationActive) {
    delay = kRippleFadeOutDelay;
  }
  [self.rippleLayerDelegate rippleLayerTouchUpAnimationDidBegin:self];
  [CATransaction begin];
  CABasicAnimation *fadeOutAnim = [[CABasicAnimation alloc] init];
  fadeOutAnim.keyPath = kRippleLayerOpacityString;
  fadeOutAnim.fromValue = @1;
  fadeOutAnim.toValue = @0;
  fadeOutAnim.duration = animated ? kRippleTouchUpDuration : 0;
  fadeOutAnim.beginTime = [self convertTime:_rippleTouchDownStartTime + delay fromLayer:nil];
  fadeOutAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeOutAnim.fillMode = kCAFillModeForwards;
  fadeOutAnim.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    if (completion) {
      completion();
    }
    [self.rippleLayerDelegate rippleLayerTouchUpAnimationDidEnd:self];
    [self removeFromSuperlayer];
  }];
  [self addAnimation:fadeOutAnim forKey:nil];
  [CATransaction commit];
}

@end
