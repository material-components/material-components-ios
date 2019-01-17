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
  NSMutableDictionary<NSNumber *, UIColor *> *_rippleColors;
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
    _tapWentOutsideOfBounds = NO;

    if (_rippleColors == nil) {
      _rippleColors = [NSMutableDictionary dictionary];
      UIColor *selectionColor = [UIColor colorWithRed:(CGFloat)0.384
                                                green:0
                                                 blue:(CGFloat)0.933
                                                alpha:1];
      _rippleColors[@(MDCRippleStateNormal)] = UIColor.clearColor;
      _rippleColors[@(MDCRippleStateHighlighted)] = [UIColor colorWithWhite:0 alpha:(CGFloat)0.16];
      _rippleColors[@(MDCRippleStateSelected)] =
          [selectionColor colorWithAlphaComponent:(CGFloat)0.08];
      _rippleColors[@(MDCRippleStateSelected | MDCRippleStateHighlighted)] =
          [selectionColor colorWithAlphaComponent:(CGFloat)0.16];
    }
    _selectionMode = NO;
    _selected = NO;
    _highlighted = NO;
  }
  return self;
}

- (void)dealloc {
  [_view removeGestureRecognizer:_gestureRecognizer];
  _gestureRecognizer.delegate = nil;
  [_view removeGestureRecognizer:_selectionGestureRecognizer];
  _selectionGestureRecognizer.delegate = nil;
}

- (UIColor *)rippleColorForState:(MDCRippleState)state {
  UIColor *rippleColor = _rippleColors[@(state)];
  if (state != MDCRippleStateNormal && rippleColor == nil) {
    rippleColor = _rippleColors[@(MDCRippleStateNormal)];
  }
  return rippleColor;
}

- (void)updateRippleColor {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  [self.rippleView setRippleColor:rippleColor];
}

- (void)updateActiveRippleColor {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  [self.rippleView setActiveRippleColor:rippleColor];
}

- (void)setRippleColor:(UIColor *)rippleColor forState:(MDCRippleState)state {
  _rippleColors[@(state)] = rippleColor;

  [self updateRippleColor];
}

//- (UIColor *)constructedColorByState {
//  UIColor *rippleColor = [self rippleColorForState:self.state];
//  return [rippleColor colorWithAlphaComponent:[self rippleAlphaForState:self.state]];
//}

- (void)setState:(MDCRippleState)state {
  _state = state;
  NSLog(@"state: %ld", (long)state);
}

- (void)setEnableLongPressGestureForSelection:(BOOL)enableLongPressGestureForSelection {
  _enableLongPressGestureForSelection = enableLongPressGestureForSelection;

  if (enableLongPressGestureForSelection) {
    _selectionGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleRippleSelectionGesture:)];
    _selectionGestureRecognizer.minimumPressDuration = (CGFloat)0.5;
    _selectionGestureRecognizer.delegate = self;
    _selectionGestureRecognizer.cancelsTouchesInView = NO;
    _selectionGestureRecognizer.delaysTouchesEnded = NO;
    [_view addGestureRecognizer:_selectionGestureRecognizer];
  } else {
    [_view removeGestureRecognizer:_selectionGestureRecognizer];
    _selectionGestureRecognizer.delegate = nil;
  }
}

- (void)setSelected:(BOOL)selected {
  if (selected == _selected) {
    return;
  }
  _selected = selected;
  if (selected) {
    self.state |= MDCRippleStateSelected;
  } else {
    self.state &= ~MDCRippleStateSelected;
  }
  [self updateActiveRippleColor];
}

- (void)setHighlighted:(BOOL)highlighted {
  if (highlighted == _highlighted) {
    return;
  }
  _highlighted = highlighted;
  if (highlighted) {
    self.state |= MDCRippleStateHighlighted;
  } else {
    self.state &= ~MDCRippleStateHighlighted;
  }
  [self updateRippleColor];
}

- (void)setSelectionMode:(BOOL)selectionMode {
  _selectionMode = selectionMode;
  if (!selectionMode) {
    self.selected = NO;
  }
}

- (void)cancelRippleTouchProcessing {
  [self.rippleView cancelAllRipplesAnimated:YES];
}

- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer {
  CGPoint touchLocation = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      _tapWentOutsideOfBounds = NO;
      self.highlighted = YES;
      [self.rippleView beginRippleTouchDownAtPoint:touchLocation
                                          animated:YES
                                        completion:^{
                                          if (self.selectionMode) {
                                            // In selection mode highlighted doesn't stay even
                                            // if a tap is held.
                                            self.highlighted = NO;
                                            self.selected = !self.selected;
                                            if (!self.selected) {
                                              // If we are unselecting all overlays must go.
                                              [self.rippleView cancelAllRipplesAnimated:YES];
                                            }
                                          }
                                        }];
      if ([_delegate respondsToSelector:@selector(rippleTouchController:
                                                   didProcessRippleView:atTouchLocation:)]) {
        [_delegate rippleTouchController:self
                    didProcessRippleView:_rippleView
                         atTouchLocation:touchLocation];
      }
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
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
    case UIGestureRecognizerStateEnded:
      if (!_selectionMode) {
        self.highlighted = NO;
        [self.rippleView beginRippleTouchUpAnimated:YES completion:nil];
      }
      break;
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed:
      [self.rippleView cancelAllRipplesAnimated:YES];
      self.highlighted = NO;
      break;
  }
}

- (void)handleRippleSelectionGesture:(UILongPressGestureRecognizer *)recognizer {
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      // Long press only brings us into selection mode, but not out of it.
      if (!self.selectionMode) {
        self.selectionMode = YES;
        self.highlighted = NO;
        self.selected = YES;
      }
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      break;
    }
    case UIGestureRecognizerStateCancelled:
      break;
    case UIGestureRecognizerStateEnded:
      break;
    case UIGestureRecognizerStateFailed:
      break;
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

@end
