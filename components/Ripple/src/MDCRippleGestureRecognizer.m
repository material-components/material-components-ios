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

#import "MDCRippleGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

static const CGFloat kRippleGestureDefaultDragCancelDistance = 20;

@implementation MDCRippleGestureRecognizer {
  CGPoint _touchStartLocation;
  CGPoint _touchCurrentLocation;
  BOOL _cancelOnDragOut;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action {
  self = [super initWithTarget:target action:action];
  if (self) {
    _cancelOnDragOut = YES;
    _dragCancelDistance = kRippleGestureDefaultDragCancelDistance;
//    _targetBounds = CGRectNull;
    self.cancelsTouchesInView = NO;
    self.delaysTouchesEnded = NO;
  }
  return self;
}

//- (CGPoint)touchStartLocationInView:(UIView *)view {
//  return [view convertPoint:_touchStartLocation fromView:nil];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  if (touches.count == 1) {
    self.state = UIGestureRecognizerStateBegan;
    _touchStartLocation = [touches.anyObject locationInView:self.view];
    _touchCurrentLocation = _touchStartLocation;
  } else {
    self.state = UIGestureRecognizerStateFailed;
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  if (self.state == UIGestureRecognizerStateFailed) {
    return;
  }

  _touchCurrentLocation = [[touches anyObject] locationInView:self.view];

  // Cancel the gesture if it is too far away.
  if (_cancelOnDragOut && ![self isTouchWithinTargetBounds]) {
    self.state = UIGestureRecognizerStateCancelled;
  } else {
    self.state = UIGestureRecognizerStateChanged;
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  self.state = UIGestureRecognizerStateCancelled;
}

- (BOOL)isTouchWithinTargetBounds {
  CGRect boundsWithInset =
      CGRectInset(self.view.bounds, -self.dragCancelDistance, -self.dragCancelDistance);
  return CGRectContainsPoint(boundsWithInset, _touchCurrentLocation);
}

//#pragma mark - Private methods
//
//- (CGRect)effectiveTargetBounds {
//  return CGRectEqualToRect(_targetBounds, CGRectNull) ? self.view.bounds : _targetBounds;
//}

@end
