// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFeatureHighlightLayer.h"

#import <UIKit/UIKit.h>

@implementation MDCFeatureHighlightLayer {
  CGFloat _radius;
}

- (void)setPosition:(CGPoint)position animated:(BOOL)animated {
  if (CGPointEqualToPoint(self.position, position)) {
    return;
  }
  if (animated) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = [CATransaction animationDuration];
    animation.timingFunction = [CATransaction animationTimingFunction];
    animation.fromValue = [NSValue valueWithCGPoint:self.position];
    animation.toValue = [NSValue valueWithCGPoint:position];
    [self addAnimation:animation forKey:@"position"];
  }
  self.position = position;
}

- (void)setRadius:(CGFloat)radius animated:(BOOL)animated {
  if (_radius == radius) {
    return;
  }
  _radius = radius;

  CGRect circleRect = CGRectMake(-radius, -radius, radius * 2, radius * 2);
  if (animated) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = [CATransaction animationDuration];
    animation.timingFunction = [CATransaction animationTimingFunction];
    if (self.path) {
      animation.fromValue = (__bridge id)self.path;
    } else {
      animation.fromValue =
          CFBridgingRelease(CGPathCreateWithEllipseInRect(CGRectMake(0, 0, 0, 0), NULL));
    }
    self.path = (__bridge CGPathRef _Nullable)CFBridgingRelease(
        CGPathCreateWithEllipseInRect(circleRect, NULL));
    [self addAnimation:animation forKey:@"path"];
  } else {
    self.path = (__bridge CGPathRef _Nullable)CFBridgingRelease(
        CGPathCreateWithEllipseInRect(circleRect, NULL));
  }
}

- (void)setFillColor:(CGColorRef)fillColor animated:(BOOL)animated {
  if (animated) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    animation.duration = [CATransaction animationDuration];
    animation.timingFunction = [CATransaction animationTimingFunction];
    animation.fromValue = (__bridge id)self.fillColor;
    self.fillColor = fillColor;
    [self addAnimation:animation forKey:@"fillColor"];
  } else {
    self.fillColor = fillColor;
  }
}

- (void)animateRadiusOverKeyframes:(NSArray *)radii keyTimes:(NSArray *)keyTimes {
  NSMutableArray *values = [NSMutableArray arrayWithCapacity:radii.count];
  for (NSNumber *radius in radii) {
    CGFloat r = radius.floatValue;
    CGRect circleRect = CGRectMake(-r, -r, r * 2, r * 2);
    [values addObject:CFBridgingRelease(CGPathCreateWithEllipseInRect(circleRect, NULL))];
  }
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
  animation.duration = [CATransaction animationDuration];
  animation.timingFunction = [CATransaction animationTimingFunction];
  animation.values = values;
  animation.keyTimes = keyTimes;
  [self addAnimation:animation forKey:@"path"];
}

- (void)animateFillColorOverKeyframes:(NSArray *)colors keyTimes:(NSArray *)keyTimes {
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
  animation.duration = [CATransaction animationDuration];
  animation.timingFunction = [CATransaction animationTimingFunction];
  animation.values = colors;
  animation.keyTimes = keyTimes;
  [self addAnimation:animation forKey:@"fillColor"];
}

@end
