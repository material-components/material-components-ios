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

@interface MDCTabBarViewItemView ()

@property(nonatomic, strong) UIView *contentView;
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

  CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsets);
  self.contentView.frame = contentFrame;

  CGSize iconSize = [self.iconImageView sizeThatFits:contentFrame.size];
  CGSize labelSize = [self.titleLabel sizeThatFits:contentFrame.size];
  CGFloat centerX = CGRectGetMidX(self.contentView.bounds);
  CGFloat labelCenterY = CGRectGetMaxY(self.contentView.bounds) - labelSize.height / 2;
  self.titleLabel.frame =
      CGRectMake(centerX - labelSize.width / 2, labelCenterY - labelSize.height / 2,
                 labelSize.width, labelSize.height);
  CGFloat iconCenterY = CGRectGetMinY(self.titleLabel.frame) / 2;
  self.iconImageView.frame =
      CGRectMake(centerX - iconSize.width / 2, iconCenterY - iconSize.height / 2, iconSize.width,
                 iconSize.height);
}

#pragma mark - UIAccessibility

#pragma mark - Private

- (void)initSubviews {
  if (!_contentView) {
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentView];
  }
  if (!_iconImageView) {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.isAccessibilityElement = NO;
    [self.contentView addSubview:self.iconImageView];
  }
  if (!_titleLabel) {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.isAccessibilityElement = NO;
    [self.contentView addSubview:self.titleLabel];
  }
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(kMaxWidth, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGFloat horizontalPadding = kEdgeInsets.left + kEdgeInsets.right;
  CGFloat verticalPadding = kEdgeInsets.top + kEdgeInsets.bottom;
  // The size of the content view should be smaller that the size passed in.
  size = CGSizeMake(size.width - horizontalPadding, size.height - verticalPadding);
  const CGFloat maxWidth = MIN(kMaxWidth, MAX(kMinWidth, size.width));
  const CGFloat maxHeight = MAX(kMinHeight, size.height);
  const CGSize maxSize = CGSizeMake(maxWidth, maxHeight);

  // Calculate the sizes of icon and label. Use them to calculate the total item view size.
  CGSize iconSize = [self.iconImageView sizeThatFits:maxSize];
  CGSize labelSize = [self.titleLabel sizeThatFits:maxSize];
  CGFloat width = MAX(iconSize.width, labelSize.width) + horizontalPadding;
  CGFloat height = iconSize.height + labelSize.height + verticalPadding;
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
