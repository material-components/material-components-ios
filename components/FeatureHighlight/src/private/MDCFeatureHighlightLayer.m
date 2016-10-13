/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFeatureHighlightLayer.h"

@implementation MDCFeatureHighlightLayer {
  CGFloat _radius;
}

- (void)setCenter:(CGPoint)center {
  _center = center;

  CGRect circleRect = CGRectMake(center.x - _radius, center.y - _radius, _radius * 2, _radius * 2);
  self.path = CGPathCreateWithEllipseInRect(circleRect, NULL);
}

- (void)setCenter:(CGPoint)center radius:(CGFloat)radius animated:(BOOL)animated {
  _center = center;
  _radius = radius;

  CGRect circleRect = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
  if (animated) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = [CATransaction animationDuration];
    animation.timingFunction = [CATransaction animationTimingFunction];
    if (self.path) {
      animation.fromValue = (__bridge id)self.path;
    } else {
      animation.fromValue =
          (__bridge id)CGPathCreateWithEllipseInRect(CGRectMake(center.x, center.y, 0, 0), NULL);
    }
    self.path = CGPathCreateWithEllipseInRect(circleRect, NULL);
    [self addAnimation:animation forKey:@"path"];
  } else {
    self.path = CGPathCreateWithEllipseInRect(circleRect, NULL);
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

- (void)animateRadiusOverKeyframes:(NSArray *)radii
                          keyTimes:(NSArray *)keyTimes
                            center:(CGPoint)center {
  NSMutableArray *values = [NSMutableArray arrayWithCapacity:radii.count];
  for (NSNumber *radius in radii) {
    CGFloat r = radius.floatValue;
    CGRect circleRect = CGRectMake(center.x - r, center.y - r, r * 2, r * 2);
    [values addObject:(__bridge id)CGPathCreateWithEllipseInRect(circleRect, NULL)];
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
