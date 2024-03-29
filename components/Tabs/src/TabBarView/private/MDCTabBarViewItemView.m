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

#import "MDCBadgeAppearance.h"
#import "MDCBadgeView.h"
#import "MDCRippleTouchController.h"
#import "MDCTabBarViewItemViewDelegate.h"
#import "MDCMath.h"

NS_ASSUME_NONNULL_BEGIN

/** The minimum height of any item view with only a title or image (not both). */
static const CGFloat kMinHeightTitleOrImageOnly = 48;

/** The minimum height of any item view with both a title and image. */
static const CGFloat kMinHeightTitleAndImage = 72;

/** The vertical padding between the image view and the title label. */
static const CGFloat kImageTitlePadding = 3;

/** The horizontal padding between the image view or title label and badge. */
static const CGFloat kBadgeXOffset = 4;

/** The amount the badge overlaps with the image view when an image is present. */
static const CGFloat kBadgeXInset = 12;

@interface MDCTabBarViewItemView ()

/** Indicates the selection status of this item view. */
@property(nonatomic, assign, getter=isSelected) BOOL selected;

- (CGPoint)badgeCenterFromFrame:(CGRect)frame isRTL:(BOOL)isRTL;

@end

@implementation MDCTabBarViewItemView {
  MDCBadgeView *_Nonnull _badge;
}

@synthesize selectedImage = _selectedImage;
@synthesize badgeText = _badgeText;
@synthesize badgeAppearance = _badgeAppearance;

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

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
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

  if (!_badgeAppearance) {
    // We store a local copy of the badge appearance so that we can consistently override with the
    // UITabBarItem badgeColor property.
    _badgeAppearance = [[MDCBadgeAppearance alloc] init];
  }

  if (!_badge) {
    _badge = [[MDCBadgeView alloc] initWithFrame:CGRectZero];
    _badge.isAccessibilityElement = NO;
    [self addSubview:_badge];
    _badge.hidden = YES;
  }

  _iconSize = CGSizeZero;
}

- (CGPoint)badgeCenterFromFrame:(CGRect)frame isRTL:(BOOL)isRTL {
  CGSize badgeSize = [_badge sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];

  CGFloat halfBadgeHeight = badgeSize.height / 2;
  CGFloat halfBadgeWidth = badgeSize.width / 2;

  CGFloat badgeCenterY = (CGRectGetMinY(frame) - 4) + halfBadgeHeight;
  badgeCenterY -= _badge.appearance.borderWidth / 2;

  CGFloat xCenter = isRTL ? (CGRectGetMinX(frame) - kBadgeXOffset) + halfBadgeWidth
                          : (CGRectGetMaxX(frame) + kBadgeXOffset) - halfBadgeWidth;
  xCenter -= _badge.appearance.borderWidth / 2;

  return CGPointMake(xCenter, badgeCenterY);
}

- (CGPoint)centerForOnlyTitleFromFrame:(CGRect)frame isRTL:(BOOL)isRTL {
  CGSize badgeSize = [_badge sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];

  CGFloat halfBadgeWidth = badgeSize.width / 2;
  CGFloat centerY = CGRectGetMidY(frame);
  CGFloat centerX = isRTL ? CGRectGetMinX(frame) - halfBadgeWidth - kBadgeXOffset
                          : CGRectGetMaxX(frame) + halfBadgeWidth + kBadgeXOffset;
  return CGPointMake(centerX, centerY);
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  if (!self.titleLabel.text.length && !self.iconImageView.image) {
    return;
  }

  [_badge sizeToFit];

  BOOL isRTL =
      self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;

  BOOL hasTitle = self.titleLabel.text.length > 0 ? YES : NO;
  BOOL hasIcon = self.iconImageView.image != nil ? YES : NO;

  if (hasTitle && !hasIcon) {
    CGRect titleLabelFrame = [self titleLabelFrameForTitleOnlyLayout];
    self.titleLabel.frame = titleLabelFrame;
    _badge.center = [self centerForOnlyTitleFromFrame:titleLabelFrame isRTL:isRTL];
    return;
  } else if (!hasTitle && hasIcon) {
    CGRect iconImageFrame = [self iconImageViewFrameForImageOnlyLayout];
    self.iconImageView.frame = iconImageFrame;
    _badge.center = [self badgeCenterFromFrame:iconImageFrame isRTL:isRTL];
    return;
  } else {
    CGRect titleLabelFrame = CGRectZero;
    CGRect iconImageViewFrame = CGRectZero;
    [self layoutTitleLabelFrame:&titleLabelFrame iconImageViewFrame:&iconImageViewFrame];
    self.titleLabel.frame = titleLabelFrame;
    self.iconImageView.frame = iconImageViewFrame;
    _badge.center = [self badgeCenterFromFrame:iconImageViewFrame isRTL:isRTL];
  }
}

