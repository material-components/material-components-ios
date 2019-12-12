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

@implementation MDCRippleTouchController {
  BOOL _tapWentOutsideOfBounds;
  BOOL _deferred;

  struct {
    unsigned int rippleTouchControllerShouldProcessRippleTouchesAtTouchLocation : 1;
    unsigned int rippleTouchControllerDidProcessRippleViewAtTouchLocation : 1;
    unsigned int rippleTouchControllerInsertRippleViewIntoView : 1;
  } _delegateFlags;
}

@synthesize rippleView = _rippleView;

- (instancetype)initWithView:(UIView *)view {
  return [self initWithView:view deferred:NO];
}

- (nonnull instancetype)initWithView:(nonnull UIView *)view deferred:(BOOL)deferred {
  self = [self init];
  if (self) {
    _deferred = deferred;
    if (deferred) {
      [self attachGestureRecognizerToView:view];
    } else {
      [self configureRippleWithView:view];
    }
  }
  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _gestureRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleRippleGesture:)];
    _gestureRecognizer.minimumPressDuration = 0;
    _gestureRecognizer.delegate = self;
    _gestureRecognizer.cancelsTouchesInView = NO;
    _gestureRecognizer.delaysTouchesEnded = NO;

    _shouldProcessRippleWithScrollViewGestures = YES;
  }
  return self;
}

- (void)dealloc {
  [_view removeGestureRecognizer:_gestureRecognizer];
  _gestureRecognizer.delegate = nil;
}

- (MDCRippleView *)rippleView {
  if (_rippleView == nil) {
    _rippleView = [[MDCRippleView alloc] init];
  }
  return _rippleView;
}

- (void)setDelegate:(id<MDCRippleTouchControllerDelegate>)delegate {
  _delegate = delegate;

  // The delegate's behavior - in terms of which optional methods are deemed to be
  // implemented - is cached at assignment rather than inspected on each invocation.
  _delegateFlags.rippleTouchControllerShouldProcessRippleTouchesAtTouchLocation =
      [_delegate respondsToSelector:@selector(rippleTouchController:
                                        shouldProcessRippleTouchesAtTouchLocation:)];
  _delegateFlags.rippleTouchControllerDidProcessRippleViewAtTouchLocation = [_delegate
      respondsToSelector:@selector(rippleTouchController:didProcessRippleView:atTouchLocation:)];
  _delegateFlags.rippleTouchControllerInsertRippleViewIntoView =
      [delegate respondsToSelector:@selector(rippleTouchController:insertRippleView:intoView:)];
}

- (void)addRippleToView:(UIView *)view {
  [self configureRippleWithView:view];
}

- (void)configureRippleWithView:(UIView *)view {
  MDCRippleView *rippleView = self.rippleView;

  [self attachGestureRecognizerToView:view];
  [self insertRippleView:rippleView intoView:view];
}

- (void)attachGestureRecognizerToView:(UIView *)view {
  [_view removeGestureRecognizer:_gestureRecognizer];
  _view = view;
  [_view addGestureRecognizer:_gestureRecognizer];
}

- (void)insertRippleView:(MDCRippleView *)rippleView intoView:(UIView *)view {
  // Insert the rippleView to the _view
  if (_delegateFlags.rippleTouchControllerInsertRippleViewIntoView) {
    [_delegate rippleTouchController:self insertRippleView:rippleView intoView:view];
  } else {
    [_view addSubview:rippleView];
  }
  rippleView.frame = view.bounds;
}

- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer {
  CGPoint touchLocation = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      MDCRippleView *rippleView = self.rippleView;

      if (_deferred && rippleView.superview != _view) {
        [self insertRippleView:rippleView intoView:_view];
      }

      [rippleView beginRippleTouchDownAtPoint:touchLocation animated:YES completion:nil];
      if (_delegateFlags.rippleTouchControllerDidProcessRippleViewAtTouchLocation) {
        [_delegate rippleTouchController:self
                    didProcessRippleView:rippleView
                         atTouchLocation:touchLocation];
      }
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      BOOL pointContainedinBounds = CGRectContainsPoint(_view.bounds, touchLocation);
      if (pointContainedinBounds && _tapWentOutsideOfBounds) {
        _tapWentOutsideOfBounds = NO;
        [_rippleView fadeInRippleAnimated:YES completion:nil];
      } else if (!pointContainedinBounds && !_tapWentOutsideOfBounds) {
        _tapWentOutsideOfBounds = YES;
        [_rippleView fadeOutRippleAnimated:YES completion:nil];
      }
      break;
    }
    case UIGestureRecognizerStateEnded: {
      [_rippleView beginRippleTouchUpAnimated:YES completion:nil];
      break;
    }
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed: {
      [_rippleView cancelAllRipplesAnimated:YES completion:nil];
      break;
    }
  }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  if (!self.shouldProcessRippleWithScrollViewGestures &&
      [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]] &&
      ![otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] &&
      ![otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
    return YES;
  }
  return NO;
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(__unused UIGestureRecognizer *)other {
  // Subclasses can override this to prioritize another recognizer.
  return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if (_delegateFlags.rippleTouchControllerShouldProcessRippleTouchesAtTouchLocation) {
    CGPoint touchLocation = [gestureRecognizer locationInView:_view];
    return [_delegate rippleTouchController:self
        shouldProcessRippleTouchesAtTouchLocation:touchLocation];
  }
  return YES;
}

@end
