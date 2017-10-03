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

#import "MDCBottomNavigationCellBadge.h"

#import "MaterialMath.h"

@implementation MDCBottomNavigationCellBadge

- (instancetype)init {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    [self commonInitMDCBottomNavigationCellBadge];
  }
  return self;
}

- (void)commonInitMDCBottomNavigationCellBadge {
  _badgeLayer = [CAShapeLayer layer];
  _badgeLayer.fillColor = [UIColor redColor].CGColor;
  [self.layer addSublayer:_badgeLayer];

  _countLabel = [[UILabel alloc] initWithFrame:self.bounds];
  _countLabel.textColor = [UIColor whiteColor];
  _countLabel.font = [UIFont systemFontOfSize:10];
  _countLabel.textAlignment = NSTextAlignmentCenter;
  [self addSubview:_countLabel];
  [self sizeBadge];
}

- (void)sizeBadge {
  [_countLabel sizeToFit];
  _xPadding = 6.f;
  _yPadding = 2.f;

  _badgeCircleWidth = _countLabel.bounds.size.width + _xPadding;
  _badgeCircleHeight = _countLabel.bounds.size.height + _yPadding;

  if (_badgeCircleWidth < _badgeCircleHeight) {
    _badgeCircleWidth = _badgeCircleHeight;
  }
  self.frame = CGRectMake(self.frame.origin.x,
                          self.frame.origin.y,
                          _badgeCircleWidth,
                          _badgeCircleHeight);
}

- (void)setText:(NSString *)text {
  _text = text;
  _countLabel.text = _text;
  [self sizeBadge];
  [self drawBadge];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self drawBadge];
}

- (void)drawBadge {

  self.countLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

  CGFloat badgeRadius = CGRectGetMidY(self.bounds);
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGFloat startAngle = MDCDegreesToRadians(-90);
  CGFloat endAngle = MDCDegreesToRadians(90);

  [path moveToPoint:CGPointMake(badgeRadius, badgeRadius)];
  CGPoint centerPath = CGPointMake(badgeRadius, badgeRadius);
  [path addArcWithCenter:centerPath
                  radius:badgeRadius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:NO];

  CGFloat rectWidth = CGRectGetWidth(self.bounds) - badgeRadius;
  [path addLineToPoint:CGPointMake(badgeRadius, CGRectGetHeight(self.bounds))];
  [path addLineToPoint:CGPointMake(rectWidth, CGRectGetHeight(self.bounds))];

  CGFloat startAngle2 = MDCDegreesToRadians(90);
  CGFloat endAngle2 = MDCDegreesToRadians(-90);

  CGPoint centerPath2 = CGPointMake(rectWidth, badgeRadius);
  [path addArcWithCenter:centerPath2
                  radius:badgeRadius
              startAngle:startAngle2
                endAngle:endAngle2
               clockwise:NO];

  [path addLineToPoint:CGPointMake(rectWidth, 0)];
  [path addLineToPoint:CGPointMake(badgeRadius, 0)];

  [path closePath];
  self.badgeLayer.path = path.CGPath;
}

- (CGSize)sizeForText:(NSString *)text
                 font:(UIFont *)font
     boundingRectSize:(CGSize)boundingRectSize {
  CGRect rect = [text boundingRectWithSize:boundingRectSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{ NSFontAttributeName:font }
                                   context:nil];
  return rect.size;
}

@end
