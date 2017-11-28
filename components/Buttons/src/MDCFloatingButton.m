/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFloatingButton.h"

#import "MaterialShadowElevations.h"
#import "private/MDCButton+Subclassing.h"

#import <MDFInternationalization/MDFInternationalization.h>

static const CGFloat MDCFloatingButtonDefaultDimension = 56.0f;
static const CGFloat MDCFloatingButtonMiniDimension = 40.0f;
static const CGFloat MDCFloatingButtonDefaultImageTitleSpacing = 8;
static const UIEdgeInsets internalLayoutSpacingInsets = (UIEdgeInsets){0, 16, 0, 24};

static NSString *const MDCFloatingButtonShapeKey = @"MDCFloatingButtonShapeKey";
static NSString *const MDCFloatingButtonModeKey = @"MDCFloatingButtonModeKey";
static NSString *const MDCFloatingButtonImageLocationKey = @"MDCFloatingButtonImageLocationKey";
static NSString *const MDCFloatingButtonImageTitleSpacingKey = @"MDCFloatingButtonImageTitleSpacingKey";

static UIEdgeInsets UIEdgeInsetsFlippedHorizonally(UIEdgeInsets insets) {
  return UIEdgeInsetsMake(insets.top, insets.right, insets.bottom, insets.left);
}

// TODO(rsmoore): All properties within here will be made public in a future PR.
@interface MDCFloatingButton ()

/**
 The mode of the floating button can either be .normal (a circle) or .expanded (a pill-shaped
 rounded rectangle).

 The default value is @c .normal .
 */
@property(nonatomic, assign) MDCFloatingButtonMode mode UI_APPEARANCE_SELECTOR;

/**
 The location of the image relative to the title when the floating button is in @c expanded mode.

 The default value is @c .leading .
 */
@property(nonatomic, assign) MDCFloatingButtonImageLocation imageLocation UI_APPEARANCE_SELECTOR;

/**
 The horizontal spacing in points between the @c imageView and @c titleLabel when the button is in
 @c .expanded mode. If set to a negative value, the image and title may overlap.

 The default value is 8.
 */
@property(nonatomic, assign) CGFloat imageTitleSpacing UI_APPEARANCE_SELECTOR;

@end

@implementation MDCFloatingButton {
  MDCFloatingButtonShape _shape;
}

+ (void)initialize {
  [[MDCFloatingButton appearance] setElevation:MDCShadowElevationFABResting
                                      forState:UIControlStateNormal];
  [[MDCFloatingButton appearance] setElevation:MDCShadowElevationFABPressed
                                      forState:UIControlStateHighlighted];
}

+ (CGFloat)defaultDimension {
  return MDCFloatingButtonDefaultDimension;
}

+ (CGFloat)miniDimension {
  return MDCFloatingButtonMiniDimension;
}

+ (instancetype)floatingButtonWithShape:(MDCFloatingButtonShape)shape {
  return [[[self class] alloc] initWithFrame:CGRectZero shape:shape];
}

- (instancetype)init {
  return [self initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
}

- (instancetype)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame shape:MDCFloatingButtonShapeDefault];
}

- (instancetype)initWithFrame:(CGRect)frame shape:(MDCFloatingButtonShape)shape {
  self = [super initWithFrame:frame];
  if (self) {
    _shape = shape;
    // The superclass sets contentEdgeInsets from defaultContentEdgeInsets before the _shape is set.
    // Set contentEdgeInsets again to ensure the defaults are for the correct shape.
    self.contentEdgeInsets = [self defaultContentEdgeInsets];
    self.hitAreaInsets = [self defaultHitAreaInsets];
    [self commonMDCFloatingButtonInit];
  }
  return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFloatingButtonInit];
    _shape = [aDecoder decodeIntegerForKey:MDCFloatingButtonShapeKey];
    // Required to migrate any previously-archived FloatingButtons from .largeIcon shape value
    if (@(_shape).integerValue >= 2) {
      _shape = MDCFloatingButtonShapeDefault;
    }
    _mode = [aDecoder decodeIntegerForKey:MDCFloatingButtonModeKey];
    _imageLocation = [aDecoder decodeIntegerForKey:MDCFloatingButtonImageLocationKey];
    _imageTitleSpacing =
        (CGFloat)[aDecoder decodeDoubleForKey:MDCFloatingButtonImageTitleSpacingKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_shape forKey:MDCFloatingButtonShapeKey];
  [aCoder encodeInteger:self.mode forKey:MDCFloatingButtonModeKey];
  [aCoder encodeInteger:self.imageLocation forKey:MDCFloatingButtonImageLocationKey];
  [aCoder encodeDouble:self.imageTitleSpacing forKey:MDCFloatingButtonImageTitleSpacingKey];
}

- (void)commonMDCFloatingButtonInit {
  _mode = MDCFloatingButtonModeNormal;
  _imageLocation = MDCFloatingButtonImageLocationLeading;
  _imageTitleSpacing = MDCFloatingButtonDefaultImageTitleSpacing;
}

#pragma mark - UIView

- (CGSize)sizeThatFits:(__unused CGSize)size {
  return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSizeForModeNormal {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake(56, 56);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake(40, 40);
  }
}

