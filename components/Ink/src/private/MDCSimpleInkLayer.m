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

#import "MDCSimpleInkLayer.h"
#import "MaterialMath.h"

static NSString *const kMDCSimpleInkLayerOpacityString = @"opacity";
static NSString *const kMDCSimpleInkLayerPositionString = @"position";
static NSString *const kMDCSimpleInkLayerScaleString = @"transform.scale";

@implementation MDCSimpleInkLayer

- (instancetype)initWithLayer:(id)layer {
  self = [super initWithLayer:layer];
  if (self) {
    _initialRadius = 0;
    _finalRadius = 0;
    _inkColor = [UIColor colorWithWhite:0 alpha:0.08f];
    _startAnimationActive = NO;
    _endAnimationDelay = 0;
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
  CGRect ovalRect = CGRectMake(CGRectGetWidth(self.frame) / 2 - radius,
                               CGRectGetHeight(self.frame) / 2 - radius,
                               radius * 2,
                               radius * 2);
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  self.path = circlePath.CGPath;
  self.fillColor = self.inkColor.CGColor;
  self.opacity = 0;
  self.position = point;
  [self startAnimation:point];
}

- (void)startAnimation:(CGPoint)point {
  self.startAnimationActive = YES;

  CAKeyframeAnimation *scaleAnim = [[CAKeyframeAnimation alloc] init];
  [scaleAnim setKeyPath:kMDCSimpleInkLayerScaleString];
  scaleAnim.keyTimes = @[ @0, @1.0f ];
  scaleAnim.values = @[ @0.6f, @1.0f ];
  scaleAnim.duration = 0.333f;
  scaleAnim.beginTime = 0.083f;
  scaleAnim.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0:0.2f:1.f];
  scaleAnim.fillMode = kCAFillModeForwards;
  scaleAnim.removedOnCompletion = NO;

  UIBezierPath *centerPath = [UIBezierPath bezierPath];
  CGPoint startPoint = point;
  CGPoint endPoint = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
  [centerPath moveToPoint:startPoint];
  [centerPath addLineToPoint:endPoint];
  [centerPath closePath];

  CAKeyframeAnimation *positionAnim = [[CAKeyframeAnimation alloc] init];
  [positionAnim setKeyPath:kMDCSimpleInkLayerPositionString];
  positionAnim.path = centerPath.CGPath;
  positionAnim.keyTimes = @[ @0, @1.0f ];
  positionAnim.values = @[ @0, @1.0f ];
  positionAnim.duration = 0.333f;
  positionAnim.beginTime = 0.083f;
  positionAnim.timingFunction =
      [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0:0.2f:1.f];
  positionAnim.fillMode = kCAFillModeForwards;
  positionAnim.removedOnCompletion = NO;

  CAKeyframeAnimation *fadeInAnim = [[CAKeyframeAnimation alloc] init];
  [fadeInAnim setKeyPath:kMDCSimpleInkLayerOpacityString];
  fadeInAnim.keyTimes = @[ @0, @1.0f ];
  fadeInAnim.values = @[ @0, @1.0f ];
  fadeInAnim.duration = 0.083f;
  fadeInAnim.beginTime = 0.083f;
  fadeInAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeInAnim.fillMode = kCAFillModeForwards;
  fadeInAnim.removedOnCompletion = NO;

  CAKeyframeAnimation *fadeHalfAnim = [[CAKeyframeAnimation alloc] init];
  [fadeHalfAnim setKeyPath:kMDCSimpleInkLayerOpacityString];
  fadeHalfAnim.keyTimes = @[ @0, @1.0f ];
  fadeHalfAnim.values = @[ @1.0f, @0.5f ];
  fadeHalfAnim.duration = 0.25f;
  fadeHalfAnim.beginTime = 0.167f;
  fadeHalfAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeHalfAnim.fillMode = kCAFillModeForwards;
  fadeHalfAnim.removedOnCompletion = NO;

  [CATransaction begin];
  CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
  animGroup.animations = @[ scaleAnim, positionAnim, fadeInAnim, fadeHalfAnim ];
  animGroup.duration = 0.5f;
  animGroup.fillMode = kCAFillModeForwards;
  animGroup.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    self.startAnimationActive = NO;
  }];
  [self addAnimation:animGroup forKey:nil];
  [CATransaction commit];
}

- (void)endAnimation {
  if (self.startAnimationActive) {
    self.endAnimationDelay = 0.25f;
  }
  CGFloat currOpacity = self.presentationLayer.opacity;
  if (currOpacity < 0.5f) {
    currOpacity = 0.5f;
  } else if (currOpacity == 0.0) {
    currOpacity = 1.0f;
  }

  [CATransaction begin];
  CAKeyframeAnimation *fadeOutAnim = [[CAKeyframeAnimation alloc] init];
  [fadeOutAnim setKeyPath:kMDCSimpleInkLayerOpacityString];
  fadeOutAnim.keyTimes = @[ @0, @1.0f ];
  fadeOutAnim.values = @[ [NSNumber numberWithFloat:(float)currOpacity], @0 ];
  fadeOutAnim.duration = 0.25f;
  fadeOutAnim.beginTime = CACurrentMediaTime() + self.endAnimationDelay;
  fadeOutAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeOutAnim.fillMode = kCAFillModeForwards;
  fadeOutAnim.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    if (self.completionBlock) {
      self.completionBlock();
    }
  }];
  [self addAnimation:fadeOutAnim forKey:nil];
  [CATransaction commit];
}

@end
