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

#import "MDCStatefulRippleTouchController.h"

static const CGFloat kRippleAlpha = (CGFloat)0.16;
static const CGFloat kRippleSelectedAlpha = (CGFloat)0.08;
static const CGFloat kRippleDraggedAlpha = (CGFloat)0.08;

static UIColor *RippleSelectedColor(void) {
  return [UIColor colorWithRed:(CGFloat)0.384 green:0 blue:(CGFloat)0.933 alpha:1];
}

@implementation MDCStatefulRippleTouchController {
  BOOL _tapWentOutsideOfBounds;
  NSMutableDictionary<NSNumber *, UIColor *> *_rippleColors;
  BOOL _isTapped;
  CGPoint _lastTouch;
}

@dynamic delegate;

- (instancetype)initWithView:(UIView *)view {
  self = [super initWithView:view];
  if (self) {
    if (_rippleColors == nil) {
      _rippleColors = [NSMutableDictionary dictionary];
      UIColor *selectionColor = RippleSelectedColor();
      _rippleColors[@(MDCRippleStateNormal)] = [UIColor colorWithWhite:0 alpha:kRippleAlpha];
      _rippleColors[@(MDCRippleStateHighlighted)] = [UIColor colorWithWhite:0 alpha:kRippleAlpha];
      _rippleColors[@(MDCRippleStateSelected)] =
          [selectionColor colorWithAlphaComponent:kRippleSelectedAlpha];
      _rippleColors[@(MDCRippleStateSelected | MDCRippleStateHighlighted)] =
          [selectionColor colorWithAlphaComponent:kRippleAlpha];
      _rippleColors[@(MDCRippleStateDragged)] =
          [UIColor colorWithWhite:0 alpha:kRippleDraggedAlpha];
      _rippleColors[@(MDCRippleStateDragged | MDCRippleStateHighlighted)] =
          [UIColor colorWithWhite:0 alpha:kRippleDraggedAlpha];
      _rippleColors[@(MDCRippleStateSelected | MDCRippleStateDragged)] =
          [selectionColor colorWithAlphaComponent:kRippleDraggedAlpha];
    }
  }
  return self;
}

- (void)dealloc {
  [self.view removeGestureRecognizer:_selectionGestureRecognizer];
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
  [self.rippleView setActiveRippleColor:rippleColor];
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

- (void)setState:(MDCRippleState)state {
  _state = state;
  NSLog(@"state: %ld", (long)state);
  if ([self.delegate respondsToSelector:@selector(rippleTouchController:rippleStateDidChange:)]) {
    [self.delegate rippleTouchController:self rippleStateDidChange:state];
  }
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
    [self.view addGestureRecognizer:_selectionGestureRecognizer];
  } else {
    [self.view removeGestureRecognizer:_selectionGestureRecognizer];
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
  [self updateRippleColor];
  if (self.selected && !self.highlighted) {
    [self.rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];
  }
}

- (void)setHighlighted:(BOOL)highlighted {
  if (highlighted == _highlighted) {
    return;
  }
  _highlighted = highlighted;
  if (highlighted) {
    self.state |= MDCRippleStateHighlighted;
    [self updateRippleColor];
    [self.rippleView beginRippleTouchDownAtPoint:_lastTouch
                                        animated:_isTapped
                                      completion:^{
                                        if (self.selectionMode && !self.selected && self.highlighted) {
                                          self.selected = YES;
                                          self.highlighted = NO;
                                        }
                                      }];
  } else {
    self.state &= ~MDCRippleStateHighlighted;
    [self updateRippleColor];
    if (!self.selected) {
      // Don't remove overlays if we are selected.
      if (highlighted) {
        [self.rippleView beginRippleTouchUpAnimated:YES completion:nil];
      } else {
        [self cancelRippleTouchProcessing];
      }
    }
    self.dragged = NO;
    _isTapped = NO;
  }
}

- (void)setDragged:(BOOL)dragged {
  if (dragged == _dragged) {
    return;
  }
  _dragged = dragged;
  if (dragged) {
    self.state |= MDCRippleStateDragged;
  } else {
    self.state &= ~MDCRippleStateDragged;
  }
  [self updateRippleColor];
  if (!dragged) {
    [self.rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];
  }
}

- (void)setSelectionMode:(BOOL)selectionMode {
  _selectionMode = selectionMode;
  if (!selectionMode) {
    self.selected = NO;
  }
}

- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer {
  _lastTouch = [recognizer locationInView:self.view];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      _isTapped = YES;
      _tapWentOutsideOfBounds = NO;
      self.highlighted = YES;
      if ([self.delegate respondsToSelector:@selector(rippleTouchController:
                                                       didProcessRippleView:atTouchLocation:)]) {
        [self.delegate rippleTouchController:self
                        didProcessRippleView:self.rippleView
                             atTouchLocation:_lastTouch];
      }
      break;
    }
    case UIGestureRecognizerStatePossible:  // Ignored
      break;
    case UIGestureRecognizerStateChanged: {
      BOOL pointContainedinBounds = CGRectContainsPoint(self.view.bounds, _lastTouch);
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
      if (self.selectionMode && self.selected && self.highlighted && !_tapWentOutsideOfBounds) {
        self.selected = NO;
        self.highlighted = NO;
      }
      if (!self.selectionMode) {
        self.highlighted = NO;
      } else if (_tapWentOutsideOfBounds && self.selected) {
        if (!self.highlighted) {
          self.selected = NO;
        } else {
          self.highlighted = NO;
        }
      }
      break;
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed:
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
        self.selected = YES;
        self.highlighted = NO;
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
  if ([self.delegate respondsToSelector:@selector(rippleTouchController:
                                            shouldProcessRippleTouchesAtTouchLocation:)]) {
    CGPoint touchLocation = [gestureRecognizer locationInView:self.view];
    return [self.delegate rippleTouchController:self
        shouldProcessRippleTouchesAtTouchLocation:touchLocation];
  }
  return YES;
}

@end
