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

#import "MDCBottomNavigationItemBadge.h"

static const CGFloat kMDCBottomNavigationItemBadgeFontSize = 10.f;
static const CGFloat kMDCBottomNavigationItemBadgeXPadding = 8.f;
static const CGFloat kMDCBottomNavigationItemBadgeYPadding = 2.f;

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
    _badgeValueLabel.font = [UIFont systemFontOfSize:kMDCBottomNavigationItemBadgeFontSize];
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
  [self sizeBadge];
}

- (void)sizeBadge {
  [_badgeValueLabel sizeToFit];
  _xPadding = kMDCBottomNavigationItemBadgeXPadding;
  _yPadding = kMDCBottomNavigationItemBadgeYPadding;

  _badgeCircleWidth = CGRectGetWidth(_badgeValueLabel.bounds) + _xPadding;
  _badgeCircleHeight = CGRectGetHeight(_badgeValueLabel.bounds) + _yPadding;

  if (_badgeCircleWidth < _badgeCircleHeight) {
    _badgeCircleWidth = _badgeCircleHeight;
  }
  self.frame = CGRectMake(CGRectGetMinX(self.frame),
                          CGRectGetMinY(self.frame),
                          _badgeCircleWidth,
                          _badgeCircleHeight);
  self.badgeValueLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

  CGFloat badgeRadius = CGRectGetMidY(self.bounds);
  self.layer.cornerRadius = badgeRadius;
  self.layer.backgroundColor = self.badgeColor.CGColor;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  _badgeValue = badgeValue;
  _badgeValueLabel.text = badgeValue;
  [self setNeedsLayout];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  self.layer.backgroundColor = _badgeColor.CGColor;
}

@end
