/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCInkTouchController.h"

#import "MDCInkView.h"
#import "private/MDCInkGestureRecognizer.h"

static const NSTimeInterval kMDCInkTouchDelayInterval = 0.1;

@interface MDCInkTouchController ()
@property(nonatomic) MDCInkView *defaultInkView;
@property(nonatomic) BOOL shouldRespondToTouch;
@property(nonatomic) CGPoint previousLocation;
@end

@implementation MDCInkTouchController

- (CGFloat)dragCancelDistance {
  return _gestureRecognizer.dragCancelDistance;
}

- (void)setDragCancelDistance:(CGFloat)dragCancelDistance {
  _gestureRecognizer.dragCancelDistance = dragCancelDistance;
}

- (BOOL)cancelsOnDragOut {
  return _gestureRecognizer.cancelOnDragOut;
}

- (void)setCancelsOnDragOut:(BOOL)cancelsOnDragOut {
  _gestureRecognizer.cancelOnDragOut = cancelsOnDragOut;
}

- (CGRect)targetBounds {
  return _gestureRecognizer.targetBounds;
}

- (void)setTargetBounds:(CGRect)targetBounds {
  _gestureRecognizer.targetBounds = targetBounds;
}

- (instancetype)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    _gestureRecognizer =
        [[MDCInkGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handleInkGesture:)];
    _gestureRecognizer.delegate = self;

    _view = view;
    [_view addGestureRecognizer:_gestureRecognizer];

    _defaultInkView = [[MDCInkView alloc] initWithFrame:view.bounds];
    _defaultInkView.inkColor = [UIColor colorWithWhite:224.0f / 255.0f alpha:0.25f];
    _defaultInkView.autoresizingMask =
        UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  }
  return self;
}

- (void)dealloc {
  [_view removeGestureRecognizer:_gestureRecognizer];
  _gestureRecognizer.delegate = nil;
}

- (void)addInkView {
  if (![_delegate respondsToSelector:@selector(inkTouchController:inkViewAtTouchLocation:)]) {
    _inkView = _defaultInkView;

    if ([_delegate respondsToSelector:@selector(inkTouchController:insertInkView:intoView:)]) {
      [_delegate inkTouchController:self insertInkView:_inkView intoView:_view];
    } else {
      [_view addSubview:_inkView];
    }
  }
}

- (void)cancelInkTouchProcessing {
  [_inkView evaporateWithCompletion:nil];
}

- (void)handleInkGesture:(MDCInkGestureRecognizer *)recognizer {
  CGPoint touchLocation = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      if ([_delegate respondsToSelector:@selector(inkTouchController:inkViewAtTouchLocation:)]) {
        _inkView = [_delegate inkTouchController:self inkViewAtTouchLocation:touchLocation];
        if (!_inkView) {
          return [self cancelInkGestureWithRecognizer:recognizer];
        }
        NSAssert([_inkView isDescendantOfView:_view],
                 @"Ink view %@ returned by inkTouchController:inkViewAtTouchLocation: must be a "
                  "subview of base view %@",
                 _inkView, _view);
        recognizer.targetBounds = [_inkView convertRect:_inkView.bounds toView:_view];
      }

      _shouldRespondToTouch = YES;
      dispatch_time_t delayTime =
          dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * kMDCInkTouchDelayInterval));
      dispatch_after(_delaysInkSpread ? delayTime : 0, dispatch_get_main_queue(), ^(void) {
        [self spreadInkFromPoint:[recognizer locationInView:_inkView]
                   touchLocation:touchLocation
                      completion:nil];
      });
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      // Due to changes on iPhone 6s, possibly due to the force touch,
      // |UIGestureRecognizerStateChanged| constantly fires. However, we do not want to cancel the
      // ink unless the users moves.
      if (_shouldRespondToTouch && !CGPointEqualToPoint(touchLocation, _previousLocation)) {
        _shouldRespondToTouch = NO;
      }
      break;
    }
    case UIGestureRecognizerStateRecognized:
    case UIGestureRecognizerStateFailed: {
      [_inkView evaporateWithCompletion:nil];
      _shouldRespondToTouch = NO;
      break;
    }
    case UIGestureRecognizerStateCancelled: {
      [_inkView evaporateToPoint:[recognizer locationInView:_inkView] completion:nil];
      _shouldRespondToTouch = NO;
      break;
    }
  }

  if (_shouldRespondToTouch) {
    _previousLocation = touchLocation;
  } else {
    _previousLocation = CGPointZero;
  }
}

- (void)cancelInkGestureWithRecognizer:(MDCInkGestureRecognizer *)recognizer {
  // To exit, disable the recognizer immediately which forces it to drop out of the current
  // loop and prevent any state updates. Then re-enable to allow future gesture recognition.
  recognizer.enabled = NO;
  recognizer.enabled = YES;
}

- (void)spreadInkFromPoint:(CGPoint)point
             touchLocation:(CGPoint)touchLocation
                completion:(MDCInkCompletionBlock)completionBlock {
  if (_shouldRespondToTouch) {
    [_inkView spreadFromPoint:point completion:completionBlock];
    if ([_delegate
            respondsToSelector:@selector(inkTouchController:didProcessInkView:atTouchLocation:)]) {
      [_delegate inkTouchController:self didProcessInkView:_inkView atTouchLocation:touchLocation];
    }
    _shouldRespondToTouch = NO;
  }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other {
  // Subclasses can override this to prioritize another recognizer.
  return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if ([_delegate respondsToSelector:@selector(inkTouchControllerShouldProcessInkTouches:)]) {
    return [_delegate inkTouchControllerShouldProcessInkTouches:self];
  }
  return YES;
}

@end
