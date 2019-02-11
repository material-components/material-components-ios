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
#import "private/MDCRippleLayer.h"

static const CGFloat kDefaultRippleAlpha = (CGFloat)0.12;
static const CGFloat kDefaultRippleSelectedAlpha = (CGFloat)0.08;
static const CGFloat kDefaultRippleDraggedAlpha = (CGFloat)0.08;

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
  BOOL _didReceiveTouch;
  CGPoint _lastTouch;
}

@dynamic activeRippleLayer;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCStatefulRippleViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
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
    _rippleColors[@(MDCRippleStateNormal)] = [UIColor colorWithWhite:0 alpha:kDefaultRippleAlpha];
    _rippleColors[@(MDCRippleStateHighlighted)] = [UIColor colorWithWhite:0
                                                                    alpha:kDefaultRippleAlpha];
    _rippleColors[@(MDCRippleStateSelected)] =
        [selectionColor colorWithAlphaComponent:kDefaultRippleSelectedAlpha];
    _rippleColors[@(MDCRippleStateSelected | MDCRippleStateHighlighted)] =
        [selectionColor colorWithAlphaComponent:kDefaultRippleAlpha];
    _rippleColors[@(MDCRippleStateDragged)] = [UIColor colorWithWhite:0
                                                                alpha:kDefaultRippleDraggedAlpha];
    _rippleColors[@(MDCRippleStateDragged | MDCRippleStateHighlighted)] =
        [UIColor colorWithWhite:0 alpha:kDefaultRippleDraggedAlpha];
    _rippleColors[@(MDCRippleStateSelected | MDCRippleStateDragged)] =
        [selectionColor colorWithAlphaComponent:kDefaultRippleDraggedAlpha];
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
  if (!self.allowsSelection) {
    // If we disallow selection we don't want to apply any visual or state changes for selection.
    return;
  }
  if (_tapWentOutsideOfBounds) {
    // If the tap goes outside of bounds when a selection state change is triggered, we want to
    // return early and not issue the selection state change as guidelines dictate that if a tap is
    // let go outside the bounds, it should not trigger an action like issuing
    // a selection/deselection.
    return;
  }
  if (selected == _selected && self.activeRippleLayer) {
    // If selected is already set to YES, and there is already an active ripple layer apparent,
    // we want to return early so we don't add multiple selected overlays, as there can be only one.
    return;
  }
  _selected = selected;
  // Go into the selected state visually.
  if (selected) {
    if (!self.activeRippleLayer) {
      // If we go into the selected state but a ripple layer doesn't exist yet, it means we went
      // into this state without initially creating the ripple overlay by going through the
      // highlighted state. This usually occurs when cells are reused and the selected state is
      // manually set to show the cell's existing state.
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
  // Go into the highlighted state visually.
  if (rippleHighlighted && !_tapWentInsideOfBounds) {
    // If ripple becomes highlighted we initiate a ripple with animation.
    [self updateRippleColor];
    [self beginRippleTouchDownAtPoint:_lastTouch animated:_didReceiveTouch completion:nil];
  } else {
    if (!self.allowsSelection && !self.dragged && !_tapWentOutsideOfBounds) {
      // We dissolve the ripple when highlighted is NO, unless we are going into
      // selection or dragging.
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

- (BOOL)pointInsideSuperview:(CGPoint)point withEvent:(UIEvent *)event {
  CGPoint superviewPoint = [self convertPoint:point toView:self.superview];
  return [self.superview pointInside:superviewPoint withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  if ([self pointInsideSuperview:point withEvent:event]) {
    _didReceiveTouch = YES;
    _lastTouch = point;
    _tapWentInsideOfBounds = NO;
    _tapWentOutsideOfBounds = NO;
  }
  return [super pointInside:point withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  // When the touch is held and moved outside and inside the bounds of the surface,
  // the ripple should gracefully fade out and in accordingly.
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  BOOL pointContainedinSuperview = [self pointInsideSuperview:location withEvent:event];
  if (pointContainedinSuperview && _tapWentOutsideOfBounds) {
    _tapWentInsideOfBounds = YES;
    _tapWentOutsideOfBounds = NO;
    [self fadeInRippleAnimated:YES completion:nil];
  } else if (!pointContainedinSuperview && !_tapWentOutsideOfBounds) {
    _tapWentOutsideOfBounds = YES;
    [self fadeOutRippleAnimated:YES completion:nil];
  }
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  _didReceiveTouch = NO;
  if (_tapWentOutsideOfBounds) {
    [self beginRippleTouchUpAnimated:NO completion:nil];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  _didReceiveTouch = NO;
  [self beginRippleTouchUpAnimated:YES completion:nil];
}

@end
