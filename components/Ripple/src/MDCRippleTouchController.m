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

#import "MDCRippleTouchController.h"

#import "MDCRippleGestureRecognizer.h"
#import "MDCRippleView.h"

@implementation MDCRippleTouchController {
  BOOL _tapWentOutsideOfBounds;
}

- (instancetype)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    _gestureRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleRippleGesture:)];
    _gestureRecognizer.minimumPressDuration = 0;
    _gestureRecognizer.delegate = self;
    _gestureRecognizer.cancelsTouchesInView = NO;
    _gestureRecognizer.delaysTouchesEnded = NO;

    _view = view;
    [_view addGestureRecognizer:_gestureRecognizer];

    _rippleView = [[MDCRippleView alloc] initWithFrame:view.bounds];
    [_view addSubview:_rippleView];
//    _defaultRippleView.rippleColor = _defaultRippleView.defaultRippleColor;
//    _defaultRippleView.autoresizingMask =
//        UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tapWentOutsideOfBounds = NO;
  }
  return self;
}

- (void)dealloc {
  [_view removeGestureRecognizer:_gestureRecognizer];
  _gestureRecognizer.delegate = nil;
}

//- (void)addRippleView {
//  if (![_delegate respondsToSelector:@selector(rippleTouchController:rippleViewAtTouchLocation:)]) {
//    _addedRippleView = _defaultRippleView;
//
//    if ([_delegate respondsToSelector:@selector(rippleTouchController:insertRippleView:intoView:)]) {
//      [_delegate rippleTouchController:self insertRippleView:_addedRippleView intoView:_view];
//    } else {
//      [_view addSubview:_addedRippleView];
//    }
//  }
//}

- (void)cancelRippleTouchProcessing {
  [self.rippleView cancelAllRipplesAnimated:YES];
}

//- (MDCRippleView *)rippleViewAtTouchLocation:(CGPoint)location {
//  MDCRippleView *rippleView;
//  if ([_delegate respondsToSelector:@selector(rippleTouchController:rippleViewAtTouchLocation:)]) {
//    rippleView = [_delegate rippleTouchController:self rippleViewAtTouchLocation:location];
//  } else {
//    CGPoint locationInRippleCoords = [self.view convertPoint:location toView:_addedRippleView];
//    if ([_addedRippleView pointInside:locationInRippleCoords withEvent:nil]) {
//      rippleView = _addedRippleView;
//    }
//  }
//  return rippleView;
//}

- (void)handleRippleGesture:(MDCRippleGestureRecognizer *)recognizer {
  CGPoint touchLocation = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      _tapWentOutsideOfBounds = NO;
//      if ([_delegate respondsToSelector:@selector(rippleTouchController:rippleViewAtTouchLocation:)]) {
//        _defaultRippleView = [_delegate rippleTouchController:self rippleViewAtTouchLocation:touchLocation];
//        if (!_defaultRippleView) {
//          return [self cancelRippleGestureWithRecognizer:recognizer];
//        }
//        NSAssert([_defaultRippleView isDescendantOfView:_view],
//                 @"Ripple view %@ returned by rippleTouchController:rippleViewAtTouchLocation: must be a "
//                  "subview of base view %@",
//                 _defaultRippleView, _view);
//        recognizer.targetBounds = [_defaultRippleView convertRect:_addedRippleView.bounds toView:_view];
//      }
//
//      _shouldRespondToTouch = YES;
//      dispatch_time_t delayTime =
//          dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * kRippleTouchDelayInterval));
//      dispatch_after(_delaysRippleSpread ? delayTime : 0, dispatch_get_main_queue(), ^(void) {
        [self touchBeganAtPoint:[recognizer locationInView:self.rippleView]
                  touchLocation:touchLocation];
//      });
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      // Due to force touch,
      // @c UIGestureRecognizerStateChanged constantly fires. However, we do not want to cancel the
      // ripple unless the users moves.
//      if (_shouldRespondToTouch && !CGPointEqualToPoint(touchLocation, _previousLocation)) {
//        _shouldRespondToTouch = NO;
//      }
      BOOL pointContainedinBounds = CGRectContainsPoint(self.view.bounds, touchLocation);
      if (pointContainedinBounds && _tapWentOutsideOfBounds) {
        _tapWentOutsideOfBounds = NO;
        [self.rippleView fadeInRippleAnimated:YES completion:nil];
      } else if (!pointContainedinBounds && !_tapWentOutsideOfBounds) {
        _tapWentOutsideOfBounds = YES;
        [self.rippleView fadeOutRippleAnimated:YES completion:nil];
      }
      break;
    }
    case UIGestureRecognizerStateCancelled:
      [self.rippleView cancelAllRipplesAnimated:YES];
//      _shouldRespondToTouch = NO;
      break;
    case UIGestureRecognizerStateEnded:
      [self.rippleView BeginRipplePressUpAnimated:YES completion:nil];
//      _shouldRespondToTouch = NO;
      break;
    case UIGestureRecognizerStateFailed:
      [self.rippleView cancelAllRipplesAnimated:YES];
//      _shouldRespondToTouch = NO;
      break;
  }

//  if (_shouldRespondToTouch) {
//    _previousLocation = touchLocation;
//  } else {
//    _previousLocation = CGPointZero;
//  }
}

//- (void)cancelRippleGestureWithRecognizer:(MDCRippleGestureRecognizer *)recognizer {
//  // To exit, disable the recognizer immediately which forces it to drop out of the current
//  // loop and prevent any state updates. Then re-enable to allow future gesture recognition.
//  recognizer.enabled = NO;
//  recognizer.enabled = YES;
//}

- (void)touchBeganAtPoint:(CGPoint)point touchLocation:(CGPoint)touchLocation {
//  if (_shouldRespondToTouch) {
    [self.rippleView BeginRipplePressDownAtPoint:point animated:YES completion:nil];
//    if ([_delegate
//            respondsToSelector:@selector(rippleTouchController:didProcessRippleView:atTouchLocation:)]) {
//      [_delegate rippleTouchController:self
//                  didProcessRippleView:_addedRippleView
//                    atTouchLocation:touchLocation];
//    }
//    _shouldRespondToTouch = NO;
//  }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(__unused UIGestureRecognizer *)other {
  // Subclasses can override this to prioritize another recognizer.
  return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if ([_delegate respondsToSelector:@selector(rippleTouchController:
                                        shouldProcessRippleTouchesAtTouchLocation:)]) {
    CGPoint touchLocation = [gestureRecognizer locationInView:_view];
    return [_delegate rippleTouchController:self shouldProcessRippleTouchesAtTouchLocation:touchLocation];
  }
  return YES;
}

@end
