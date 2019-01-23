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

#import "MDCRippleTouchController.h"

@implementation MDCRippleTouchController

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
    _tapWentOutsideOfBounds = NO;
    _processRippleWithScrollViewGestures = YES;
  }
  return self;
}

- (void)dealloc {
  [_view removeGestureRecognizer:_gestureRecognizer];
  _gestureRecognizer.delegate = nil;
}

- (void)cancelRippleTouchProcessing {
  [self.rippleView cancelAllRipplesAnimated:YES completion:nil];
}

- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer {
  CGPoint lastTouch = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      _tapWentOutsideOfBounds = NO;
      [self.rippleView beginRippleTouchDownAtPoint:lastTouch animated:YES completion:nil];
      if ([_delegate respondsToSelector:@selector(rippleTouchController:
                                                   didProcessRippleView:atTouchLocation:)]) {
        [_delegate rippleTouchController:self
                    didProcessRippleView:_rippleView
                         atTouchLocation:lastTouch];
      }
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      BOOL pointContainedinBounds = CGRectContainsPoint(self.view.bounds, lastTouch);
      if (pointContainedinBounds && _tapWentOutsideOfBounds) {
        self.tapWentOutsideOfBounds = NO;
        [self.rippleView fadeInRippleAnimated:YES completion:nil];
      } else if (!pointContainedinBounds && !_tapWentOutsideOfBounds) {
        self.tapWentOutsideOfBounds = YES;
        [self.rippleView fadeOutRippleAnimated:YES completion:nil];
      }
      break;
    }
    case UIGestureRecognizerStateEnded:
      [self.rippleView beginRippleTouchUpAnimated:YES completion:nil];
      break;
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed:
      [self cancelRippleTouchProcessing];
      break;
  }
}

- (void)setTapWentOutsideOfBounds:(BOOL)tapWentOutsideOfBounds {
  _tapWentOutsideOfBounds = tapWentOutsideOfBounds;
  if ([_delegate respondsToSelector:
       @selector(rippleTouchController:tapWentOutsideOfBounds:)]) {
    [_delegate rippleTouchController:self
              tapWentOutsideOfBounds:tapWentOutsideOfBounds];
  }
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
    return [_delegate rippleTouchController:self
        shouldProcessRippleTouchesAtTouchLocation:touchLocation];
  }
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  if (!self.processRippleWithScrollViewGestures &&
      [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
    return YES;
  }
  return NO;
}

@end
