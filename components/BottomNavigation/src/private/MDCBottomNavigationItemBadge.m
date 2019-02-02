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
#import <CoreGraphics/CoreGraphics.h>

#import "MDCBottomNavigationItemBadge.h"

static const CGFloat kBadgeFontSize = 10;
// Given these padding values, a double-eight value produces a near circle.
// This matches the material.io guidelines article.
static const CGFloat kBadgeXPadding = 3;
static const CGFloat kBadgeYPadding = 4;
// For an empty badge, ensure that the size is close to the guidelines article.
static const CGFloat kMinDiameter = 9;

@implementation MDCBottomNavigationItemBadge

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationItemBadgeInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationItemBadgeInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationItemBadgeInit {
  if (!_badgeColor) {
    _badgeColor = [UIColor redColor];
  }
  self.layer.backgroundColor = _badgeColor.CGColor;

  if (self.subviews.count == 0) {
    _badgeValueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _badgeValueLabel.textColor = [UIColor whiteColor];
    _badgeValueLabel.font = [UIFont systemFontOfSize:kBadgeFontSize];
    _badgeValueLabel.textAlignment = NSTextAlignmentCenter;
    _badgeValueLabel.isAccessibilityElement = NO;
    _badgeValueLabel.text = _badgeValue;
    [self addSubview:_badgeValueLabel];
  } else {
    // Badge label was restored during -initWithCoder:
    _badgeValueLabel = self.subviews.firstObject;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect availableContentRect =
      CGRectStandardize(CGRectInset(self.bounds, kBadgeXPadding, kBadgeYPadding));
  CGSize labelFitSize = [self.badgeValueLabel sizeThatFits:availableContentRect.size];
  self.badgeValueLabel.bounds = CGRectMake(0, 0, labelFitSize.width, labelFitSize.height);

  self.badgeValueLabel.center =
      CGPointMake(CGRectGetMidX(availableContentRect), CGRectGetMidY(availableContentRect));

  CGFloat badgeRadius = CGRectGetMidY(self.bounds);
  self.layer.cornerRadius = badgeRadius;
  self.layer.backgroundColor = self.badgeColor.CGColor;
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (self.badgeValue == nil) {
    return CGSizeZero;
  }

  CGSize labelSize = [self.badgeValueLabel sizeThatFits:size];
  CGFloat badgeWidth = MAX(kMinDiameter, labelSize.width + kBadgeXPadding);
  CGFloat badgeHeight = MAX(kMinDiameter, labelSize.height + kBadgeYPadding);
  if (badgeWidth < badgeHeight) {
    badgeWidth = badgeHeight;
  }
  return CGSizeMake(badgeWidth, badgeHeight);
}

- (void)sizeToFit {
  CGSize fitSize = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  CGRect newBounds = CGRectMake(0, 0, fitSize.width, fitSize.height);
  self.bounds = newBounds;
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