- (CGRect)titleLabelFrameForTitleOnlyLayout {
  CGRect contentFrame = UIEdgeInsetsInsetRect(
      self.bounds, [self contentInsetsForItemViewStyle:MDCTabBarViewItemViewStyleTextOnly]);

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
  CGRect contentFrame = UIEdgeInsetsInsetRect(
      self.bounds, [self contentInsetsForItemViewStyle:MDCTabBarViewItemViewStyleImageOnly]);

  CGSize contentSize = CGSizeMake(CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  CGSize imageIntrinsicContentSize = CGSizeEqualToSize(self.iconSize, CGSizeZero)
                                         ? self.iconImageView.intrinsicContentSize
                                         : self.iconSize;
  CGSize imageFinalSize = CGSizeMake(MIN(contentSize.width, imageIntrinsicContentSize.width),
                                     MIN(contentSize.height, imageIntrinsicContentSize.height));
  CGRect imageViewFrame = CGRectMake(CGRectGetMidX(contentFrame) - (imageFinalSize.width / 2),
                                     CGRectGetMidY(contentFrame) - (imageFinalSize.height / 2),
                                     imageFinalSize.width, imageFinalSize.height);
  return MDCRectAlignToScale(imageViewFrame, self.window.screen.scale);
}

- (void)layoutTitleLabelFrame:(CGRect *)titleLabelFrame
           iconImageViewFrame:(CGRect *)iconImageViewFrame {
  CGRect contentFrame = UIEdgeInsetsInsetRect(
      self.bounds, [self contentInsetsForItemViewStyle:MDCTabBarViewItemViewStyleTextAndImage]);

  CGSize contentSize = CGSizeMake(CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
  CGSize labelSingleLineSize = self.titleLabel.intrinsicContentSize;
  CGSize availableIconSize = CGSizeMake(
      contentSize.width, contentSize.height - (kImageTitlePadding + labelSingleLineSize.height));

  // Position the image, limiting it so that at least 1 line of text remains.
  CGSize imageIntrinsicContentSize = CGSizeEqualToSize(self.iconSize, CGSizeZero)
                                         ? self.iconImageView.intrinsicContentSize
                                         : self.iconSize;
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
  return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (!self.titleLabel.text.length && !self.iconImageView.image) {
    return CGSizeMake([self minWidth], kMinHeightTitleOrImageOnly);
  }
  if (self.titleLabel.text.length && !self.iconImageView.image) {
    return [self sizeThatFitsTextOnly:size];
  } else if (!self.titleLabel.text.length && self.iconImageView.image) {
    return [self sizeThatFitsImageOnly:size];
  }
  return [self sizeThatFitsTextAndImage:size];
}

- (CGSize)sizeThatFitsTextOnly:(CGSize)size {
  CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
  CGSize labelSize = [self.titleLabel sizeThatFits:maxSize];

  UIEdgeInsets contentInsets =
      [self contentInsetsForItemViewStyle:MDCTabBarViewItemViewStyleTextOnly];
  if (self.badgeText != nil) {
    CGSize badgeSize = [_badge sizeThatFits:maxSize];
    return CGSizeMake(MAX([self minWidth], badgeSize.width + kBadgeXOffset + labelSize.width +
                                               contentInsets.left + contentInsets.right),
                      MAX(kMinHeightTitleOrImageOnly,
                          labelSize.height + contentInsets.top + contentInsets.bottom));
  }
  return CGSizeMake(
      MAX([self minWidth], labelSize.width + contentInsets.left + contentInsets.right),
      MAX(kMinHeightTitleOrImageOnly, labelSize.height + contentInsets.top + contentInsets.bottom));
}

- (CGSize)sizeThatFitsImageOnly:(CGSize)size {
  CGSize imageIntrinsicContentSize = self.iconImageView.intrinsicContentSize;
  UIEdgeInsets contentInsets =
      [self contentInsetsForItemViewStyle:MDCTabBarViewItemViewStyleImageOnly];
  if (self.badgeText != nil) {
    CGSize badgeSize = [_badge sizeThatFits:size];
    return CGSizeMake(
        MAX([self minWidth], badgeSize.width - kBadgeXInset + imageIntrinsicContentSize.width +
                                 contentInsets.left + contentInsets.right),
        MAX(kMinHeightTitleOrImageOnly,
            imageIntrinsicContentSize.height + contentInsets.top + contentInsets.bottom));
  }
  return CGSizeMake(MAX([self minWidth],
                        imageIntrinsicContentSize.width + contentInsets.left + contentInsets.right),
                    MAX(kMinHeightTitleOrImageOnly, imageIntrinsicContentSize.height +
                                                        contentInsets.top + contentInsets.bottom));
}

- (CGSize)sizeThatFitsTextAndImage:(CGSize)size {
  CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
  CGSize labelFitSize = [self.titleLabel sizeThatFits:maxSize];
  CGSize imageFitSize = self.iconImageView.intrinsicContentSize;
  UIEdgeInsets contentInsets =
      [self contentInsetsForItemViewStyle:MDCTabBarViewItemViewStyleTextAndImage];
  if (self.badgeText != nil) {
    CGSize badgeSize = [_badge sizeThatFits:maxSize];
    CGFloat badgeIconWidth = imageFitSize.width + badgeSize.width - kBadgeXInset;
    return CGSizeMake(
        MAX([self minWidth],
            contentInsets.left + MAX(badgeIconWidth, labelFitSize.width) + contentInsets.right),
        MAX(kMinHeightTitleAndImage, contentInsets.top + imageFitSize.height + kImageTitlePadding +
                                         labelFitSize.height + contentInsets.bottom));
  }
  return CGSizeMake(
      MAX([self minWidth],
          contentInsets.left + MAX(imageFitSize.width, labelFitSize.width) + contentInsets.right),
      MAX(kMinHeightTitleAndImage, contentInsets.top + imageFitSize.height + kImageTitlePadding +
                                       labelFitSize.height + contentInsets.bottom));
}

#pragma mark - MDCTabBarViewItemView properties

- (void)setDisableRippleBehavior:(BOOL)disableRippleBehavior {
  _disableRippleBehavior = disableRippleBehavior;

  if (_disableRippleBehavior) {
    _rippleTouchController = nil;
  } else {
    _rippleTouchController = [[MDCRippleTouchController alloc] initWithView:self];
  }
}

- (void)setImage:(nullable UIImage *)image {
  _image = image;
  self.iconImageView.image = self.selected ? self.selectedImage : self.image;
  [self setNeedsLayout];
}

- (void)setSelectedImage:(nullable UIImage *)selectedImage {
  _selectedImage = selectedImage;
  self.iconImageView.image = self.selected ? self.selectedImage : self.image;
  [self setNeedsLayout];
}

- (nullable UIImage *)selectedImage {
  return _selectedImage ?: self.image;
}

- (CGFloat)minWidth {
  if (self.itemViewDelegate && [self.itemViewDelegate respondsToSelector:@selector(minItemWidth)]) {
    return self.itemViewDelegate.minItemWidth;
  }
  return 0;
}

- (UIEdgeInsets)contentInsetsForItemViewStyle:(MDCTabBarViewItemViewStyle)itemViewStyle {
  if (self.itemViewDelegate &&
      [self.itemViewDelegate respondsToSelector:@selector(contentInsetsForItemViewStyle:)]) {
    return [self.itemViewDelegate contentInsetsForItemViewStyle:itemViewStyle];
  }
  return UIEdgeInsetsZero;
}

#pragma mark - Displaying a value in the badge

- (void)setBadgeText:(nullable NSString *)badgeText {
  _badgeText = badgeText;
  _badge.text = self.badgeText;
  if (badgeText == nil) {
    _badge.hidden = YES;
  } else {
    _badge.hidden = NO;
  }

  [self setNeedsLayout];
}

- (nullable NSString *)badgeText {
  return _badgeText;
}

#pragma mark - Configuring the badge's visual appearance

- (void)commitBadgeAppearance {
  MDCBadgeAppearance *appearance = [_badgeAppearance copy];
  if (_badgeColor) {
    appearance.backgroundColor = _badgeColor;
  }
  _badge.appearance = appearance;
}

- (void)setBadgeAppearance:(MDCBadgeAppearance *)badgeAppearance {
  _badgeAppearance = [badgeAppearance copy];

  [self commitBadgeAppearance];
}

- (void)setBadgeColor:(nullable UIColor *)badgeColor {
  if (badgeColor == nil) {
    // The new MDCBadgeAppearance API treats nil as equivalent to tintColor now, in alignment with
    // UIKit, so to maintain backward-compatibility with expected behavior, we force-cast nil to a
    // clearColor instance.
    badgeColor = [UIColor clearColor];
  }
  _badgeColor = badgeColor;

  [self commitBadgeAppearance];
}

- (void)setIconSize:(CGSize)iconSize {
  _iconSize = iconSize;

  [self setNeedsLayout];
}

#pragma mark - UIAccessibility

- (nullable NSString *)accessibilityLabel {
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

#pragma mark - UILargeContentViewerItem

- (BOOL)showsLargeContentViewer {
  return YES;
}

- (nullable NSString *)largeContentTitle {
  if (_largeContentTitle) {
    return _largeContentTitle;
  }

  NSString *title = self.titleLabel.text;
  if (!title && self.largeContentImage) {
    return self.accessibilityLabel;
  }

  return title;
}

- (nullable UIImage *)largeContentImage {
  if (_largeContentImage) {
    return _largeContentImage;
  }

  return self.image;
}

- (BOOL)scalesLargeContentImage {
  return _largeContentImage == nil;
}

@end

NS_ASSUME_NONNULL_END
