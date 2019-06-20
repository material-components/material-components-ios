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

#import "MDCTabBarViewItemView.h"

/** The minimum width of any item view. */
static const CGFloat kMinWidth = 90;

/** The maximum width of any item view. */
static const CGFloat kMaxWidth = 360;

/** The minimum height of any item view. */
static const CGFloat kMinHeight = 48;

/// Outer edge padding from spec: https://material.io/go/design-tabs#spec.
static const UIEdgeInsets kEdgeInsets = {.top = 12, .right = 16, .bottom = 12, .left = 16};

/// File name of the bundle (without the '.bundle' extension) containing resources.
static NSString *const kResourceBundleName = @"MaterialTabs";

/// String table name containing localized strings.
static NSString *const kStringTableName = @"MaterialTabs";

/// Scale factor applied to the title of bottom navigation items when selected.
const CGFloat kSelectedNavigationTitleScaleFactor = (16.0f / 14.0f);

/// Vertical translation applied to image components bottom navigation items when selected.
const CGFloat kSelectedNavigationImageYOffset = -2;

@interface MDCTabBarViewItemView ()

@property(nonatomic, strong) UIStackView *contentView;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation MDCTabBarViewItemView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _title = @"";

    self.isAccessibilityElement = YES;

    // Create initial subviews
    [self initSubviews];
  }
  return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect contentBounds = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsets);
  self.contentView.frame = contentBounds;
}

#pragma mark - UIAccessibility

#pragma mark - Private

- (void)initSubviews {
  if (!_contentView) {
    _contentView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _contentView.axis = UILayoutConstraintAxisVertical;
    _contentView.alignment = UIStackViewAlignmentCenter;
    _contentView.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:_contentView];
  }
  if (!_iconImageView) {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _iconImageView.isAccessibilityElement = NO;
    [_contentView addArrangedSubview:_iconImageView];
  }
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    _titleLabel.isAccessibilityElement = NO;
    [_contentView addArrangedSubview:_titleLabel];
  }
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(kMinWidth, kMinHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
  const CGFloat width = MIN(kMaxWidth, MAX(kMinWidth, size.width));
  const CGFloat height = MAX(kMinHeight, size.height);
  return CGSizeMake(width, height);
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  self.titleLabel.text = _title;
  [self setNeedsLayout];
}

- (void)setImage:(nullable UIImage *)image {
  _image = image;
  self.iconImageView.image = _image;
  [self setNeedsLayout];
}

@end
