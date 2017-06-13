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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "MDCFeatureHighlightDismissGestureRecognizer.h"
#import "MDCFeatureHighlightView+Private.h"

#import "MaterialMath.h"

static inline CGFloat CGPointDistanceToPoint(CGPoint a, CGPoint b) {
  return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}

static inline NSString *NSStringFromUIGestureRecognizerState(UIGestureRecognizerState state) {
  switch (state) {
    case UIGestureRecognizerStatePossible:
      return @"UIGestureRecognizerStatePossible";
    case UIGestureRecognizerStateEnded:
      return @"UIGestureRecognizerState(Ended|Recognized)";
    case UIGestureRecognizerStateBegan:
      return @"UIGestureRecognizerStateBegan";
    case UIGestureRecognizerStateFailed:
      return @"UIGestureRecognizerStateFailed";
    case UIGestureRecognizerStateChanged:
      return @"UIGestureRecognizerStateChanged";
    case UIGestureRecognizerStateCancelled:
      return @"UIGestureRecognizerStateCancelled";
  }
}

@interface MDCFeatureHighlightDismissGestureRecognizer ()

@property(nullable, nonatomic, readonly) MDCFeatureHighlightView *view;

@end

@implementation MDCFeatureHighlightDismissGestureRecognizer {
  CGFloat _startProgress;

  CGFloat _previousProgress;
  NSTimeInterval _eventTimeStamp;
  NSTimeInterval _previousEventTimeStamp;
}

@dynamic view;

- (void)setState:(UIGestureRecognizerState)state {
  super.state = state;
  NSLog(@"%@", NSStringFromUIGestureRecognizerState(self.state));
}

- (void)reset {
  [super reset];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  assert([self.view isKindOfClass:[MDCFeatureHighlightView class]]);
  [super touchesBegan:touches withEvent:event];

  _startProgress = [self dismissPercentOfTouches:touches];
  _progress = _previousProgress = 1;
  _eventTimeStamp = _previousEventTimeStamp = event.timestamp;
  _velocity = 0;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];

  // first touch that can be considered a pan
  if (self.state == UIGestureRecognizerStatePossible && !MDCCGFloatEqual(_progress, 1.0)) {
    self.state = UIGestureRecognizerStateBegan;
  }

  _previousEventTimeStamp = _eventTimeStamp;
  _eventTimeStamp = event.timestamp;

  _velocity = (_progress - _previousProgress) / (_eventTimeStamp - _previousEventTimeStamp);

  [self updateState:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
    self.state = UIGestureRecognizerStateEnded;
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  self.state = UIGestureRecognizerStateCancelled;
}

- (void)updateState:(NSSet<UITouch *> *)touches {
  _previousProgress = _progress;
  CGFloat newProgress = [self dismissPercentOfTouches:touches];
  if (newProgress < _startProgress) {
    _startProgress = newProgress;
  }
  _progress = 1.0 - [self dismissPercentOfTouches:touches] + _startProgress;
  _progress = MIN(1.0, MAX(0.0, _progress));
}

- (CGFloat)progressForTouchPosition:(CGPoint)touchPos {
  CGPoint c1 = self.view.highlightCenter;
  CGPoint c2 = self.view.highlightPoint;
  CGFloat r1 = self.view.highlightRadius;
  CGFloat r2 = 0;
  CGPoint p = touchPos;

  // Center and radius as paramaterized functions of t
  // c(t) = c1 + (c2 - c1)t
  // r(t) = r1 + (r2 - r1)t

  // Radius in terms of distance from the center to the touch point
  // r(t) = ||c(t) - p)||
  // r(t)^2 = || c(t) - p ||^2
  // r(t)^2 = (c(t).x - p.x)^2 + (c(t).y - p.y)^2
  // (r1 + (r2 - r1)t)^2 = (c1.x + (c2.x - c1.x)t - p.x)^2 + (c1.y + (c2.y - c1.y)t - p.y)^2

  // r1^2 + 2r1(r2 - r1)t + (r2 - r1)^2*t^2
  //   = c1.x^2 + 2c1.x(c2.x - c1.x)t - 2c1.x*p.x - 2(c2.x - c1.x)t*p.x + (c2.x - c1.x)^2t^2 + p.x^2
  //   + c1.y^2 + 2c1.y(c2.y - c1.y)t - 2c1.y*p.y - 2(c2.y - c1.y)t*p.y + (c2.y - c1.y)^2t^2 + p.y^2

  // Moving everything to left side so that ... = 0
  // r1^2 + 2r1(r2 - r1)t + (r2 - r1)^2*t^2
  // - c1.x^2 - 2c1.x(c2.x - c1.x)t + 2c1.x*p.x + 2(c2.x - c1.x)t*p.x - (c2.x - c1.x)^2t^2 - p.x^2
  // - c1.y^2 - 2c1.y(c2.y - c1.y)t + 2c1.y*p.y + 2(c2.y - c1.y)t*p.y - (c2.y - c1.y)^2t^2 - p.y^2
  //  = 0

  // Now compute in the form at^2 + bt + c = 0
  // a = (r2 - r1)^2 - (c2.x - c1.x)^2 - (c2.y - c1.y)^2
  // b = 2r1(r2 - r1) - 2c1.x(c2.x - c1.x) + 2(c2.x - c1.x)p.x - 2c1.y(c2.y - c1.y) + 2(c2.y - c1.y)p.y
  // c = r1^2 - c1.x^2 + 2c1.x*p.x - p.x^2 - c1.y^2 + 2c1.y*p.y - p.y^2
  CGFloat a = pow(r2 - r1, 2) - pow(c2.x - c1.x, 2) - pow(c2.y - c1.y, 2);
  CGFloat b = 2*r1*(r2 - r1) - 2*c1.x*(c2.x - c1.x) + 2*(c2.x - c1.x)*p.x - 2*c1.y*(c2.y - c1.y) + 2*(c2.y - c1.y)*p.y;
  CGFloat c = pow(r1, 2) - pow(c1.x, 2) + 2*c1.x*p.x - pow(p.x, 2) - pow(c1.y, 2) + 2*c1.y*p.y - pow(p.y, 2);

  CGFloat t = (-b - sqrt(b*b - 4*a*c))/(2*a);

  return MIN(1, MAX(0, t));
}

- (CGFloat)dismissPercentOfTouches:(NSSet<UITouch *> *)touches {
  if (touches.count == 0) {
    return 0.0;
  }

  // the circle of the outer highlight
  CGFloat radius = self.view.highlightRadius;
  CGPoint center = self.view.highlightCenter;

  // the highlighted point
  CGPoint point = self.view.highlightPoint;

  CGFloat pointCenterDist = CGPointDistanceToPoint(point, center);

  CGFloat dismissSum = 0;
  for (UITouch *touch in touches) {
    CGPoint touchPos = [touch locationInView:self.view];
    dismissSum += [self progressForTouchPosition:touchPos];
  }

  CGFloat progress = dismissSum / touches.count;
  return MIN(1, MAX(0, progress));
}

@end

#pragma clang diagnostic pop
