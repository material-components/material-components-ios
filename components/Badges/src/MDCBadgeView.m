// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBadgeView.h"

#import <CoreGraphics/CoreGraphics.h>

// TODO(featherless): Remove the dependency on MDCPalette.
#import "MDCPalettes.h"

// This is very close to the material.io guidelines article considering the fonts differ.
static const CGFloat kBadgeFontSize = 8;
// These padding values get pretty close to the material.io guidelines article.
static const CGFloat kBadgeYPadding = 2;
// For an empty badge, ensure that the size is close to the guidelines article.
static const CGFloat kMinDiameter = 9;

@implementation MDCBadgeView {
  UILabel *_Nonnull _label;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // TODO(featherless): Remove the dependency on MDCPalette.
    self.backgroundColor = MDCPalette.redPalette.tint700;

    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:kBadgeFontSize];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.isAccessibilityElement = NO;
    [self addSubview:_label];
  }
  return self;
}

- (CGFloat)badgeXPaddingForRadius:(CGFloat)radius {
  CGFloat badgeXPadding = (CGFloat)(sin(M_PI_4) * (radius));  // sin(ø) = badgeXPadding / radius
  badgeXPadding += 1;  // Extra point to ensure some background extends beyond the label.
  // Align to the nearest pixel
  badgeXPadding = round(badgeXPadding * self.contentScaleFactor) / self.contentScaleFactor;

  return badgeXPadding;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat badgeRadius = CGRectGetHeight(self.bounds) / 2;
  CGRect availableContentRect = CGRectStandardize(
      CGRectInset(self.bounds, [self badgeXPaddingForRadius:badgeRadius], kBadgeYPadding));
  CGSize labelFitSize = [_label sizeThatFits:availableContentRect.size];
  _label.bounds = CGRectMake(0, 0, labelFitSize.width, labelFitSize.height);
  _label.center =
      CGPointMake(CGRectGetMidX(availableContentRect), CGRectGetMidY(availableContentRect));
  self.layer.cornerRadius = badgeRadius;
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (self.text == nil) {
    return CGSizeZero;
  }

  // Calculate the badge and label heights
  CGSize labelSize = [_label sizeThatFits:size];
  CGFloat badgeHeight = labelSize.height + kBadgeYPadding;
  CGFloat contentXPadding = [self badgeXPaddingForRadius:badgeHeight / 2];
  CGFloat badgeWidth = labelSize.width + contentXPadding;
  badgeWidth = MAX(kMinDiameter, badgeWidth);
  badgeHeight = MAX(kMinDiameter, badgeHeight);
  if (badgeWidth < badgeHeight) {
    badgeWidth = badgeHeight;
  }
  return CGSizeMake(badgeWidth, badgeHeight);
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

#pragma mark - Public APIs

- (void)setText:(nullable NSString *)text {
  _label.text = text;
  [self setNeedsLayout];
  [self invalidateIntrinsicContentSize];
}

- (nullable NSString *)text {
  return _label.text;
}

- (void)setTextColor:(nullable UIColor *)textColor {
  _label.textColor = textColor;
}

- (nonnull UIColor *)textColor {
  return _label.textColor;
}

- (void)setFont:(nullable UIFont *)font {
  _label.font = font;
  [self setNeedsLayout];
  [self invalidateIntrinsicContentSize];
}

- (nonnull UIFont *)font {
  return _label.font;
}

@end
