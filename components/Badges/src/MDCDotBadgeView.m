// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCDotBadgeView.h"

#import "MDCDotBadgeAppearance.h"

#import <QuartzCore/QuartzCore.h>

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

@implementation MDCDotBadgeView {
  UIColor *_Nullable _borderColor;
  CGFloat _innerRadius;
}

@synthesize appearance = _appearance;

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _appearance = [[MDCDotBadgeAppearance alloc] init];

    // CALayer's background color will bleed through the outer edges of its border, unless
    // clipsToBounds is enabled *and* there is at least one text layer with a non-zero frame.
    // We don't have a label on this view, so we create an empty CATextLayer and assign it a
    // non-zero frame.
    CALayer *childLayer = [CATextLayer layer];
    childLayer.frame = CGRectMake(0, 0, 1, 1);
    [self.layer addSublayer:childLayer];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
}

- (CGSize)sizeThatFits:(CGSize)size {
  const CGFloat squareDimension = (_innerRadius + self.layer.borderWidth) * 2;
  return CGSizeMake(squareDimension, squareDimension);
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

  [self updateBorderColor];
}

- (void)updateBorderColor {
  self.layer.borderColor = _borderColor.CGColor;
}

- (void)applyAppearance {
  BOOL intrinsicSizeAffected = NO;

  // Background
  self.backgroundColor = _appearance.backgroundColor ?: self.tintColor;

  // Layout
  if (_innerRadius != _appearance.innerRadius) {
    _innerRadius = _appearance.innerRadius;
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

#pragma mark - Configuring the badge's visual appearance

- (void)setAppearance:(nullable MDCDotBadgeAppearance *)appearance {
  if (appearance == _appearance) {
    return;
  }
  if (appearance) {
    _appearance = [appearance copy];
  } else {
    _appearance = [[MDCDotBadgeAppearance alloc] init];
  }

  [self applyAppearance];
}

- (nonnull MDCDotBadgeAppearance *)appearance {
  // Ensure that the appearance can't be directly modified once assigned.
  return [_appearance copy];
}

@end