- (CGSize)intrinsicContentSizeForModeExpanded {
  const CGSize intrinsicTitleSize =
      [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  const CGSize intrinsicImageSize =
      [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  CGFloat intrinsicWidth = intrinsicTitleSize.width + intrinsicImageSize.width +
      self.imageTitleSpacing + internalLayoutSpacingInsets.left +
      internalLayoutSpacingInsets.right + self.contentEdgeInsets.left +
      self.contentEdgeInsets.right;
  CGFloat intrinsicHeight = MAX(intrinsicTitleSize.height, intrinsicImageSize.height) +
      self.contentEdgeInsets.top + self.contentEdgeInsets.bottom + internalLayoutSpacingInsets.top +
      internalLayoutSpacingInsets.bottom;
  return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (CGSize)intrinsicContentSize {
  CGSize contentSize = CGSizeZero;
  if (self.mode == MDCFloatingButtonModeNormal) {
    contentSize = [self intrinsicContentSizeForModeNormal];
  } else if (self.mode == MDCFloatingButtonModeExpanded) {
    contentSize = [self intrinsicContentSizeForModeExpanded];
  }

  if (self.minimumSize.height > 0) {
    contentSize.height = MAX(self.minimumSize.height, contentSize.height);
  }
  if (self.maximumSize.height > 0) {
    contentSize.height = MIN(self.maximumSize.height, contentSize.height);
  }
  if (self.minimumSize.width > 0) {
    contentSize.width = MAX(self.minimumSize.width, contentSize.width);
  }
  if (self.maximumSize.width > 0) {
    contentSize.width = MIN(self.maximumSize.width, contentSize.width);
  }
  return contentSize;
}

- (void)layoutSubviews {
  // We have to set cornerRadius before laying out subviews so that the boundingPath is correct.
  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
  [super layoutSubviews];

   if (self.mode == MDCFloatingButtonModeNormal) {
    return;
  }

  // Position the imageView and titleView
  //
  // +------------------------------------+
  // |    |  |  |  CEI TOP            |   |
  // |CEI +--+  |       +-----+       |CEI|
  // | LT ||SP|-- A --|Title|-- A --|RGT|
  // |    +--+  |       +-----+       |   |
  // |    |  |  |  CEI BOT            |   |
  // +------------------------------------+
  //
  // (A) The same spacing on either side of the label.
  // (SP) The spacing between the image and title
  // (CEI) Content Edge Insets
  //
  // The diagram above assumes an LTR user interface orientation
  // and a .leadingIcon imageLocation for this button.

  BOOL isLeadingIcon = self.imageLocation == MDCFloatingButtonImageLocationLeading;
  UIEdgeInsets adjustedLayoutInsets =
      isLeadingIcon ? internalLayoutSpacingInsets
                    : UIEdgeInsetsFlippedHorizonally(internalLayoutSpacingInsets);

  const CGRect insetBounds = UIEdgeInsetsInsetRect(UIEdgeInsetsInsetRect(self.bounds,
                                                                         adjustedLayoutInsets),
                                                   self.contentEdgeInsets);

  const CGFloat imageViewWidth = CGRectGetWidth(self.imageView.bounds);
  const CGFloat boundsCenterY = CGRectGetMidY(insetBounds);
  CGFloat titleWidthAvailable = CGRectGetWidth(insetBounds);
  titleWidthAvailable -= imageViewWidth;
  titleWidthAvailable -= self.imageTitleSpacing;

  const CGFloat availableHeight = CGRectGetHeight(insetBounds);
  CGSize titleIntrinsicSize
      = [self.titleLabel sizeThatFits:CGSizeMake(titleWidthAvailable, availableHeight)];

  const CGSize titleSize = CGSizeMake(MAX(0, MIN(titleIntrinsicSize.width, titleWidthAvailable)),
                                      MAX(0, MIN(titleIntrinsicSize.height, availableHeight)));

  CGPoint titleCenter;
  CGPoint imageCenter;
  BOOL isRTL = self.mdf_effectiveUserInterfaceLayoutDirection
      == UIUserInterfaceLayoutDirectionRightToLeft;

  // isRTL && isLeadingIcon => icon to right of text
  // !isRTL && !isLeadingIcon => icon to right of text
  // isRTL && !isLeadingIcon => icon to left of text
  // !isRTL && isLeadingIcon => icon to left of text
  if (isRTL == isLeadingIcon) {
    const CGFloat imageCenterX
        = CGRectGetMaxX(insetBounds) - (imageViewWidth / 2);
    const CGFloat titleCenterX = CGRectGetMinX(insetBounds) + (titleWidthAvailable / 2);
    imageCenter = CGPointMake(imageCenterX, boundsCenterY);
    titleCenter = CGPointMake(titleCenterX, boundsCenterY);
  } else {
    const CGFloat imageCenterX
        = CGRectGetMinX(insetBounds) + (imageViewWidth / 2);
    const CGFloat titleCenterX
        = CGRectGetMaxX(insetBounds) - (titleWidthAvailable / 2);
    titleCenter = CGPointMake(titleCenterX, boundsCenterY);
    imageCenter = CGPointMake(imageCenterX, boundsCenterY);
  }

  self.imageView.center = imageCenter;
  self.imageView.frame = UIEdgeInsetsInsetRect(self.imageView.frame, self.imageEdgeInsets);
  self.titleLabel.center = titleCenter;
  CGRect newBounds = CGRectStandardize(self.titleLabel.bounds);
  self.titleLabel.bounds = (CGRect){newBounds.origin, titleSize};
  self.titleLabel.frame = UIEdgeInsetsInsetRect(self.titleLabel.frame, self.titleEdgeInsets);
}

#pragma mark - Subclassing

- (UIEdgeInsets)defaultContentEdgeInsets {
  return UIEdgeInsetsZero;
}

- (UIEdgeInsets)defaultHitAreaInsets {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return UIEdgeInsetsZero;
    case MDCFloatingButtonShapeMini:
      // Increase the touch target from (40, 40) to the minimum (48, 48)
      return UIEdgeInsetsMake(-4, -4, -4, -4);
  }
}

#pragma mark - Deprecations

+ (instancetype)buttonWithShape:(MDCFloatingButtonShape)shape {
  return [[self class] floatingButtonWithShape:shape];
}

@end
