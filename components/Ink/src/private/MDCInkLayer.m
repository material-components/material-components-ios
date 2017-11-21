/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCInkLayer.h"
#import "MaterialMath.h"

static const CGFloat kMDCInkLayerCommonDuration = 0.083f;
static const CGFloat kMDCInkLayerStartScalePositionDuration = 0.333f;
static const CGFloat kMDCInkLayerStartFadeHalfDuration = 0.167f;
static const CGFloat kMDCInkLayerStartFadeHalfBeginTimeFadeOutDuration = 0.25f;
static const CGFloat kMDCInkLayerStartTotalDuration = 0.5f;

static NSString *const kMDCInkLayerOpacityString = @"opacity";
static NSString *const kMDCInkLayerPositionString = @"position";
static NSString *const kMDCInkLayerScaleString = @"transform.scale";

@implementation MDCInkLayer

- (instancetype)initWithLayer:(id)layer {
  self = [super initWithLayer:layer];
  if (self) {
    _endAnimationDelay = 0;
    _finalRadius = 0;
    _initialRadius = 0;
    _inkColor = [UIColor colorWithWhite:0 alpha:0.08f];
    _startAnimationActive = NO;
    if ([layer isKindOfClass:[MDCInkLayer class]]) {
      MDCInkLayer *inkLayer = (MDCInkLayer *)layer;
      _endAnimationDelay = inkLayer.endAnimationDelay;
      _finalRadius = inkLayer.finalRadius;
      _initialRadius = inkLayer.initialRadius;
      _inkColor = inkLayer.inkColor;
      _startAnimationActive = NO;
    }
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.initialRadius = (CGFloat)(MDCHypot(CGRectGetHeight(frame), CGRectGetWidth(frame)) / 2 * 0.6);
  self.finalRadius = (CGFloat)(MDCHypot(CGRectGetHeight(frame), CGRectGetWidth(frame)) / 2 + 10.f);
}

- (void)startAnimationAtPoint:(CGPoint)point {
  CGFloat radius = self.finalRadius;
  CGRect ovalRect = CGRectMake(CGRectGetWidth(self.bounds) / 2 - radius,
                               CGRectGetHeight(self.bounds) / 2 - radius,
                               radius * 2,
                               radius * 2);
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  self.path = circlePath.CGPath;
  self.fillColor = self.inkColor.CGColor;
  self.opacity = 0;
  self.position = point;
  self.startAnimationActive = YES;

  CABasicAnimation *scaleAnim = [[CABasicAnimation alloc] init];
  scaleAnim.keyPath = kMDCInkLayerScaleString;
  scaleAnim.fromValue = @0.6f;
  scaleAnim.toValue = @1.0f;
  scaleAnim.duration = kMDCInkLayerStartScalePositionDuration;
  scaleAnim.beginTime = kMDCInkLayerCommonDuration;
  scaleAnim.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0:0.2f:1.f];
  scaleAnim.fillMode = kCAFillModeForwards;
  scaleAnim.removedOnCompletion = NO;

  UIBezierPath *centerPath = [UIBezierPath bezierPath];
  CGPoint startPoint = point;
  CGPoint endPoint = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
  [centerPath moveToPoint:startPoint];
  [centerPath addLineToPoint:endPoint];
  [centerPath closePath];

  CAKeyframeAnimation *positionAnim = [[CAKeyframeAnimation alloc] init];
  positionAnim.keyPath = kMDCInkLayerPositionString;
  positionAnim.path = centerPath.CGPath;
  positionAnim.keyTimes = @[ @0, @1.0f ];
  positionAnim.values = @[ @0, @1.0f ];
  positionAnim.duration = kMDCInkLayerStartScalePositionDuration;
  positionAnim.beginTime = kMDCInkLayerCommonDuration;
  positionAnim.timingFunction =
  [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0:0.2f:1.f];
  positionAnim.fillMode = kCAFillModeForwards;
  positionAnim.removedOnCompletion = NO;

  CABasicAnimation *fadeInAnim = [[CABasicAnimation alloc] init];
  fadeInAnim.keyPath = kMDCInkLayerOpacityString;
  fadeInAnim.fromValue = @0;
  fadeInAnim.toValue = @1.0f;
  fadeInAnim.duration = kMDCInkLayerCommonDuration;
  fadeInAnim.beginTime = kMDCInkLayerCommonDuration;
  fadeInAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeInAnim.fillMode = kCAFillModeForwards;
  fadeInAnim.removedOnCompletion = NO;

  CABasicAnimation *fadeHalfAnim = [[CABasicAnimation alloc] init];
  fadeHalfAnim.keyPath = kMDCInkLayerOpacityString;
  fadeHalfAnim.fromValue = @1.0f;
  fadeHalfAnim.toValue = @0.5f;
  fadeHalfAnim.duration = kMDCInkLayerStartFadeHalfDuration;
  fadeHalfAnim.beginTime = kMDCInkLayerStartFadeHalfBeginTimeFadeOutDuration;
  fadeHalfAnim.timingFunction =
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeHalfAnim.fillMode = kCAFillModeForwards;
  fadeHalfAnim.removedOnCompletion = NO;

  [CATransaction begin];
  CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
  animGroup.animations = @[ scaleAnim, positionAnim, fadeInAnim, fadeHalfAnim ];
  animGroup.duration = kMDCInkLayerStartTotalDuration;
  animGroup.fillMode = kCAFillModeForwards;
  animGroup.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    self.startAnimationActive = NO;
  }];
  [self addAnimation:animGroup forKey:nil];
  [CATransaction commit];
  if ([self.animationDelegate respondsToSelector:@selector(inkLayerAnimationDidStart:)]) {
    [self.animationDelegate inkLayerAnimationDidStart:self];
  }
}

