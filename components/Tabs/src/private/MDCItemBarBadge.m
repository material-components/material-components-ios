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
#import "MDCItemBarBadge.h"

#import <CoreGraphics/CoreGraphics.h>

#import "MaterialPalettes.h"

// This is very close to the material.io guidelines article considering the fonts differ.
static const CGFloat kBadgeFontSize = 12;
// These padding values get pretty close to the material.io guidelines article.
static const CGFloat kBadgeYPadding = 2;
// For an empty badge, ensure that the size is close to the guidelines article.
static const CGFloat kMinDiameter = 9;

@implementation MDCItemBarBadge

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCTabBarItemBadgeInit];
  }
  return self;
}

- (void)commonMDCTabBarItemBadgeInit {
  if (!_badgeColor) {
    _badgeColor = MDCPalette.redPalette.tint700;
  }
  self.layer.backgroundColor = _badgeColor.CGColor;

  _badgeValueLabel = [[UILabel alloc] initWithFrame:self.bounds];
  _badgeValueLabel.textColor = [UIColor whiteColor];
  _badgeValueLabel.font = [UIFont systemFontOfSize:kBadgeFontSize];
  _badgeValueLabel.textAlignment = NSTextAlignmentCenter;
  _badgeValueLabel.isAccessibilityElement = NO;
  _badgeValueLabel.text = _badgeValue;
  [self addSubview:_badgeValueLabel];
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
  CGSize labelFitSize = [self.badgeValueLabel sizeThatFits:availableContentRect.size];
  self.badgeValueLabel.bounds = CGRectMake(0, 0, labelFitSize.width, labelFitSize.height);
  self.badgeValueLabel.center =
      CGPointMake(CGRectGetMidX(availableContentRect), CGRectGetMidY(availableContentRect));
  self.layer.cornerRadius = badgeRadius;
  self.layer.backgroundColor = self.badgeColor.CGColor;
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (self.badgeValue == nil) {
    return CGSizeZero;
  }

  // Calculate the badge and label heights
  CGSize labelSize = [self.badgeValueLabel sizeThatFits:size];
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

- (void)setBadgeValue:(NSString *)badgeValue {
  _badgeValue = badgeValue;
  self.badgeValueLabel.text = badgeValue;
  [self setNeedsLayout];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  self.layer.backgroundColor = _badgeColor.CGColor;
}

@end
