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

#import <CoreGraphics/CoreGraphics.h>

#import "MaterialMath.h"

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
static const UIEdgeInsets kEdgeInsetsTextAndImage = {
    .top = 12, .right = 16, .bottom = 12, .left = 16};

/**
 Edge insets for text-only Tabs. Although top and bottom are not specified, we insert some
 minimal (8 points) padding so things don't look awful.
 */
static const UIEdgeInsets kEdgeInsetsTextOnly = {.top = 8, .right = 16, .bottom = 8, .left = 16};

/** Edge insets for image-only Tabs. */
static const UIEdgeInsets kEdgeInsetsImageOnly = {.top = 12, .right = 16, .bottom = 12, .left = 16};

@interface MDCTabBarViewItemView ()

/** Indicates the selection status of this item view. */
@property(nonatomic, assign, getter=isSelected) BOOL selected;

@end

@implementation MDCTabBarViewItemView

@synthesize selectedImage = _selectedImage;

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
  if (!_iconImageView) {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _iconImageView.isAccessibilityElement = NO;
    [self addSubview:_iconImageView];
  }
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    _titleLabel.isAccessibilityElement = NO;
    [self addSubview:_titleLabel];
  }
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  if (!self.titleLabel.text.length && !self.iconImageView.image) {
    return;
  }

  if (self.titleLabel.text.length && !self.iconImageView.image) {
    self.titleLabel.frame = [self titleLabelFrameForTitleOnlyLayout];
    return;
  } else if (!self.titleLabel.text.length && self.iconImageView.image) {
    self.iconImageView.frame = [self iconImageViewFrameForImageOnlyLayout];
    return;
  } else {
    CGRect titleLabelFrame = CGRectZero;
    CGRect iconImageViewFrame = CGRectZero;
    [self layoutTitleLabelFrame:&titleLabelFrame iconImageViewFrame:&iconImageViewFrame];
    self.titleLabel.frame = titleLabelFrame;
    self.iconImageView.frame = iconImageViewFrame;
  }
}

- (CGRect)titleLabelFrameForTitleOnlyLayout {
  CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsetsTextOnly);

  CGSize contentSize = CGSizeMake(CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  CGSize labelWidthFitSize = [self.titleLabel sizeThatFits:contentSize];
  CGSize labelSize = CGSizeMake(MIN(contentSize.width, labelWidthFitSize.width),
                                MIN(contentSize.height, labelWidthFitSize.height));
  // The label attempted to be taller than allowed by the content insets. Give it the full content
  // width available.
  if (labelWidthFitSize.height > contentSize.height) {
    labelSize = CGSizeMake(contentSize.width, labelSize.height);
  }
  CGRect labelFrame = CGRectMake(CGRectGetMidX(contentFrame) - (labelSize.width / 2),
                                 CGRectGetMidY(contentFrame) - (labelSize.height / 2),
                                 labelSize.width, labelSize.height);
  return MDCRectAlignToScale(labelFrame, self.window.screen.scale);
}

- (CGRect)iconImageViewFrameForImageOnlyLayout {
  CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsetsImageOnly);

  CGSize contentSize = CGSizeMake(CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  CGSize imageIntrinsicContentSize = self.iconImageView.intrinsicContentSize;
  CGSize imageFinalSize = CGSizeMake(MIN(contentSize.width, imageIntrinsicContentSize.width),
                                     MIN(contentSize.height, imageIntrinsicContentSize.height));
  CGRect imageViewFrame = CGRectMake(CGRectGetMidX(contentFrame) - (imageFinalSize.width / 2),
                                     CGRectGetMidY(contentFrame) - (imageFinalSize.height / 2),
                                     imageFinalSize.width, imageFinalSize.height);
  return MDCRectAlignToScale(imageViewFrame, self.window.screen.scale);
}

