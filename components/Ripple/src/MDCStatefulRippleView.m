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
  BOOL _deselecting;
  BOOL _tapWentOutsideOfBounds;
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
  self.userInteractionEnabled = YES;
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
  [self setActiveRippleColor:rippleColor];
  [self setRippleColor:rippleColor];
}

- (void)setRippleColor:(UIColor *)rippleColor forState:(MDCRippleState)state {
  _rippleColors[@(state)] = rippleColor;

  [self updateRippleColor];
}

- (void)setState:(MDCRippleState)state {
  _state = state;
  NSLog(@"state: %ld", (long)state);
}

- (void)setSelected:(BOOL)selected {
  if (!self.selectionMode) {
    return;
  }
  _selected = selected;
  if (selected) {
    self.state |= MDCRippleStateSelected;
  } else {
    self.state &= ~MDCRippleStateSelected;
  }

  // If set to selected, the ripple color should be set prior to initiating the ripple.
  if (selected) {
    [self updateRippleColor];
  }

  // Go into the selected state visually.
  if (selected && !self.rippleHighlighted && !self.activeRippleLayer) {
    [self beginRippleTouchDownAtPoint:self.touchLocation animated:self.rippleHighlighted completion:nil];
  } else if (!selected) {
    // completion block won't be called if there is no activeRippleLayer to invoke on.
    if (self.activeRippleLayer) {
      _deselecting = YES;
    }
    [self beginRippleTouchUpAnimated:self.rippleHighlighted completion:^{
      [self cancelAllRipplesAnimated:!self.rippleHighlighted completion:^{
        self->_deselecting = NO;
        [self updateRippleColor];
      }];
    }];
  }
}

- (void)setRippleHighlighted:(BOOL)rippleHighlighted {
  _rippleHighlighted = rippleHighlighted;
  if (rippleHighlighted) {
    self.state |= MDCRippleStateHighlighted;
  } else {
    self.state &= ~MDCRippleStateHighlighted;
  }
  if (rippleHighlighted) {
    [self beginRippleTouchDownAtPoint:self.touchLocation animated:YES completion:^{
      if (!self.selected) {
        [self updateRippleColor];
      }
    }];
    [self updateRippleColor];
  } else if ((!_deselecting && !self.selected) || _tapWentOutsideOfBounds) {
    [self beginRippleTouchUpAnimated:YES completion:nil];
  } else if (!_deselecting) {
    [self updateRippleColor];
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
}

- (void)setSelectionMode:(BOOL)selectionMode {
  _selectionMode = selectionMode;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  _tapWentOutsideOfBounds = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  BOOL pointContainedinBounds = CGRectContainsPoint(self.bounds, location);
  if (pointContainedinBounds && _tapWentOutsideOfBounds) {
    _tapWentOutsideOfBounds = NO;
    [self fadeInRippleAnimated:YES completion:nil];
  } else if (!pointContainedinBounds && !_tapWentOutsideOfBounds) {
    _tapWentOutsideOfBounds = YES;
    [self fadeOutRippleAnimated:YES completion:nil];
  }
}

@end
