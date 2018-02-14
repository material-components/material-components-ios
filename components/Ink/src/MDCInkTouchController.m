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

#import "MDCInkTouchController.h"

#import "MDCInkGestureRecognizer.h"
#import "MDCInkView.h"

static const NSTimeInterval kInkTouchDelayInterval = 0.1;

@interface MDCInkTouchController ()
@property(nonatomic, strong) MDCInkView *addedInkView;
@property(nonatomic, strong) MDCInkView *defaultInkView;
@property(nonatomic, assign) BOOL shouldRespondToTouch;
@property(nonatomic, assign) CGPoint previousLocation;
@end

@protocol MDCInkTouchControllerLegacyDelegate <NSObject>
@optional

/**
 This protocol is private and declares an old method signature that will be removed once legacy code
 has been migrated to the new delegate protocol.
 */
- (BOOL)shouldInkTouchControllerProcessInkTouches:
        (nonnull MDCInkTouchController *)inkTouchController
    __deprecated_msg("shouldInkTouchControllerProcessInkTouches has been replaced with "
                     "inkTouchController:shouldProcessInkTouchesAtTouchLocation.");

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
        [[MDCInkGestureRecognizer alloc] initWithTarget:self action:@selector(handleInkGesture:)];
    _gestureRecognizer.delegate = self;

    _view = view;
    [_view addGestureRecognizer:_gestureRecognizer];

    _defaultInkView = [[MDCInkView alloc] initWithFrame:view.bounds];
    _defaultInkView.inkColor = _defaultInkView.defaultInkColor;
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
    _addedInkView = _defaultInkView;

    if ([_delegate respondsToSelector:@selector(inkTouchController:insertInkView:intoView:)]) {
      [_delegate inkTouchController:self insertInkView:_addedInkView intoView:_view];
    } else {
      [_view addSubview:_addedInkView];
    }
  }
}

- (void)cancelInkTouchProcessing {
  [_addedInkView cancelAllAnimationsAnimated:YES];
}

- (MDCInkView *_Nullable)inkViewAtTouchLocation:(CGPoint)location {
  MDCInkView *inkView;
  if ([_delegate respondsToSelector:@selector(inkTouchController:inkViewAtTouchLocation:)]) {
    inkView = [_delegate inkTouchController:self inkViewAtTouchLocation:location];
  } else {
    CGPoint locationInInkCoords = [self.view convertPoint:location toView:_addedInkView];
    if ([_addedInkView pointInside:locationInInkCoords withEvent:nil]) {
      inkView = _addedInkView;
    }
  }
  return inkView;
}

- (void)handleInkGesture:(MDCInkGestureRecognizer *)recognizer {
  CGPoint touchLocation = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      if ([_delegate respondsToSelector:@selector(inkTouchController:inkViewAtTouchLocation:)]) {
        _addedInkView = [_delegate inkTouchController:self inkViewAtTouchLocation:touchLocation];
        if (!_addedInkView) {
          return [self cancelInkGestureWithRecognizer:recognizer];
        }
        NSAssert([_addedInkView isDescendantOfView:_view],
                 @"Ink view %@ returned by inkTouchController:inkViewAtTouchLocation: must be a "
                  "subview of base view %@",
                 _addedInkView, _view);
        recognizer.targetBounds = [_addedInkView convertRect:_addedInkView.bounds toView:_view];
      }

      _shouldRespondToTouch = YES;
      dispatch_time_t delayTime =
          dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * kInkTouchDelayInterval));
      dispatch_after(_delaysInkSpread ? delayTime : 0, dispatch_get_main_queue(), ^(void) {
        [self touchBeganAtPoint:[recognizer locationInView:self.addedInkView]
                  touchLocation:touchLocation];
      });
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      // Due to changes on iPhone 6s, possibly due to the force touch,
      // @c UIGestureRecognizerStateChanged constantly fires. However, we do not want to cancel the
      // ink unless the users moves.
      if (_shouldRespondToTouch && !CGPointEqualToPoint(touchLocation, _previousLocation)) {
        _shouldRespondToTouch = NO;
      }
      break;
    }
    case UIGestureRecognizerStateCancelled:
      [_addedInkView cancelAllAnimationsAnimated:YES];
      _shouldRespondToTouch = NO;
      break;
    case UIGestureRecognizerStateRecognized:
      [_addedInkView startTouchEndedAnimationAtPoint:touchLocation completion:nil];
      _shouldRespondToTouch = NO;
      break;
    case UIGestureRecognizerStateFailed:
      [_addedInkView cancelAllAnimationsAnimated:YES];
      _shouldRespondToTouch = NO;
      break;
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

- (void)touchBeganAtPoint:(CGPoint)point touchLocation:(CGPoint)touchLocation {
  if (_shouldRespondToTouch) {
    [_addedInkView startTouchBeganAnimationAtPoint:point completion:nil];
    if ([_delegate
            respondsToSelector:@selector(inkTouchController:didProcessInkView:atTouchLocation:)]) {
      [_delegate inkTouchController:self
                  didProcessInkView:_addedInkView
                    atTouchLocation:touchLocation];
    }
    _shouldRespondToTouch = NO;
  }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(__unused UIGestureRecognizer *)other {
  // Subclasses can override this to prioritize another recognizer.
  return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if ([_delegate respondsToSelector:@selector(inkTouchController:
                                        shouldProcessInkTouchesAtTouchLocation:)]) {
    CGPoint touchLocation = [gestureRecognizer locationInView:_view];
    return [_delegate inkTouchController:self shouldProcessInkTouchesAtTouchLocation:touchLocation];
  } else if ([_delegate respondsToSelector:@selector(shouldInkTouchControllerProcessInkTouches:)]) {
    // Please use inkTouchController:shouldProcessInkTouchesAtTouchLocation. The delegate call below
    // is deprecated and only provided for legacy support.
    id<MDCInkTouchControllerLegacyDelegate> legacyDelegate =
        (id<MDCInkTouchControllerLegacyDelegate>)_delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [legacyDelegate shouldInkTouchControllerProcessInkTouches:self];
#pragma clang diagnostic pop
  }
  return YES;
}

#pragma mark - Deprecations

- (MDCInkView *)inkView {
  return _defaultInkView;
}

@end
