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

#import "MDCStatefulRippleView.h"
#import "MDCRippleLayer.h"

static const CGFloat kRippleAlpha = (CGFloat)0.16;
static const CGFloat kRippleSelectedAlpha = (CGFloat)0.08;
static const CGFloat kRippleDraggedAlpha = (CGFloat)0.08;

static UIColor *RippleSelectedColor(void) {
  return [UIColor colorWithRed:(CGFloat)0.384 green:0 blue:(CGFloat)0.933 alpha:1];
}

@interface MDCStatefulRippleView ()
@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;
@end

@implementation MDCStatefulRippleView {
  NSMutableDictionary<NSNumber *, UIColor *> *_rippleColors;
  BOOL _tapWentOutsideOfBounds;
  BOOL _tapWentInsideOfBounds;
  CGPoint _lastTouch;
}

@dynamic activeRippleLayer;

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCStatefulRippleViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCStatefulRippleViewInit];
  }
  return self;
}

- (void)commonMDCStatefulRippleViewInit {
  if (_rippleColors == nil) {
    _rippleColors = [NSMutableDictionary dictionary];
    UIColor *selectionColor = RippleSelectedColor();
    _rippleColors[@(MDCRippleStateNormal)] = [UIColor colorWithWhite:0 alpha:kRippleAlpha];
    _rippleColors[@(MDCRippleStateHighlighted)] = [UIColor colorWithWhite:0 alpha:kRippleAlpha];
    _rippleColors[@(MDCRippleStateSelected)] = [selectionColor colorWithAlphaComponent:kRippleSelectedAlpha];
    _rippleColors[@(MDCRippleStateSelected | MDCRippleStateHighlighted)] =
        [selectionColor colorWithAlphaComponent:kRippleAlpha];
    _rippleColors[@(MDCRippleStateDragged)] =
        [UIColor colorWithWhite:0 alpha:kRippleDraggedAlpha];
    _rippleColors[@(MDCRippleStateDragged | MDCRippleStateHighlighted)] =
        [UIColor colorWithWhite:0 alpha:kRippleDraggedAlpha];
    _rippleColors[@(MDCRippleStateSelected | MDCRippleStateDragged)] =
        [selectionColor colorWithAlphaComponent:kRippleDraggedAlpha];
  }
  self.userInteractionEnabled = YES;
}

- (UIColor *)rippleColorForState:(MDCRippleState)state {
  UIColor *rippleColor = _rippleColors[@(state)];
  if (rippleColor == nil && (state & MDCRippleStateDragged) != 0) {
    rippleColor = _rippleColors[@(MDCRippleStateDragged)];
  } else if (rippleColor == nil && (state & MDCRippleStateSelected) != 0) {
    rippleColor = _rippleColors[@(MDCRippleStateSelected)];
  }

  if (rippleColor == nil) {
    rippleColor = _rippleColors[@(MDCRippleStateNormal)];
  }
  return rippleColor;
}

- (void)updateRippleColor {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  [self setRippleColor:rippleColor];
}

- (void)updateActiveRippleColor {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  [self setActiveRippleColor:rippleColor];
}

- (void)setRippleColor:(UIColor *)rippleColor forState:(MDCRippleState)state {
  _rippleColors[@(state)] = rippleColor;

  [self updateRippleColor];
}

- (MDCRippleState)state {
  NSInteger state = 0;
  if (self.selected) {
    state |= MDCRippleStateSelected;
  }
  if (self.rippleHighlighted) {
    state |= MDCRippleStateHighlighted;
  }
  if (self.dragged) {
    state |= MDCRippleStateDragged;
  }
  return state;
}

- (void)setSelected:(BOOL)selected {
  if (!self.selectionMode) {
    // If selection mode is off we don't want to apply any visual or state changes for selection.
    return;
  }
  NSLog(@"SELECTED: %d", selected);
  if (selected == _selected && self.activeRippleLayer) {
    return;
  }
  _selected = selected;
  // Go into the selected state visually.
  if (selected) {
    if(!self.activeRippleLayer) {
      // If we go into the selected state manually, without coming from the highlighted state,
      // We present the ripple overlay instantly without animation.
      [self updateRippleColor];
      [self beginRippleTouchDownAtPoint:_lastTouch animated:NO completion:nil];
    } else {
      [self updateActiveRippleColor];
    }
  } else {
    // If we are no longer selecting, we cancel all the ripples.
    [self updateRippleColor];
    [self cancelAllRipplesAnimated:YES completion:nil];
  }
}

- (void)setRippleHighlighted:(BOOL)rippleHighlighted {
  if (rippleHighlighted == _rippleHighlighted) {
    return;
  }
  _rippleHighlighted = rippleHighlighted;
  NSLog(@"HIGHLIGHTED: %d", rippleHighlighted);
  // Go into the highlighted state visually.
  if (rippleHighlighted && !_tapWentInsideOfBounds) {
    // If ripple becomes highlighted we initiate a ripple with animation.
    [self updateRippleColor];
    [self beginRippleTouchDownAtPoint:_lastTouch animated:YES completion:nil];
  } else {
    if (!self.selectionMode && !self.selected && !self.dragged && !_tapWentOutsideOfBounds) {
      // We dissolve the ripple when highlighted is NO, unless we are going into selection.
      [self updateRippleColor];
      [self beginRippleTouchUpAnimated:YES completion:nil];
    }
  }
}

- (void)setDragged:(BOOL)dragged {
  if (dragged == _dragged) {
    return;
  }
  _dragged = dragged;
  NSLog(@"DRAGGED: %d", dragged);
  // Go into the dragged state visually.
  if (dragged) {
    if (!self.activeRippleLayer) {
      // If we go into the dragged state manually, without coming from the highlighted state,
      // We present the ripple overlay instantly without animation.
      [self updateRippleColor];
      [self beginRippleTouchDownAtPoint:_lastTouch animated:NO completion:nil];
    } else {
      [self updateActiveRippleColor];
    }
  } else {
    // If we are no longer dragging, we cancel all the ripples.
    [self updateRippleColor];
    [self cancelAllRipplesAnimated:YES completion:nil];
  }
}

- (void)setSelectionMode:(BOOL)selectionMode {
  _selectionMode = selectionMode;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;
  _tapWentInsideOfBounds = NO;
  _tapWentOutsideOfBounds = NO;
  [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  // When the touch is held and moved outside and inside the bounds of the surface,
  // the ripple should gracefully fade out and in accordingly.
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  BOOL pointContainedinBounds = CGRectContainsPoint(self.bounds, location);
  if (pointContainedinBounds && _tapWentOutsideOfBounds) {
    if (_tapWentOutsideOfBounds) {
      _tapWentInsideOfBounds = YES;
      _tapWentOutsideOfBounds = NO;
    }
    [self fadeInRippleAnimated:YES completion:nil];
  } else if (!pointContainedinBounds && !_tapWentOutsideOfBounds) {
    _tapWentOutsideOfBounds = YES;
    [self fadeOutRippleAnimated:YES completion:nil];
  }
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  if (_tapWentOutsideOfBounds) {
    [self beginRippleTouchUpAnimated:NO completion:nil];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self beginRippleTouchUpAnimated:YES completion:nil];
}

@end
