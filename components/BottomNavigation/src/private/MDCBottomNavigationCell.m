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
#import "MDCBottomNavigationCellBadge.h"

// The duration of the enter animation of the path cut, same as floating button enter animation.
//static const NSTimeInterval kMDCBottomNavigationCellEnterDuration = 0.270f;

// The duration of the exit animation of the path cut, same as floating button exit animation.
static const NSTimeInterval kMDCBottomNavigationCellTransitionDuration = 0.180f;

@interface MDCBottomNavigationCell ()

@property(nonatomic, strong) MDCBottomNavigationCellBadge *badge;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation MDCBottomNavigationCell

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
  _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self addSubview:_iconImageView];

  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.text = _title;
  _label.font = [UIFont systemFontOfSize:12];
  _label.textAlignment = NSTextAlignmentCenter;
  [self addSubview:_label];

  _badge = [[MDCBottomNavigationCellBadge alloc] init];
  [self addSubview:_badge];

  if (!_badgeValue) {
    _badge.hidden = YES;
  }

  _button = [[UIButton alloc] initWithFrame:self.bounds];
  _button.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self addSubview:_button];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 12);
  [self setSelected:self.selected];
}

- (void)setSelected:(BOOL)selected {
  _selected = selected;
  
  CGPoint iconImageViewCenter = CGPointZero;
  CGPoint badgeCenter = CGPointZero;
  CGPoint labelCenter =
      CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMidY(self.bounds) + CGRectGetHeight(self.bounds) * 0.25f);
  
  NSLog(@"%@", NSStringFromCGRect(self.iconImageView.frame));

  if (_selected) {
    self.label.hidden = NO;
    iconImageViewCenter =
        CGPointMake(CGRectGetMidX(self.bounds),
                    CGRectGetMidY(self.bounds) - CGRectGetHeight(self.bounds) * 0.1f);
    badgeCenter =
        CGPointMake(self.iconImageView.frame.origin.x + CGRectGetWidth(self.iconImageView.bounds),
                    iconImageViewCenter.y);
  } else {
    self.label.hidden = YES;
    iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    badgeCenter =
        CGPointMake(self.iconImageView.frame.origin.x + CGRectGetWidth(self.iconImageView.bounds),
                    iconImageViewCenter.y);
  }

  self.label.center = labelCenter;
  

  [UIView animateWithDuration:kMDCBottomNavigationCellTransitionDuration animations:^(void) {
    self.iconImageView.center = iconImageViewCenter;
    self.badge.center = badgeCenter;
  }];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  _badge.badgeColor = badgeColor;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  _badgeValue = badgeValue;
  _badge.text = badgeValue;
  if (!_badgeValue) {
    _badge.hidden = YES;
  } else {
    _badge.hidden = NO;
  }
}

- (void)setImage:(UIImage *)image {
  _image = image;
  [_iconImageView setImage:_image];
  [_iconImageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
  _title = title;
  _label.text = _title;
}

@end
