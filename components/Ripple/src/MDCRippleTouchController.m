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

#import "MDCRippleView.h"

@implementation MDCRippleTouchController {
  BOOL _tapWentOutsideOfBounds;
  NSMutableDictionary<NSNumber *, UIColor *> *_rippleColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_rippleAlphas;
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
      _rippleColors[@(MDCRippleStateNormal)] = [UIColor blackColor];
      _rippleColors[@(MDCRippleStateSelected)] = [UIColor colorWithRed:(CGFloat)0.384
                                                                 green:0
                                                                  blue:(CGFloat)0.933
                                                                 alpha:1];
    }

    if (_rippleAlphas == nil) {
      _rippleAlphas = [NSMutableDictionary dictionary];
      _rippleAlphas[@(MDCRippleStateNormal)] = @(0.16);
      _rippleAlphas[@(MDCRippleStateSelected)] = @(0.08);
    }

    _selectionMode = NO;
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
  UIColor *rippleColor = [self constructedColorByState];
  [self.rippleView setActiveRippleColor:rippleColor];
}

- (void)setRippleColor:(UIColor *)rippleColor forState:(MDCRippleState)state {
  _rippleColors[@(state)] = rippleColor;

  [self updateRippleColor];
}

- (CGFloat)rippleAlphaForState:(MDCRippleState)state {
  NSNumber *rippleAlpha = _rippleAlphas[@(state)];
  if (state != MDCRippleStateNormal && rippleAlpha == nil) {
    rippleAlpha = _rippleAlphas[@(MDCRippleStateNormal)];
  }
  return [rippleAlpha doubleValue];
}

- (void)setRippleAlpha:(CGFloat)rippleAlpha forState:(MDCRippleState)state {
  _rippleAlphas[@(state)] = @(rippleAlpha);
}

- (UIColor *)constructedColorByState {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  return [rippleColor colorWithAlphaComponent:[self rippleAlphaForState:self.state]];
}

- (void)setState:(MDCRippleState)state {
  _state = state;
  [self updateActiveRippleColor];
}

- (void)setAllowsSelection:(BOOL)allowsSelection {
  _allowsSelection = allowsSelection;

  if (allowsSelection) {
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
  _selected = selected;
  [self setState:selected ? MDCRippleStateSelected : MDCRippleStateNormal];
}

- (void)setSelectionMode:(BOOL)selectionMode {
  _selectionMode = selectionMode;
  UIColor *rippleColor =
      [self rippleColorForState:selectionMode ? MDCRippleStateSelected : MDCRippleStateNormal];
  rippleColor =
      [rippleColor colorWithAlphaComponent:[self rippleAlphaForState:MDCRippleStateNormal]];
  [self.rippleView setRippleColor:rippleColor];
}

- (void)cancelRippleTouchProcessing {
  [self.rippleView cancelAllRipplesAnimated:YES];
}

- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer {
  CGPoint touchLocation = [recognizer locationInView:_view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      _tapWentOutsideOfBounds = NO;
      [self.rippleView beginRippleTouchDownAtPoint:touchLocation
                                          animated:YES
                                        completion:^{
                                          if (self.selectionMode) {
                                            self.selected = !self.selected;
                                            if (!self.selected) {
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
        [self.rippleView beginRippleTouchUpAnimated:YES completion:nil];
      }
      break;
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed:
      [self.rippleView cancelAllRipplesAnimated:YES];
      break;
  }
}

- (void)handleRippleSelectionGesture:(UILongPressGestureRecognizer *)recognizer {
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      [self setSelectionMode:!_selectionMode];
      if (self.selectionMode) {
        self.selected = YES;
      } else {
        if (!self.selected) {
          [self.rippleView cancelAllRipplesAnimated:YES];
        }
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
