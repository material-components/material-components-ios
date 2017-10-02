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

#import "MDCBottomNavigationCell.h"

#import "MaterialMath.h"

@interface MDCBottomNavigationCellBadge : UIView

@property(nonatomic, copy) NSString *text;

@property(nonatomic, strong) CAShapeLayer *badgeLayer;
@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic) CGFloat badgeCircleWidth;
@property(nonatomic) CGFloat badgeCircleHeight;
@property(nonatomic) CGFloat xPadding;
@property(nonatomic) CGFloat yPadding;

@end

@implementation MDCBottomNavigationCellBadge

- (instancetype)initWithText:(NSString *)text {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _text = text;
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
  _countLabel.text = _text;
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
  [self sizeBadge];
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

- (void)sizeToFit {
  [super sizeToFit];
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

@interface MDCBottomNavigationCell ()

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) MDCBottomNavigationCellBadge *badge;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *badgeText;

@end

@implementation MDCBottomNavigationCell

- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                        image:(UIImage *)image
                    badgeText:(NSString *)badgeText {
  self = [super initWithFrame:frame];
  if (self) {
    _text = text;
    _image = image;
    _badgeText = badgeText;
    [self commonMDCBottomNavigationCellInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationCellInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationCellInit {
  self.backgroundColor = [UIColor whiteColor];
  self.iconImageView = [[UIImageView alloc] initWithImage:_image];
  [self addSubview:self.iconImageView];

  self.label = [[UILabel alloc] initWithFrame:CGRectZero];
  self.label.text = _text;
  self.label.font = [UIFont systemFontOfSize:12];
  self.label.textAlignment = NSTextAlignmentCenter;
  [self addSubview:self.label];

  
  self.badge = [[MDCBottomNavigationCellBadge alloc] initWithText:_badgeText];
  [self addSubview:self.badge];
  
  if (!_badgeText) {
    _badge.hidden = YES;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.iconImageView.center =
      CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds) - CGRectGetHeight(self.bounds) * 0.1f);
  self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 12);
  self.label.center =
      CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds) + CGRectGetHeight(self.bounds) * 0.25f);
  self.badge.center =
  CGPointMake(self.iconImageView.frame.origin.x + CGRectGetWidth(self.iconImageView.bounds),
              self.iconImageView.frame.origin.y);
}

- (void)setBadgeText:(NSString *)badgeText {
  _badgeText = badgeText;
  _badge.text = badgeText;
  if (!_badgeText) {
    _badge.hidden = YES;
  } else {
    _badge.hidden = NO;
  }
}

@end
