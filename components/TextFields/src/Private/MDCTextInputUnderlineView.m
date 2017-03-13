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

#import "MDCTextInputUnderlineView.h"

#import "MaterialPalettes.h"

#import "MDCTextInput+Internal.h"

static const CGFloat MDCTextInputUnderlineFocusedHeight = 2.f;

static const NSTimeInterval MDCTextInputDividerAnimationDuration = 0.2f;

static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

@implementation MDCTextInputUnderlineView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _focusedColor = [MDCPalette indigoPalette].tint500;
    _unfocusedColor = MDCTextInputUnderlineColor();
    _errorColor = [MDCPalette redPalette].tint500;
    _enabled = YES;

    [self setClipsToBounds:NO];
    [self updateBackgroundColor];
    [self updateUnderline];
  }

  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateUnderlinePath];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(size.width, MDCTextInputUnderlineHeight);
}

- (void)updateUnderlinePath {
  CGRect bounds = [self bounds];

  if (_focusedUnderline) {
    CGRect focusUnderlineRect = bounds;
    focusUnderlineRect.size.height = MDCTextInputUnderlineFocusedHeight;
    focusUnderlineRect.origin.y = CGRectGetMidY(bounds) - CGRectGetHeight(focusUnderlineRect) / 2;

    [_focusedUnderline setFrame:focusUnderlineRect];
  }

  if (_disabledUnderline) {
    CGMutablePathRef path = CGPathCreateMutable();
    if (path) {
      [_disabledUnderline setFrame:bounds];
      [_disabledUnderline setLineWidth:CGRectGetHeight(bounds)];

      CGPathMoveToPoint(path, NULL, CGRectGetMinX(bounds), CGRectGetMidY(bounds));
      CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(bounds), CGRectGetMidY(bounds));
      [_disabledUnderline setPath:path];
      CGPathRelease(path);
    }
  }
}

- (void)updateUnderline {
  if (_focusUnderlineHidden) {
    [_disabledUnderline removeFromSuperlayer];
    _disabledUnderline = nil;

    [_focusedUnderline removeFromSuperlayer];
    _focusedUnderline = nil;

    return;
  }

  CALayer *layerToAdd = nil;

  if (_enabled) {
    [_disabledUnderline removeFromSuperlayer];
    _disabledUnderline = nil;

    if (!_focusedUnderline) {
      _focusedUnderline = [CALayer layer];
      [_focusedUnderline setBackgroundColor:[_focusedColor CGColor]];
      [_focusedUnderline setFrame:CGRectZero];
      [_focusedUnderline setOpacity:0];
    }

    layerToAdd = _focusedUnderline;
  } else {
    [_focusedUnderline removeFromSuperlayer];
    _focusedUnderline = nil;

    if (!_disabledUnderline) {
      _disabledUnderline = [CAShapeLayer layer];
      [_disabledUnderline setFrame:CGRectZero];
      [_disabledUnderline setStrokeColor:[_unfocusedColor CGColor]];
      [_disabledUnderline setLineJoin:kCALineJoinMiter];
      [_disabledUnderline setLineDashPattern:@[ @1.5, @1.5 ]];
    }

    layerToAdd = _disabledUnderline;
  }

  [[self layer] addSublayer:layerToAdd];
  [self updateUnderlinePath];
}

- (void)updateBackgroundColor {
  BOOL showUnderline = _enabled && !_normalUnderlineHidden;
  UIColor *backgroundColor = [UIColor clearColor];
  if (showUnderline) {
    backgroundColor = _unfocusedColor;
  }

  [self setBackgroundColor:backgroundColor];
  [self setOpaque:showUnderline];
}

- (void)updateForegroundColor {
  UIColor *backgroundColor = _focusedColor;
  if (_erroneous) {
    backgroundColor = _errorColor;
  }

  [_focusedUnderline setBackgroundColor:[backgroundColor CGColor]];
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
    [self updateUnderline];
    [self updateBackgroundColor];
    [self updateForegroundColor];
  }
}

- (void)setErroneous:(BOOL)erroneous {
  _erroneous = erroneous;
  [self updateForegroundColor];
}

- (void)setFocusUnderlineHidden:(BOOL)hidden {
  _focusUnderlineHidden = hidden;
  [self updateUnderline];
}

- (void)setNormalUnderlineHidden:(BOOL)hidden {
  _normalUnderlineHidden = hidden;
  [self updateBackgroundColor];
}

#pragma mark - Animations

- (void)animateFocusUnderlineIn {
  if (!_enabled) {
    return;
  }

  CGRect toBounds = [self bounds];
  toBounds.size.height = MDCTextInputUnderlineFocusedHeight;

  CGFloat width = CGRectGetWidth(toBounds);

  CAKeyframeAnimation *sizeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
  [sizeAnimation setValues:@[
    [NSValue valueWithCGSize:CGSizeMake(1, MDCTextInputUnderlineFocusedHeight * 2)],
    [NSValue valueWithCGSize:CGSizeMake(width * 0.4f, MDCTextInputUnderlineFocusedHeight * 2)],
    [NSValue valueWithCGSize:CGSizeMake(width * 0.8f, MDCTextInputUnderlineFocusedHeight)],
    [NSValue valueWithCGSize:toBounds.size],
  ]];

  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  [alphaAnimation setFromValue:@1];
  [alphaAnimation setToValue:@1];

  CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
  [animationGroup setDuration:MDCTextInputDividerAnimationDuration];
  [animationGroup setAnimations:@[ sizeAnimation, alphaAnimation ]];

  [_focusedUnderline addAnimation:animationGroup forKey:@"animateFocusUnderlineIn"];
  [_focusedUnderline setOpacity:1];
}

- (void)animateFocusUnderlineOut {
  if (!_enabled) {
    return;
  }
  // TODO(larche) Decide how best to handle underline changes.
  //
  //  CGRect fromBounds = [self bounds];
  //  fromBounds.size.height = MDCTextInputUnderlineFocusedHeight;
  //
  //  CGRect toBounds = fromBounds;
  //  toBounds.size.height = 0;
  //
  //  CABasicAnimation *sizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
  //  [sizeAnimation setFromValue:[NSValue valueWithCGSize:fromBounds.size]];
  //  [sizeAnimation setToValue:[NSValue valueWithCGSize:toBounds.size]];
  //
  //  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  //  [alphaAnimation setFromValue:@1];
  //  [alphaAnimation setToValue:@0];
  //
  //  CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
  //  [animationGroup setDuration:MDCTextInputDividerOutAnimationDuration];
  //  [animationGroup setAnimations:@[ sizeAnimation, alphaAnimation ]];
  //
  //  [_focusedUnderline addAnimation:animationGroup forKey:@"animateFocusUnderlineOut"];
  //  [_focusedUnderline setOpacity:0];
}

@end
