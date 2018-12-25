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

static NSString *const MDCInkLayerOpacityString = @"opacity";
static NSString *const MDCInkLayerPositionString = @"position";
static NSString *const MDCInkLayerScaleString = @"transform.scale";

@implementation MDCRippleLayer

//- (instancetype)initWithLayer:(id)layer {
//  self = [super initWithLayer:layer];
//  if (self) {
//    _endAnimationDelay = 0;
//    _finalRadius = 0;
//    _initialRadius = 0;
//    _startAnimationActive = NO;
////    if ([layer isKindOfClass:[MDCRippleLayer class]]) {
////      MDCRippleLayer *rippleLayer = (MDCInkLayer *)layer;
////      _endAnimationDelay = rippleLayer.endAnimationDelay;
////      _finalRadius = rippleLayer.finalRadius;
////      _initialRadius = rippleLayer.initialRadius;
////      _maxRippleRadius = rippleLayer.maxRippleRadius;
////      _inkColor = rippleLayer.inkColor;
////      _startAnimationActive = NO;
////    }
//  }
//  return self;
//}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//  self = [super initWithCoder:aDecoder];
//
//  if (self) {
//    _inkColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.08];
//  }
//
//  return self;
//}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [self setRadiiWithRect:self.bounds];
}

- (void)setRadiiWithRect:(CGRect)rect {
  self.finalRadius = (CGFloat)(MDCHypot(CGRectGetMidX(rect), CGRectGetMidY(rect)) + 10);
}

- (void)startAnimationAtPoint:(CGPoint)point {
  [self startRippleAtPoint:point animated:YES];
}

- (void)startRippleAtPoint:(CGPoint)point animated:(BOOL)animated {
  CGFloat radius = self.finalRadius;
  if (self.maxRippleRadius > 0) {
    radius = self.maxRippleRadius;
  }
  CGRect ovalRect = CGRectMake(CGRectGetMidX(self.bounds) - radius,
                               CGRectGetMidY(self.bounds) - radius,
                               radius * 2,
                               radius * 2);
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  self.path = circlePath.CGPath;
  self.fillColor = self.rippleColors[@(MDCRippleStateNormal)].CGColor;
  if (!animated) {
    self.opacity = 1;
    self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
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
    scaleAnim.keyPath = MDCInkLayerScaleString;
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
    positionAnim.keyPath = MDCInkLayerPositionString;
    positionAnim.path = centerPath.CGPath;
    positionAnim.keyTimes = @[ @0, @1 ];
    positionAnim.values = @[ @0, @1 ];
//    positionAnim.duration = MDCInkLayerStartScalePositionDuration;
//    positionAnim.beginTime = MDCInkLayerCommonDuration;
    positionAnim.timingFunction = materialTimingFunction;
    positionAnim.fillMode = kCAFillModeForwards;
    positionAnim.removedOnCompletion = NO;

    CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
    fadeInAnim.keyPath = MDCInkLayerOpacityString;
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
    }];
    [self addAnimation:animGroup forKey:nil];
    [CATransaction commit];
  }
  if ([self.rippleLayerDelegate respondsToSelector:@selector(rippleLayerAnimationDidStart:)]) {
    [self.rippleLayerDelegate rippleLayerAnimationDidStart:self];
  }
}

- (void)endAnimation  {
  [self endRippleAnimated:YES];
}

- (void)endRippleAnimated:(BOOL)animated {
  CGFloat delay = 0;
  if (self.startAnimationActive) {
    delay = (CGFloat)0.225;
//    self.endAnimationDelay = MDCInkLayerStartFadeHalfBeginTimeFadeOutDuration;
  }

  CGFloat opacity = 0;
//  BOOL viewContainsPoint = CGRectContainsPoint(self.bounds, point) ? YES : NO;
//  if (!viewContainsPoint) {
//    opacity = 0;
//  }

  if (!animated) {
    self.opacity = 0;
    if ([self.rippleLayerDelegate respondsToSelector:@selector(rippleLayerAnimationDidEnd:)]) {
      [self.rippleLayerDelegate rippleLayerAnimationDidEnd:self];
    }
    [self removeFromSuperlayer];
  } else {
    [CATransaction begin];
    CABasicAnimation *fadeOutAnim = [[CABasicAnimation alloc] init];
    fadeOutAnim.keyPath = MDCInkLayerOpacityString;
    fadeOutAnim.fromValue = @(opacity);
    fadeOutAnim.toValue = @0;
    fadeOutAnim.duration = (CGFloat)0.15;
    fadeOutAnim.beginTime = [self convertTime:(CACurrentMediaTime() + delay)
                                    fromLayer:nil];
    fadeOutAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fadeOutAnim.fillMode = kCAFillModeForwards;
    fadeOutAnim.removedOnCompletion = NO;
    [CATransaction setCompletionBlock:^{
      if ([self.rippleLayerDelegate respondsToSelector:@selector(rippleLayerAnimationDidEnd:)]) {
        [self.rippleLayerDelegate rippleLayerAnimationDidEnd:self];
      }
      [self removeFromSuperlayer];
    }];
    [self addAnimation:fadeOutAnim forKey:nil];
    [CATransaction commit];
  }
}

@end
