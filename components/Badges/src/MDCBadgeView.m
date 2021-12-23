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

#import "MDCBadgeAppearance.h"
// TODO(featherless): Remove the dependency on MDCPalette.
#import "MDCPalettes.h"

static const CGFloat kBadgeFontSize = 8;
static const CGFloat kBadgeYPadding = 2;
static const CGFloat kMinDiameter = 9;

// A note on layout considerations for the border.
//
// CALayer's borderColor and borderWidth properties will create an inner border, meaning the border
// will be drawn within the bounds of the view. This will, in effect, cause the content of the badge
// to be constrained by the border; this is rarely what is intended when it comes to badges.
//
// Instead, we want the border to be drawn on the outer edge of the badge. To do so, we "fake" an
// outer border by expanding the fitted size of the badge by the border width. We then use the same
// standard CALayer borderColor and borderWidth properties under the hood, but due to the expansion
// of the badge's size it gives the impression of being drawn on the outside of the border.
//
// To add an outer border, use borderColor and borderWidth instead of self.layer's equivalent
// properties. Using borderColor enables the color to react to trait collections, and modifying
// borderWidth invalidates size considerations.
//
// Note that adding an outer border will cause the badge's origin to effectively shift on both the x
// and y axis by `borderWidth` units. While technically accurate, it can be conceptually unexpected
// because the border is supposed to be on the outer edge of the view. To compensate for this, be
// sure to adjust your badge's x/y values by -borderWidth.

@implementation MDCBadgeView {
  UIColor *_Nullable _borderColor;
  UILabel *_Nonnull _label;
}

@synthesize appearance = _appearance;

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _appearance = [[MDCBadgeAppearance alloc] init];
    // TODO(featherless): Remove the dependency on MDCPalette.
    _appearance.backgroundColor = MDCPalette.redPalette.tint700;
    _appearance.textColor = [UIColor whiteColor];
    _appearance.font = [UIFont systemFontOfSize:kBadgeFontSize];

    _label = [[UILabel alloc] initWithFrame:self.bounds];
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
  if (_label.text == nil) {
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

  // CALayer borders are inset. To make them outset, we need to expand the size of our label to
  // account for the content covered by the border.
  const CGFloat borderWidth = self.layer.borderWidth;
  return CGSizeMake(badgeWidth + borderWidth * 2, badgeHeight + borderWidth * 2);
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (void)didMoveToWindow {
  [super didMoveToWindow];

  [self applyAppearance];
}

#pragma mark - Responding to appearance changes

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  [self updateFont];
  [self updateBorderColor];
}

- (void)updateFont {
  _label.font = [self fontForCurrentTraitCollection];
  [self setNeedsLayout];
  [self invalidateIntrinsicContentSize];
}

- (nullable UIFont *)fontForCurrentTraitCollection {
  if (@available(iOS 13, *)) {
    if (self.traitCollection.legibilityWeight == UILegibilityWeightBold) {
      return _appearance.boldFont ?: _appearance.font;
    }
  }
  return _appearance.font;
}

- (void)updateBorderColor {
  self.layer.borderColor = _borderColor.CGColor;
}

- (void)applyAppearance {
  BOOL intrinsicSizeAffected = NO;

  // Background
  self.backgroundColor = _appearance.backgroundColor ?: self.tintColor;

  // Content
  _label.textColor = _appearance.textColor;
  if (![_label.font isEqual:[self fontForCurrentTraitCollection]]) {
    [self updateFont];
    intrinsicSizeAffected = YES;
  }

  // Border
  if (self.layer.borderWidth != _appearance.borderWidth) {
    self.layer.borderWidth = _appearance.borderWidth;
    intrinsicSizeAffected = YES;
  }
  if (![_borderColor isEqual:_appearance.borderColor]) {
    _borderColor = _appearance.borderColor;
    [self updateBorderColor];
  }
  // When a CALayer has both a background color and a border, we need to clip the bounds otherwise
  // the layer's background color will bleed through on the outer edges of the border.
  self.clipsToBounds = _appearance.borderWidth > 0;

  if (intrinsicSizeAffected) {
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
  }
}

#pragma mark - Displaying a value in the badge

- (void)setText:(nullable NSString *)text {
  _label.text = text;
  [self setNeedsLayout];
  [self invalidateIntrinsicContentSize];
}

- (nullable NSString *)text {
  return _label.text;
}

#pragma mark - Configuring the badge's visual appearance

- (void)setAppearance:(nullable MDCBadgeAppearance *)appearance {
  if (appearance == _appearance) {
    return;
  }
  if (appearance) {
    _appearance = [appearance copy];
  } else {
    _appearance = [[MDCBadgeAppearance alloc] init];
  }

  [self applyAppearance];
}

- (nonnull MDCBadgeAppearance *)appearance {
  // Ensure that the appearance can't be directly modified once assigned.
  return [_appearance copy];
}

@end
