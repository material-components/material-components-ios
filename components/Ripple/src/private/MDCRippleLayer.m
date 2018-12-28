// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MaterialMath.h"

//static const CGFloat MDCInkLayerCommonDuration = (CGFloat)0.083;
//static const CGFloat MDCInkLayerEndFadeOutDuration = (CGFloat)0.15;
//static const CGFloat MDCInkLayerStartScalePositionDuration = (CGFloat)0.333;
//static const CGFloat MDCInkLayerStartFadeHalfDuration = (CGFloat)0.167;
//static const CGFloat MDCInkLayerStartFadeHalfBeginTimeFadeOutDuration = (CGFloat)0.25;

//static const CGFloat MDCInkLayerScaleStartMin = (CGFloat)0.2;
//static const CGFloat MDCInkLayerScaleStartMax = (CGFloat)0.6;
//static const CGFloat MDCInkLayerScaleDivisor = 300;

static NSString *const MDCRippleLayerOpacityString = @"opacity";
static NSString *const MDCRippleLayerPositionString = @"position";
static NSString *const MDCRippleLayerScaleString = @"transform.scale";

@implementation MDCRippleLayer {
}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [self setRadiiWithRect:self.bounds];
}

- (void)setRadiiWithRect:(CGRect)rect {
  self.finalRadius = (CGFloat)(MDCHypot(CGRectGetMidX(rect), CGRectGetMidY(rect)) + 10);
}

- (void)startRippleAtPoint:(CGPoint)point
                  animated:(BOOL)animated
                completion:(MDCRippleCompletionBlock)completion {
  CGFloat radius = self.finalRadius;
  if (self.unboundedMaxRippleRadius > 0) {
    radius = self.unboundedMaxRippleRadius;
  }
  CGRect ovalRect = CGRectMake(CGRectGetMidX(self.bounds) - radius,
                               CGRectGetMidY(self.bounds) - radius,
                               radius * 2,
                               radius * 2);
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  self.path = circlePath.CGPath;
  [self.rippleLayerDelegate rippleLayerPressDownAnimationDidBegin:self];
  if (!animated) {
    self.opacity = 1;
    self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [self.rippleLayerDelegate rippleLayerPressDownAnimationDidEnd:self];
  } else {
    self.opacity = 0;
    self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _startAnimationActive = YES;

    CAMediaTimingFunction *materialTimingFunction =
        [[CAMediaTimingFunction alloc] initWithControlPoints:(float)0.4:0:(float)0.2:1];

//    CGFloat scaleStart =
//        MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / MDCInkLayerScaleDivisor;
//    if (scaleStart < MDCInkLayerScaleStartMin) {
//      scaleStart = MDCInkLayerScaleStartMin;
//    } else if (scaleStart > MDCInkLayerScaleStartMax) {
//      scaleStart = MDCInkLayerScaleStartMax;
//    }
    CGFloat scaleStart = (CGFloat)0.6;

    CABasicAnimation *scaleAnim = [[CABasicAnimation alloc] init];
    scaleAnim.keyPath = MDCRippleLayerScaleString;
    scaleAnim.fromValue = @(scaleStart);
    scaleAnim.toValue = @1;
    scaleAnim.duration = (CGFloat)0.225;// MDCInkLayerStartScalePositionDuration;
//    scaleAnim.beginTime = MDCInkLayerCommonDuration;
    scaleAnim.timingFunction = materialTimingFunction;
    scaleAnim.fillMode = kCAFillModeForwards;
    scaleAnim.removedOnCompletion = NO;

    UIBezierPath *centerPath = [UIBezierPath bezierPath];
    CGPoint startPoint = point;
    CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [centerPath moveToPoint:startPoint];
    [centerPath addLineToPoint:endPoint];
    [centerPath closePath];

    CAKeyframeAnimation *positionAnim = [[CAKeyframeAnimation alloc] init];
    positionAnim.keyPath = MDCRippleLayerPositionString;
    positionAnim.path = centerPath.CGPath;
    positionAnim.keyTimes = @[ @0, @1 ];
    positionAnim.values = @[ @0, @1 ];
//    positionAnim.duration = MDCInkLayerStartScalePositionDuration;
//    positionAnim.beginTime = MDCInkLayerCommonDuration;
    positionAnim.timingFunction = materialTimingFunction;
    positionAnim.fillMode = kCAFillModeForwards;
    positionAnim.removedOnCompletion = NO;

    CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
    fadeInAnim.keyPath = MDCRippleLayerOpacityString;
    fadeInAnim.fromValue = @0;
    fadeInAnim.toValue = @1;
    fadeInAnim.duration = (CGFloat)0.075;//MDCInkLayerCommonDuration;
//    fadeInAnim.beginTime = MDCInkLayerCommonDuration;
    fadeInAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fadeInAnim.fillMode = kCAFillModeForwards;
    fadeInAnim.removedOnCompletion = NO;

    [CATransaction begin];
    CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
    animGroup.animations = @[ scaleAnim, positionAnim, fadeInAnim ];
    animGroup.duration = (CGFloat)0.225;//MDCInkLayerStartScalePositionDuration;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.removedOnCompletion = NO;
    [CATransaction setCompletionBlock:^{
      self->_startAnimationActive = NO;
      if (completion) {
        completion();
      }
      [self.rippleLayerDelegate rippleLayerPressDownAnimationDidEnd:self];
    }];
    [self addAnimation:animGroup forKey:nil];
    _beginPressDownRippleTime = CACurrentMediaTime();
    NSLog(@"instance: %@ start time: %f", self, _beginPressDownRippleTime);
    [CATransaction commit];
  }
}