- (void)layoutTitleLabelFrame:(CGRect *)titleLabelFrame
           iconImageViewFrame:(CGRect *)iconImageViewFrame {
  CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsetsTextAndImage);

  CGSize contentSize = CGSizeMake(CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  CGSize labelSingleLineSize = self.titleLabel.intrinsicContentSize;
  CGSize availableIconSize = CGSizeMake(
      contentSize.width, contentSize.height - (kImageTitlePadding + labelSingleLineSize.height));

  // Position the image, limiting it so that at least 1 line of text remains.
  CGSize imageIntrinsicContentSize = self.iconImageView.intrinsicContentSize;
  CGSize imageFinalSize =
      CGSizeMake(MIN(imageIntrinsicContentSize.width, availableIconSize.width),
                 MIN(imageIntrinsicContentSize.height, availableIconSize.height));
  CGRect imageViewFrame =
      CGRectMake(CGRectGetMidX(contentFrame) - (imageFinalSize.width / 2),
                 CGRectGetMinY(contentFrame), imageFinalSize.width, imageFinalSize.height);
  imageViewFrame = MDCRectAlignToScale(imageViewFrame, self.window.screen.scale);
  if (iconImageViewFrame != NULL) {
    *iconImageViewFrame = imageViewFrame;
  }

  if (titleLabelFrame == NULL) {
    return;
  }

  // Now position the label from the bottom.
  CGSize availableLabelSize =
      CGSizeMake(contentSize.width,
                 contentSize.height - (CGRectGetHeight(imageViewFrame) + kImageTitlePadding));
  CGSize finalLabelSize = [self.titleLabel sizeThatFits:availableLabelSize];
  CGRect titleFrame = CGRectMake(CGRectGetMidX(contentFrame) - (finalLabelSize.width / 2),
                                 CGRectGetMaxY(contentFrame) - finalLabelSize.height,
                                 finalLabelSize.width, finalLabelSize.height);
  titleFrame = MDCRectAlignToScale(titleFrame, self.window.screen.scale);
  *titleLabelFrame = titleFrame;
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(kMaxWidth, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (!self.titleLabel.text.length && !self.iconImageView.image) {
    return CGSizeMake(kMinWidth, kMinHeightTitleOrImageOnly);
  }
  if (self.titleLabel.text.length && !self.iconImageView.image) {
    return [self sizeThatFitsTextOnly:size];
  } else if (!self.titleLabel.text.length && self.iconImageView.image) {
    return [self sizeThatFitsImageOnly:size];
  }
  return [self sizeThatFitsTextAndImage:size];
}

- (CGSize)sizeThatFitsTextOnly:(CGSize)size {
  CGSize maxSize =
      CGSizeMake(kMaxWidth - (kEdgeInsetsTextOnly.left + kEdgeInsetsTextOnly.right), CGFLOAT_MAX);
  CGSize labelSize = [self.titleLabel sizeThatFits:maxSize];
  return CGSizeMake(
      MAX(kMinWidth, labelSize.width + kEdgeInsetsTextOnly.left + kEdgeInsetsTextOnly.right),
      MAX(kMinHeightTitleOrImageOnly,
          labelSize.height + kEdgeInsetsTextOnly.top + kEdgeInsetsTextOnly.bottom));
}

- (CGSize)sizeThatFitsImageOnly:(CGSize)size {
  CGSize imageIntrinsicContentSize = self.iconImageView.intrinsicContentSize;
  return CGSizeMake(
      MAX(kMinWidth, MIN(kMaxWidth, imageIntrinsicContentSize.width + kEdgeInsetsImageOnly.left +
                                        kEdgeInsetsImageOnly.right)),
      MAX(kMinHeightTitleOrImageOnly, imageIntrinsicContentSize.height + kEdgeInsetsImageOnly.top +
                                          kEdgeInsetsImageOnly.bottom));
}

- (CGSize)sizeThatFitsTextAndImage:(CGSize)size {
  CGSize maxSize = CGSizeMake(
      kMaxWidth - (kEdgeInsetsTextAndImage.left + kEdgeInsetsTextAndImage.right), CGFLOAT_MAX);
  CGSize labelFitSize = [self.titleLabel sizeThatFits:maxSize];
  CGSize imageFitSize = self.iconImageView.intrinsicContentSize;
  return CGSizeMake(MAX(kMinWidth, MIN(kMaxWidth, kEdgeInsetsTextAndImage.left +
                                                      MAX(imageFitSize.width, labelFitSize.width) +
                                                      kEdgeInsetsTextAndImage.right)),
                    MAX(kMinHeightTitleAndImage, kEdgeInsetsTextAndImage.top + imageFitSize.height +
                                                     kImageTitlePadding + labelFitSize.height +
                                                     kEdgeInsetsTextAndImage.bottom));
}

#pragma mark - MDCTabBarViewItemView properties

- (void)setImage:(UIImage *)image {
  _image = image;
  self.iconImageView.image = self.selected ? self.selectedImage : self.image;
  [self setNeedsLayout];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
  _selectedImage = selectedImage;
  self.iconImageView.image = self.selected ? self.selectedImage : self.image;
  [self setNeedsLayout];
}

- (UIImage *)selectedImage {
  return _selectedImage ?: self.image;
}

#pragma mark - UIAccessibility

- (NSString *)accessibilityLabel {
  return [super accessibilityLabel] ?: self.titleLabel.text;
}

#pragma mark - MDCTabBarViewCustomViewable

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  // TODO(https://github.com/material-components/material-components-ios/issues/7801): Add
  // item view support for selection.
  void (^animationBlock)(void) = ^{
    self->_selected = selected;
    if (selected) {
      self.iconImageView.image = self.selectedImage ?: self.image;
    } else {
      self.iconImageView.image = self.image;
    }
  };

  if (animated) {
    [UIView animateWithDuration:0.3 animations:animationBlock];
  } else {
    animationBlock();
  }

  // TODO(https://github.com/material-components/material-components-ios/issues/7798): Switch to
  // using the selected image.
}

- (CGRect)contentFrame {
  if (!self.iconImageView.image) {
    if (self.titleLabel.text.length) {
      return [self contentFrameForTitleOnlyLayout];
    }
    return CGRectZero;
  }
  if (self.titleLabel.text.length) {
    return [self contentFrameForTitleAndImageLayout];
  }
  return [self contentFrameForImageOnlyLayout];
}

- (CGRect)contentFrameForTitleOnlyLayout {
  return [self titleLabelFrameForTitleOnlyLayout];
}

- (CGRect)contentFrameForImageOnlyLayout {
  return [self iconImageViewFrameForImageOnlyLayout];
}

- (CGRect)contentFrameForTitleAndImageLayout {
  CGRect titleLabelFrame = CGRectZero;
  CGRect iconImageViewFrame = CGRectZero;
  [self layoutTitleLabelFrame:&titleLabelFrame iconImageViewFrame:&iconImageViewFrame];
  return MDCRectAlignToScale(
      CGRectMake(CGRectGetMinX(titleLabelFrame), CGRectGetMinY(iconImageViewFrame),
                 CGRectGetWidth(titleLabelFrame),
                 CGRectGetMaxY(titleLabelFrame) - CGRectGetMinY(iconImageViewFrame)),
      self.window.screen.scale);
}

@end
