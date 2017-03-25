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

static const CGFloat MDCTextInputUnderlineDefaultHeight = 2.f;

// TODO: (larche): Make disabled color programmable?
static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

@implementation MDCTextInputUnderlineView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _color = MDCTextInputUnderlineColor();
    _enabled = YES;
    _width = MDCTextInputUnderlineDefaultHeight;

    [self setClipsToBounds:NO];
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

  if (_underline) {
    CGRect underlineRect = bounds;
    underlineRect.size.height = self.width;
    underlineRect.origin.y = CGRectGetMidY(bounds) - CGRectGetHeight(underlineRect) / 2;

    [_underline setFrame:underlineRect];
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
  CALayer *layerToAdd = nil;

  if (_enabled) {
    [_disabledUnderline removeFromSuperlayer];
    _disabledUnderline = nil;

    if (!_underline) {
      _underline = [CALayer layer];
      [_underline setBackgroundColor:[_color CGColor]];
      [_underline setFrame:CGRectZero];
      [_underline setOpacity:0];
    }

    layerToAdd = _underline;
  } else {
    [_underline removeFromSuperlayer];
    _underline = nil;

    if (!_disabledUnderline) {
      _disabledUnderline = [CAShapeLayer layer];
      [_disabledUnderline setFrame:CGRectZero];
      [_disabledUnderline setStrokeColor:[MDCTextInputUnderlineColor() CGColor]];
      [_disabledUnderline setLineJoin:kCALineJoinMiter];
      [_disabledUnderline setLineDashPattern:@[ @1.5, @1.5 ]];
    }

    layerToAdd = _disabledUnderline;
  }

  [[self layer] addSublayer:layerToAdd];
  [self updateUnderlinePath];
}

- (void)updateColor {
  BOOL showUnderline = self.enabled;
  UIColor *backgroundColor = [UIColor clearColor];
  if (showUnderline) {
    backgroundColor = _color;
  }

  [self setBackgroundColor:backgroundColor];
  [self setOpaque:showUnderline];
}

#pragma mark - Property implementation

- (void)setColor:(UIColor *)color {
  _color = color;
  [self updateColor];
}

- (void)setEnabled:(BOOL)enabled {
  if (_enabled != enabled) {
    _enabled = enabled;
    [self updateUnderline];
    [self updateColor];
  }
}

@end