- (void)fadeInRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [CATransaction begin];
  CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
  fadeInAnim.keyPath = MDCRippleLayerOpacityString;
  fadeInAnim.fromValue = @0;
  fadeInAnim.toValue = @1;
  fadeInAnim.duration = animated ? (CGFloat)0.075 : 0;
  fadeInAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
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
  fadeInAnim.keyPath = MDCRippleLayerOpacityString;
  fadeInAnim.fromValue = @1;
  fadeInAnim.toValue = @0;
  fadeInAnim.duration = animated ? (CGFloat)0.075 : 0;
  fadeInAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
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
    delay = (CGFloat)0.225;
//    self.endAnimationDelay = MDCInkLayerStartFadeHalfBeginTimeFadeOutDuration;
  }

//  CGFloat opacity = 0;
//  BOOL viewContainsPoint = CGRectContainsPoint(self.bounds, point) ? YES : NO;
//  if (!viewContainsPoint) {
//    opacity = 0;
//  }
  [self.rippleLayerDelegate rippleLayerPressUpAnimationDidBegin:self];
    [CATransaction begin];
    CABasicAnimation *fadeOutAnim = [[CABasicAnimation alloc] init];
    fadeOutAnim.keyPath = MDCRippleLayerOpacityString;
    fadeOutAnim.fromValue = @1;
    fadeOutAnim.toValue = @0;
    fadeOutAnim.duration = animated ? (CGFloat)0.15 : 0;
  NSLog(@"instance: %@ end time: %f proposed end time: %f", self, CACurrentMediaTime(), _beginPressDownRippleTime + delay);
    fadeOutAnim.beginTime = _beginPressDownRippleTime + delay;
    fadeOutAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fadeOutAnim.fillMode = kCAFillModeForwards;
    fadeOutAnim.removedOnCompletion = NO;
    [CATransaction setCompletionBlock:^{
      if (completion) {
        completion();
      }
      [self.rippleLayerDelegate rippleLayerPressUpAnimationDidEnd:self];
      [self removeFromSuperlayer];
    }];
    [self addAnimation:fadeOutAnim forKey:nil];
    [CATransaction commit];
}

@end
