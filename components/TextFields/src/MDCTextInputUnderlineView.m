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

static NSString *const MDCTextInputUnderlineColorKey = @"MDCTextInputUnderlineColorKey";
static NSString *const MDCTextInputUnderlineDisabledColorKey =
    @"MDCTextInputUnderlineDisabledColorKey";
static NSString *const MDCTextInputUnderlineEnabledKey = @"MDCTextInputUnderlineEnabledKey";
static NSString *const MDCTextInputUnderlineLineHeightKey = @"MDCTextInputUnderlineLineHeightKey";

static const CGFloat MDCTextInputUnderlineDefaultHeight = 1.f;

// TODO: (larche): Make disabled color parameterized?
static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

@interface MDCTextInputUnderlineView ()

@property(nonatomic, strong) CAShapeLayer *disabledUnderline;
@property(nonatomic, strong) CAShapeLayer *underline;

@end

@implementation MDCTextInputUnderlineView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCUnderlineViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCUnderlineViewInit];

    _color = [coder decodeObjectOfClass:[UIColor class] forKey:MDCTextInputUnderlineColorKey];
    _disabledColor =
        [coder decodeObjectOfClass:[UIColor class] forKey:MDCTextInputUnderlineDisabledColorKey];
    _enabled = [coder decodeBoolForKey:MDCTextInputUnderlineEnabledKey];
    _lineHeight = (CGFloat)[coder decodeFloatForKey:MDCTextInputUnderlineLineHeightKey];
  }
  return self;
}

- (void)commonMDCUnderlineViewInit {
  _color = MDCTextInputUnderlineColor();
  _disabledColor = MDCTextInputUnderlineColor();
  _enabled = YES;
  _lineHeight = MDCTextInputUnderlineDefaultHeight;

  [self setContentHuggingPriority:UILayoutPriorityDefaultHigh
                          forAxis:UILayoutConstraintAxisVertical];
  [self setClipsToBounds:NO];
  [self updateUnderline];
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:self.color forKey:MDCTextInputUnderlineColorKey];
  [coder encodeObject:self.disabledColor forKey:MDCTextInputUnderlineDisabledColorKey];
  [coder encodeBool:self.enabled forKey:MDCTextInputUnderlineEnabledKey];
  [coder encodeFloat:(float)self.lineHeight forKey:MDCTextInputUnderlineLineHeightKey];
}

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTextInputUnderlineView *copy = [[[self class] alloc] initWithFrame:self.frame];

  copy.color = self.color;
  copy.disabledColor = self.disabledColor;
  copy.enabled = self.enabled;
  copy.lineHeight = self.lineHeight;

  return copy;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateUnderlinePath];
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(UIViewNoIntrinsicMetric, self.lineHeight);
}

- (void)updateUnderlinePath {
  CGRect bounds = [self bounds];
  CGMutablePathRef path = CGPathCreateMutable();
  CGFloat offSet = 1.f / [UIScreen mainScreen].scale;
  CGPathMoveToPoint(path, NULL, CGRectGetMinX(bounds), CGRectGetMidY(bounds) + offSet);
  CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(bounds), CGRectGetMidY(bounds) + offSet);

  if (_underline) {
    _underline.frame = bounds;
    _underline.path = path;
  }

  if (_disabledUnderline) {
    _disabledUnderline.frame = bounds;
    _disabledUnderline.path = path;
  }
  CGPathRelease(path);
}

- (void)updateUnderline {
  if (_enabled) {
    if (!_underline) {
      _underline = [CAShapeLayer layer];
      _underline.contentsScale = [UIScreen mainScreen].scale;
      _underline.frame = CGRectZero;
      _underline.lineWidth = self.lineHeight;
      _underline.strokeColor = _color.CGColor;

      [self.layer addSublayer:_underline];
    }

    _disabledUnderline.opacity = 0.f;
  } else {
    if (!_disabledUnderline) {
      _disabledUnderline = [CAShapeLayer layer];
      _disabledUnderline.contentsScale = [UIScreen mainScreen].scale;
      _disabledUnderline.frame = CGRectZero;
      _disabledUnderline.lineJoin = kCALineJoinMiter;
      _disabledUnderline.lineDashPattern = @[ @1.5, @1.5 ];
      _disabledUnderline.lineWidth = 1.0;
      _disabledUnderline.opaque = NO;
      _disabledUnderline.strokeColor = _disabledColor.CGColor;
      [self.layer addSublayer:_disabledUnderline];
    }

    _disabledUnderline.opacity = 1.f;
  }

  _underline.lineWidth = self.lineHeight;

  [self updateUnderlinePath];
  [self updateColor];
}

- (void)updateColor {
  BOOL showUnderline = self.enabled;
  UIColor *strokeColor = [UIColor clearColor];
  if (showUnderline) {
    strokeColor = _color;
  }

  self.disabledUnderline.strokeColor = self.disabledColor.CGColor;
  self.underline.strokeColor = strokeColor.CGColor;
  self.opaque = showUnderline;
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

- (void)setLineHeight:(CGFloat)lineHeight {
  if (_lineHeight != lineHeight) {
    _lineHeight = lineHeight;
  }
  [self updateUnderline];
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
  return YES;
}

@end