- (void)changeAnimationAtPoint:(CGPoint)point {
  CGFloat animationDelay = 0;
  if (self.startAnimationActive) {
    animationDelay = kMDCInkLayerStartFadeHalfBeginTimeFadeOutDuration +
        kMDCInkLayerStartFadeHalfDuration;
  }

  BOOL viewContainsPoint = CGRectContainsPoint(self.bounds, point) ? YES : NO;
  CGFloat currOpacity = self.presentationLayer.opacity;
  CGFloat updatedOpacity = 0;
  if (viewContainsPoint) {
    updatedOpacity = 0.5f;
  }

  CABasicAnimation *changeAnim = [[CABasicAnimation alloc] init];
  changeAnim.keyPath = kMDCInkLayerOpacityString;
  changeAnim.fromValue = @(currOpacity);
  changeAnim.toValue = @(updatedOpacity);
  changeAnim.duration = kMDCInkLayerCommonDuration;
  changeAnim.beginTime = CACurrentMediaTime() + animationDelay;
  changeAnim.timingFunction =
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  changeAnim.fillMode = kCAFillModeForwards;
  changeAnim.removedOnCompletion = NO;
  [self addAnimation:changeAnim forKey:nil];
}

- (void)endAnimationAtPoint:(CGPoint)point {
  if (self.startAnimationActive) {
    self.endAnimationDelay = kMDCInkLayerStartFadeHalfBeginTimeFadeOutDuration +
        kMDCInkLayerStartFadeHalfDuration;
  }
  CGFloat currOpacity = self.presentationLayer.opacity;
  if (currOpacity < 0.5f) {
    currOpacity = 0.5f;
  } else if (currOpacity == 0.0) {
    currOpacity = 1.0f;
  }

  BOOL viewContainsPoint = CGRectContainsPoint(self.bounds, point) ? YES : NO;
  if (!viewContainsPoint) {
    currOpacity = 0;
  }

  [CATransaction begin];
  CABasicAnimation *fadeOutAnim = [[CABasicAnimation alloc] init];
  fadeOutAnim.keyPath = kMDCInkLayerOpacityString;
  fadeOutAnim.fromValue = @(currOpacity);
  fadeOutAnim.toValue = @0;
  fadeOutAnim.duration = kMDCInkLayerStartFadeHalfBeginTimeFadeOutDuration;
  fadeOutAnim.beginTime = CACurrentMediaTime() + self.endAnimationDelay;
  fadeOutAnim.timingFunction =
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeOutAnim.fillMode = kCAFillModeForwards;
  fadeOutAnim.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    if ([self.animationDelegate respondsToSelector:@selector(inkLayerAnimationDidEnd:)]) {
      [self.animationDelegate inkLayerAnimationDidEnd:self];
    }
    [self removeFromSuperlayer];
  }];
  [self addAnimation:fadeOutAnim forKey:nil];
  [CATransaction commit];
}

@end
