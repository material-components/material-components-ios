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

/** The minimum height of any item view with only a title or image (not both). */
static const CGFloat kMinHeightTitleOrImageOnly = 48;

/** The minimum height of any item view with both a title and image. */
static const CGFloat kMinHeightTitleAndImage = 72;

/** The vertical padding between the image view and the title label. */
static const CGFloat kImageTitlePadding = 3;

/// Outer edge padding from spec: https://material.io/go/design-tabs#spec.
static const UIEdgeInsets kEdgeInsets = {.top = 12, .right = 16, .bottom = 12, .left = 16};

/**
 Edge insets for text-only Tabs. Although top and bottom are not specified, we insert some
 minimal (8 points) padding so things don't look awful.
 */
static const UIEdgeInsets kEdgeInsetsTextOnly = {.top = 8, .right = 16, .bottom = 8, .left = 16};

@interface MDCTabBarViewItemView ()

@property(nonatomic, strong) UIView *contentView;

@end

@implementation MDCTabBarViewItemView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.isAccessibilityElement = YES;

    // Create initial subviews
    [self commonMDCTabBarViewItemViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.isAccessibilityElement = YES;

    // Create initial subviews
    [self commonMDCTabBarViewItemViewInit];
  }
  return self;
}

- (void)commonMDCTabBarViewItemViewInit {
  // Make sure the ripple is positioned behind the content.
  if (!_rippleTouchController) {
    _rippleTouchController = [[MDCRippleTouchController alloc] initWithView:self];
  }
  if (!_contentView) {
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_contentView];
  }
  if (!_iconImageView) {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _iconImageView.isAccessibilityElement = NO;
    [_contentView addSubview:_iconImageView];
  }
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    _titleLabel.isAccessibilityElement = NO;
    [_contentView addSubview:_titleLabel];
  }
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.titleLabel.text && !self.iconImageView.image) {
    [self layoutSubviewsTextOnly];
    return;
  }
  CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsets);
  self.contentView.frame = contentFrame;

  CGSize iconSize = [self.iconImageView sizeThatFits:contentFrame.size];
  CGSize labelSize = [self.titleLabel sizeThatFits:contentFrame.size];
  CGFloat centerX = CGRectGetMidX(self.contentView.bounds);
  CGFloat labelCenterY = CGRectGetMidY(self.contentView.bounds);
  CGFloat iconCenterY = CGRectGetMidY(self.contentView.bounds);

  if (iconSize.height != 0 && labelSize.height != 0) {
    CGFloat verticalPadding = (CGRectGetHeight(self.contentView.bounds) - iconSize.height -
                               labelSize.height - kImageTitlePadding) /
                              2;
    labelCenterY = CGRectGetMaxY(self.contentView.bounds) - verticalPadding - labelSize.height / 2;
    iconCenterY = verticalPadding + iconSize.height / 2;
  }
  self.titleLabel.frame =
      CGRectMake(centerX - labelSize.width / 2, labelCenterY - labelSize.height / 2,
                 labelSize.width, labelSize.height);
  self.iconImageView.frame =
      CGRectMake(centerX - iconSize.width / 2, iconCenterY - iconSize.height / 2, iconSize.width,
                 iconSize.height);
}

- (void)layoutSubviewsTextOnly {
  CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsetsTextOnly);
  self.contentView.frame = contentFrame;

  CGSize contentSize =
      CGSizeMake(CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
  CGSize labelWidthFitSize = [self.titleLabel sizeThatFits:contentSize];
  CGSize labelSize =
      CGSizeMake(contentSize.width, MIN(contentSize.height, labelWidthFitSize.height));
  self.titleLabel.bounds = CGRectMake(0, 0, labelSize.width, labelSize.height);
  self.titleLabel.center =
      CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds));
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(kMaxWidth, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (self.titleLabel.text && !self.iconImageView.image) {
    return [self sizeThatFitsTextOnly:size];
  }
  NSString *title = self.titleLabel.text;
  UIImage *icon = self.iconImageView.image;
  BOOL hasMultipleContents = title && title.length > 0 && icon;
  const CGFloat minHeight =
      hasMultipleContents ? kMinHeightTitleAndImage : kMinHeightTitleOrImageOnly;
  const CGFloat maxHeight = MAX(minHeight, size.height);

  const CGFloat horizontalPadding = kEdgeInsets.left + kEdgeInsets.right;
  const CGFloat verticalPadding = kEdgeInsets.top + kEdgeInsets.bottom;
  CGSize maxSize = CGSizeMake(kMaxWidth - horizontalPadding, maxHeight - verticalPadding);

  // Calculate the sizes of icon and label. Use them to calculate the total item view size.
  CGSize iconSize = [self.iconImageView sizeThatFits:maxSize];
  maxSize = CGSizeMake(maxSize.width, maxSize.height - iconSize.height);
  CGSize labelSize = [self.titleLabel sizeThatFits:maxSize];
  CGFloat width = (CGFloat)ceil(MAX(iconSize.width, labelSize.width) + horizontalPadding);
  width = MIN(kMaxWidth, MAX(kMinWidth, width));
  CGFloat height = (CGFloat)ceil(iconSize.height + labelSize.height + verticalPadding);
  height += hasMultipleContents ? kImageTitlePadding : 0;
  height = MAX(minHeight, height);
  return CGSizeMake(width, height);
}

- (CGSize)sizeThatFitsTextOnly:(CGSize)size {
  CGSize maxSize =
      CGSizeMake(kMaxWidth - kEdgeInsetsTextOnly.left - kEdgeInsetsTextOnly.right, CGFLOAT_MAX);
  CGSize labelSize = [self.titleLabel sizeThatFits:maxSize];
  return CGSizeMake(labelSize.width + kEdgeInsetsTextOnly.left + kEdgeInsetsTextOnly.right,
                    MAX(kMinHeightTitleOrImageOnly,
                        labelSize.height + kEdgeInsetsTextOnly.top + kEdgeInsetsTextOnly.bottom));
}

#pragma mark - UIAccessibility

- (NSString *)accessibilityLabel {
  return [super accessibilityLabel] ?: self.titleLabel.text;
}

@end
