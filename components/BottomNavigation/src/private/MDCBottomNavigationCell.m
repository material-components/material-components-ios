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

@interface MDCBottomNavigationCell ()

@property(nonatomic, strong) MDCBottomNavigationCellBadge *badge;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation MDCBottomNavigationCell

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image {
  self = [super initWithFrame:frame];
  if (self) {
    _title = title;
    _image = image;
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
  _iconImageView = [[UIImageView alloc] initWithImage:_image];
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
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 12);
  if (self.selected) {
    self.label.hidden = NO;
    self.iconImageView.center =
        CGPointMake(CGRectGetMidX(self.bounds),
                    CGRectGetMidY(self.bounds) - CGRectGetHeight(self.bounds) * 0.1f);
    self.label.center =
        CGPointMake(CGRectGetMidX(self.bounds),
                    CGRectGetMidY(self.bounds) + CGRectGetHeight(self.bounds) * 0.25f);
    self.badge.center =
        CGPointMake(self.iconImageView.frame.origin.x + CGRectGetWidth(self.iconImageView.bounds),
                    self.iconImageView.frame.origin.y);
  } else {
    self.label.hidden = YES;
    self.iconImageView.center =
        CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.badge.center =
        CGPointMake(self.iconImageView.frame.origin.x + CGRectGetWidth(self.iconImageView.bounds),
                    self.iconImageView.frame.origin.y);
  }
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

- (void)setTitle:(NSString *)title {
  _title = title;
  _label.text = _title;
}

@end
