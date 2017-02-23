/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCUnderlineView.h"

#import "MDCTextInput+Internal.h"

static const CGFloat kGOOTextFieldBorderFocusedHeight = 2.f;

static const NSTimeInterval kGOOTextFieldDividerAnimationDuration = 0.2f;

@implementation GOOUnderlineView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _focusedColor = [GOOTextFieldDefaultColorGroup() regularColor];
    _unfocusedColor = GOOTextFieldBorderColor();
    _errorColor = GOOTextFieldTextErrorColor();
    _enabled = YES;

    [self setClipsToBounds:NO];
    [self updateBackgroundColor];
    [self updateBorder];
  }

  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateBorderPath];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(size.width, kGOOTextFieldBorderHeight);
}

- (void)updateBorderPath {
  CGRect bounds = [self bounds];

  if (_focusedBorder) {
    CGRect focusBorderRect = bounds;
    focusBorderRect.size.height = kGOOTextFieldBorderFocusedHeight;
    focusBorderRect.origin.y = CGRectGetMidY(bounds) - CGRectGetHeight(focusBorderRect) / 2;

    [_focusedBorder setFrame:focusBorderRect];
  }

  if (_disabledBorder) {
    CGMutablePathRef path = CGPathCreateMutable();
    if (path) {
      [_disabledBorder setFrame:bounds];
      [_disabledBorder setLineWidth:CGRectGetHeight(bounds)];

      CGPathMoveToPoint(path, NULL, CGRectGetMinX(bounds), CGRectGetMidY(bounds));
      CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(bounds), CGRectGetMidY(bounds));
      [_disabledBorder setPath:path];
      CGPathRelease(path);
    }
  }
}

- (void)updateBorder {
  if (_focusBorderHidden) {
    [_disabledBorder removeFromSuperlayer];
    _disabledBorder = nil;

    [_focusedBorder removeFromSuperlayer];
    _focusedBorder = nil;

    return;
  }

  CALayer *layerToAdd = nil;

  if (_enabled) {
    [_disabledBorder removeFromSuperlayer];
    _disabledBorder = nil;

    if (!_focusedBorder) {
      _focusedBorder = [CALayer layer];
      [_focusedBorder setBackgroundColor:[_focusedColor CGColor]];
      [_focusedBorder setFrame:CGRectZero];
      [_focusedBorder setOpacity:0];
    }

    layerToAdd = _focusedBorder;
  } else {
    [_focusedBorder removeFromSuperlayer];
    _focusedBorder = nil;

    if (!_disabledBorder) {
      _disabledBorder = [CAShapeLayer layer];
      [_disabledBorder setFrame:CGRectZero];
      [_disabledBorder setStrokeColor:[_unfocusedColor CGColor]];
      [_disabledBorder setLineJoin:kCALineJoinMiter];
      [_disabledBorder setLineDashPattern:@[ @1.5, @1.5 ]];
    }

    layerToAdd = _disabledBorder;
  }

  [[self layer] addSublayer:layerToAdd];
  [self updateBorderPath];
}

- (void)updateBackgroundColor {
  BOOL showBorder = _enabled && !_normalBorderHidden;
  UIColor *backgroundColor = [UIColor clearColor];
  if (showBorder) {
    backgroundColor = _unfocusedColor;
  }

  [self setBackgroundColor:backgroundColor];
  [self setOpaque:showBorder];
}

- (void)updateForegroundColor {
  UIColor *backgroundColor = _focusedColor;
  if (_erroneous) {
    backgroundColor = _errorColor;
  }

  [_focusedBorder setBackgroundColor:[backgroundColor CGColor]];
}

#pragma mark - Property implementation

- (void)setFocusedColor:(UIColor *)focusedColor {
  _focusedColor = focusedColor;
  [self updateForegroundColor];
}

- (void)setUnfocusedColor:(UIColor *)unfocusedColor {
  _unfocusedColor = unfocusedColor;
  [self updateBackgroundColor];
}

- (void)setEnabled:(BOOL)enabled {
  if (_enabled != enabled) {
    _enabled = enabled;
    [self updateBorder];
    [self updateBackgroundColor];
    [self updateForegroundColor];
  }
}

- (void)setErroneous:(BOOL)erroneous {
  _erroneous = erroneous;
  [self updateForegroundColor];
}

- (void)setFocusBorderHidden:(BOOL)hidden {
  _focusBorderHidden = hidden;
  [self updateBorder];
}

- (void)setNormalBorderHidden:(BOOL)hidden {
  _normalBorderHidden = hidden;
  [self updateBackgroundColor];
}

#pragma mark - Animations

- (void)animateFocusBorderIn {
  if (!_enabled) {
    return;
  }

  CGRect toBounds = [self bounds];
  toBounds.size.height = kGOOTextFieldBorderFocusedHeight;

  CGFloat width = CGRectGetWidth(toBounds);

  CAKeyframeAnimation *sizeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
  [sizeAnimation setValues:@[
    [NSValue valueWithCGSize:CGSizeMake(1, kGOOTextFieldBorderFocusedHeight * 2)],
    [NSValue valueWithCGSize:CGSizeMake(width * 0.4f, kGOOTextFieldBorderFocusedHeight * 2)],
    [NSValue valueWithCGSize:CGSizeMake(width * 0.8f, kGOOTextFieldBorderFocusedHeight)],
    [NSValue valueWithCGSize:toBounds.size],
  ]];

  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  [alphaAnimation setFromValue:@1];
  [alphaAnimation setToValue:@1];

  CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
  [animationGroup setDuration:kGOOTextFieldDividerAnimationDuration];
  [animationGroup setAnimations:@[ sizeAnimation, alphaAnimation ]];

  [_focusedBorder addAnimation:animationGroup forKey:@"animateFocusBorderIn"];
  [_focusedBorder setOpacity:1];
}

- (void)animateFocusBorderOut {
  if (!_enabled) {
    return;
  }

  CGRect fromBounds = [self bounds];
  fromBounds.size.height = kGOOTextFieldBorderFocusedHeight;

  CGRect toBounds = fromBounds;
  toBounds.size.height = 0;

  CABasicAnimation *sizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
  [sizeAnimation setFromValue:[NSValue valueWithCGSize:fromBounds.size]];
  [sizeAnimation setToValue:[NSValue valueWithCGSize:toBounds.size]];

  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  [alphaAnimation setFromValue:@1];
  [alphaAnimation setToValue:@0];

  CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
  [animationGroup setDuration:kGOOTextFieldDividerOutAnimationDuration];
  [animationGroup setAnimations:@[ sizeAnimation, alphaAnimation ]];

  [_focusedBorder addAnimation:animationGroup forKey:@"animateFocusBorderOut"];
  [_focusedBorder setOpacity:0];
}

@end
