/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCBottomNavigationItemBadge.h"
#import "MaterialMath.h"

static const CGFloat kMDCBottomNavigationItemBadgeAngle = 90.f;
static const CGFloat kMDCBottomNavigationItemBadgeFontSize = 10.f;
static const CGFloat kMDCBottomNavigationItemBadgeXPadding = 8.f;
static const CGFloat kMDCBottomNavigationItemBadgeYPadding = 2.f;

@implementation MDCBottomNavigationItemBadge

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInitMDCBottomNavigationItemBadge];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInitMDCBottomNavigationItemBadge];
  }
  return self;
}

- (void)commonInitMDCBottomNavigationItemBadge {
  _badgeColor = [UIColor redColor];
  _badgeLayer = [CAShapeLayer layer];
  _badgeLayer.fillColor = _badgeColor.CGColor;
  [self.layer addSublayer:_badgeLayer];

  _badgeValueLabel = [[UILabel alloc] initWithFrame:self.bounds];
  _badgeValueLabel.textColor = [UIColor whiteColor];
  _badgeValueLabel.font = [UIFont systemFontOfSize:kMDCBottomNavigationItemBadgeFontSize];
  _badgeValueLabel.textAlignment = NSTextAlignmentCenter;
  [self addSubview:_badgeValueLabel];
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
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGFloat startAngleLeftSide = MDCDegreesToRadians(-kMDCBottomNavigationItemBadgeAngle);
  CGFloat endAngleLeftSide = MDCDegreesToRadians(kMDCBottomNavigationItemBadgeAngle);

  [path moveToPoint:CGPointMake(badgeRadius, badgeRadius)];
  CGPoint centerPathLeftSide = CGPointMake(badgeRadius, badgeRadius);
  [path addArcWithCenter:centerPathLeftSide
                  radius:badgeRadius
              startAngle:startAngleLeftSide
                endAngle:endAngleLeftSide
               clockwise:NO];

  CGFloat rectWidth = CGRectGetWidth(self.bounds) - badgeRadius;
  [path addLineToPoint:CGPointMake(badgeRadius, CGRectGetHeight(self.bounds))];
  [path addLineToPoint:CGPointMake(rectWidth, CGRectGetHeight(self.bounds))];

  CGFloat startAngleRightSide = MDCDegreesToRadians(kMDCBottomNavigationItemBadgeAngle);
  CGFloat endAngleRightSide = MDCDegreesToRadians(-kMDCBottomNavigationItemBadgeAngle);

  CGPoint centerPathRightSide = CGPointMake(rectWidth, badgeRadius);
  [path addArcWithCenter:centerPathRightSide
                  radius:badgeRadius
              startAngle:startAngleRightSide
                endAngle:endAngleRightSide
               clockwise:NO];

  [path addLineToPoint:CGPointMake(rectWidth, 0)];
  [path addLineToPoint:CGPointMake(badgeRadius, 0)];

  [path closePath];
  self.badgeLayer.path = path.CGPath;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  _badgeValue = badgeValue;
  _badgeValueLabel.text = badgeValue;
  [self setNeedsLayout];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  _badgeLayer.fillColor = _badgeColor.CGColor;
}

@end
