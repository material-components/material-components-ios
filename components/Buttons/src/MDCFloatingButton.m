// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFloatingButton.h"

#import "MaterialShadowElevations.h"
#import "private/MDCButton+Subclassing.h"

#import <MDFInternationalization/MDFInternationalization.h>

static const CGFloat MDCFloatingButtonDefaultDimension = 56;
static const CGFloat MDCFloatingButtonMiniDimension = 40;
static const CGFloat MDCFloatingButtonDefaultImageTitleSpace = 8;
static const UIEdgeInsets internalLayoutInsets = (UIEdgeInsets){0, 16, 0, 24};

@interface MDCFloatingButton ()

@property(nonatomic, readonly)
    NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *>
        *shapeToModeToMinimumSize;

@property(nonatomic, readonly)
    NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *>
        *shapeToModeToMaximumSize;

@property(nonatomic, readonly)
    NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *>
        *shapeToModeToContentEdgeInsets;

@property(nonatomic, readonly)
    NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *>
        *shapeToModeToHitAreaInsets;

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
    [self commonMDCFloatingButtonInit];
    // The superclass sets contentEdgeInsets from defaultContentEdgeInsets before the _shape is set.
    // Set contentEdgeInsets again to ensure the defaults are for the correct shape.
    [self updateShapeAndAllowResize:NO];
  }
  return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
// https://stackoverflow.com/questions/24458608/convenience-initializer-missing-a-self-call-to-another-initializer
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
#pragma clang diagnostic pop
  if (self) {
    // Required to migrate any previously-archived FloatingButtons from .largeIcon shape value
    if (@(_shape).integerValue >= 2) {
      _shape = MDCFloatingButtonShapeDefault;
    }
    // Shape must be set first before the common initialization
    [self commonMDCFloatingButtonInit];

    [self updateShapeAndAllowResize:NO];
  }
  return self;
}

- (void)commonMDCFloatingButtonInit {
  _imageTitleSpace = MDCFloatingButtonDefaultImageTitleSpace;

  const CGSize miniNormalSize =
      CGSizeMake(MDCFloatingButtonMiniDimension, MDCFloatingButtonMiniDimension);
  const CGSize defaultNormalSize =
      CGSizeMake(MDCFloatingButtonDefaultDimension, MDCFloatingButtonDefaultDimension);
  const CGSize defaultExpandedMinimumSize = CGSizeMake(0, 48);
  const CGSize defaultExpandedMaximumSize = CGSizeMake(328, 0);

  // Minimum size values for different shape + mode combinations
  NSMutableDictionary *miniShapeMinimumSizeDictionary =
      [@{@(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:miniNormalSize]} mutableCopy];
  NSMutableDictionary *defaultShapeMinimumSizeDictionary = [@{
    @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:defaultNormalSize],
    @(MDCFloatingButtonModeExpanded) : [NSValue valueWithCGSize:defaultExpandedMinimumSize],
  } mutableCopy];
  _shapeToModeToMinimumSize = [@{
    @(MDCFloatingButtonShapeMini) : miniShapeMinimumSizeDictionary,
    @(MDCFloatingButtonShapeDefault) : defaultShapeMinimumSizeDictionary,
  } mutableCopy];

  // Maximum size values for different shape + mode combinations
  NSMutableDictionary *miniShapeMaximumSizeDictionary =
      [@{@(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:miniNormalSize]} mutableCopy];
  NSMutableDictionary *defaultShapeMaximumSizeDictionary = [@{
    @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:defaultNormalSize],
    @(MDCFloatingButtonModeExpanded) : [NSValue valueWithCGSize:defaultExpandedMaximumSize],
  } mutableCopy];
  _shapeToModeToMaximumSize = [@{
    @(MDCFloatingButtonShapeMini) : miniShapeMaximumSizeDictionary,
    @(MDCFloatingButtonShapeDefault) : defaultShapeMaximumSizeDictionary,
  } mutableCopy];

  // Content edge insets values for different shape + mode combinations
  // .mini shape, .normal mode
  const UIEdgeInsets miniNormalContentInsets = UIEdgeInsetsMake(8, 8, 8, 8);
  NSMutableDictionary *miniShapeContentEdgeInsetsDictionary =
      [@{@(MDCFloatingButtonModeNormal) : [NSValue valueWithUIEdgeInsets:miniNormalContentInsets]}
          mutableCopy];
  _shapeToModeToContentEdgeInsets =
      [@{@(MDCFloatingButtonShapeMini) : miniShapeContentEdgeInsetsDictionary} mutableCopy];

  // Hit area insets values for different shape + mode combinations
  // .mini shape, .normal mode
  const UIEdgeInsets miniNormalHitAreaInset = UIEdgeInsetsMake(-4, -4, -4, -4);
  NSMutableDictionary *miniShapeHitAreaInsetsDictionary = [@{
    @(MDCFloatingButtonModeNormal) : [NSValue valueWithUIEdgeInsets:miniNormalHitAreaInset],
  } mutableCopy];
  _shapeToModeToHitAreaInsets = [@{
    @(MDCFloatingButtonShapeMini) : miniShapeHitAreaInsetsDictionary,
  } mutableCopy];
}

#pragma mark - UIView

- (CGSize)sizeThatFits:(__unused CGSize)size {
  return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSizeForModeNormal {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake(MDCFloatingButtonDefaultDimension, MDCFloatingButtonDefaultDimension);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake(MDCFloatingButtonMiniDimension, MDCFloatingButtonMiniDimension);
  }
}

- (CGSize)intrinsicContentSizeForModeExpanded {
  const CGSize intrinsicTitleSize =
      [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  const CGSize intrinsicImageSize =
      [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  CGFloat intrinsicWidth = intrinsicTitleSize.width + intrinsicImageSize.width +
                           self.imageTitleSpace + internalLayoutInsets.left +
                           internalLayoutInsets.right + self.contentEdgeInsets.left +
                           self.contentEdgeInsets.right;
  CGFloat intrinsicHeight = MAX(intrinsicTitleSize.height, intrinsicImageSize.height) +
                            self.contentEdgeInsets.top + self.contentEdgeInsets.bottom +
                            internalLayoutInsets.top + internalLayoutInsets.bottom;
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

/*
 Performs custom layout when the FAB is in .expanded mode. Specifically, the layout algorithm is
 as follows:

 1. Inset the bounds by the value of `contentEdgeInsets` and use this as the layout bounds.
 2. Determine the intrinsic sizes of the imageView and titleLabel.
 3. Compute the space remaining for the titleLabel after accounting for the imageView and built-in
    alignment guidelines (internalLayoutInsets).
 4. Position the imageView along the leading (or trailing) edge of the button, inset by
    internalLayoutInsets.left (flipped for RTL).
 5. Position the titleLabel along the leading edge of its available space.
 6. Apply the imageEdgeInsets and titleEdgeInsets to their respective views.
 */
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
  // |CEI +--+  |+-----+              |CEI|
  // | LT ||SP||Title|              |RGT|
  // |    +--+  |+-----+              |   |
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
      isLeadingIcon ? internalLayoutInsets : MDFInsetsFlippedHorizontally(internalLayoutInsets);

  const CGRect insetBounds = UIEdgeInsetsInsetRect(
      UIEdgeInsetsInsetRect(self.bounds, adjustedLayoutInsets), self.contentEdgeInsets);

  const CGFloat imageViewWidth = CGRectGetWidth(self.imageView.bounds);
  const CGFloat boundsCenterY = CGRectGetMidY(insetBounds);
  CGFloat titleWidthAvailable = CGRectGetWidth(insetBounds);
  titleWidthAvailable -= imageViewWidth;
  titleWidthAvailable -= self.imageTitleSpace;

  const CGFloat availableHeight = CGRectGetHeight(insetBounds);
  CGSize titleIntrinsicSize =
      [self.titleLabel sizeThatFits:CGSizeMake(titleWidthAvailable, availableHeight)];

  const CGSize titleSize = CGSizeMake(MAX(0, MIN(titleIntrinsicSize.width, titleWidthAvailable)),
                                      MAX(0, MIN(titleIntrinsicSize.height, availableHeight)));

  CGPoint titleCenter;
  CGPoint imageCenter;
  BOOL isLTR =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;

  // If we are LTR with a leading image, the image goes on the left.
  // If we are RTL with a trailing image, the image goes on the left.
  if ((isLTR && isLeadingIcon) || (!isLTR && !isLeadingIcon)) {
    const CGFloat imageCenterX = CGRectGetMinX(insetBounds) + (imageViewWidth / 2);
    const CGFloat titleCenterX =
        CGRectGetMaxX(insetBounds) - titleWidthAvailable + (titleSize.width / 2);
    titleCenter = CGPointMake(titleCenterX, boundsCenterY);
    imageCenter = CGPointMake(imageCenterX, boundsCenterY);
  }
  // If we are LTR with a trailing image, the image goes on the right.
  // If we are RTL with a leading image, the image goes on the right.
  else {
    const CGFloat imageCenterX = CGRectGetMaxX(insetBounds) - (imageViewWidth / 2);
    const CGFloat titleCenterX =
        CGRectGetMinX(insetBounds) + titleWidthAvailable - (titleSize.width / 2);
    imageCenter = CGPointMake(imageCenterX, boundsCenterY);
    titleCenter = CGPointMake(titleCenterX, boundsCenterY);
  }

  self.imageView.center = imageCenter;
  self.imageView.frame = UIEdgeInsetsInsetRect(self.imageView.frame, self.imageEdgeInsets);
  self.titleLabel.center = titleCenter;
  CGRect newBounds = CGRectStandardize(self.titleLabel.bounds);
  self.titleLabel.bounds = (CGRect){newBounds.origin, titleSize};
  self.titleLabel.frame = UIEdgeInsetsInsetRect(self.titleLabel.frame, self.titleEdgeInsets);
}

#pragma mark - Property Setters/Getters

- (void)setMode:(MDCFloatingButtonMode)mode {
  BOOL needsShapeUpdate = self.mode != mode;
  _mode = mode;
  if (needsShapeUpdate) {
    [self updateShapeAndAllowResize:YES];
  }
}

- (void)setMinimumSize:(CGSize)size
              forShape:(MDCFloatingButtonShape)shape
                inMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMinimumSize = self.shapeToModeToMinimumSize[@(shape)];
  if (!modeToMinimumSize) {
    modeToMinimumSize = [@{} mutableCopy];
    self.shapeToModeToMinimumSize[@(shape)] = modeToMinimumSize;
  }
  modeToMinimumSize[@(mode)] = [NSValue valueWithCGSize:size];
  if (shape == _shape && mode == self.mode) {
    [self updateShapeAndAllowResize:YES];
  }
}

- (CGSize)minimumSizeForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMinimumSize = self.shapeToModeToMinimumSize[@(_shape)];
  if (!modeToMinimumSize) {
    return CGSizeZero;
  }

  NSValue *sizeValue = modeToMinimumSize[@(mode)];
  if (sizeValue) {
    return [sizeValue CGSizeValue];
  } else {
    return CGSizeZero;
  }
}

- (BOOL)updateMinimumSize {
  CGSize newSize = [self minimumSizeForMode:self.mode];
  if (CGSizeEqualToSize(newSize, self.minimumSize)) {
    return NO;
  }
  super.minimumSize = newSize;
  return YES;
}

- (void)setMaximumSize:(CGSize)size
              forShape:(MDCFloatingButtonShape)shape
                inMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMaximumSize = self.shapeToModeToMaximumSize[@(shape)];
  if (!modeToMaximumSize) {
    modeToMaximumSize = [@{} mutableCopy];
    self.shapeToModeToMaximumSize[@(shape)] = modeToMaximumSize;
  }
  modeToMaximumSize[@(mode)] = [NSValue valueWithCGSize:size];
  if (shape == _shape && mode == self.mode) {
    [self updateShapeAndAllowResize:YES];
  }
}

- (CGSize)maximumSizeForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMaximumSize = self.shapeToModeToMaximumSize[@(_shape)];
  if (!modeToMaximumSize) {
    return CGSizeZero;
  }

  NSValue *sizeValue = modeToMaximumSize[@(mode)];
  if (sizeValue) {
    return [sizeValue CGSizeValue];
  } else {
    return CGSizeZero;
  }
}

- (BOOL)updateMaximumSize {
  CGSize newSize = [self maximumSizeForMode:self.mode];
  if (CGSizeEqualToSize(newSize, self.maximumSize)) {
    return NO;
  }
  super.maximumSize = newSize;
  return YES;
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                    forShape:(MDCFloatingButtonShape)shape
                      inMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToContentEdgeInsets = self.shapeToModeToContentEdgeInsets[@(shape)];
  if (!modeToContentEdgeInsets) {
    modeToContentEdgeInsets = [@{} mutableCopy];
    self.shapeToModeToContentEdgeInsets[@(shape)] = modeToContentEdgeInsets;
  }
  modeToContentEdgeInsets[@(mode)] = [NSValue valueWithUIEdgeInsets:contentEdgeInsets];
  if (shape == _shape && mode == self.mode) {
    [self updateShapeAndAllowResize:YES];
  }
}

- (UIEdgeInsets)contentEdgeInsetsForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToContentEdgeInsets = self.shapeToModeToContentEdgeInsets[@(_shape)];
  if (!modeToContentEdgeInsets) {
    return UIEdgeInsetsZero;
  }

  NSValue *insetsValue = modeToContentEdgeInsets[@(mode)];
  if (insetsValue) {
    return [insetsValue UIEdgeInsetsValue];
  } else {
    return UIEdgeInsetsZero;
  }
}

- (void)updateContentEdgeInsets {
  super.contentEdgeInsets = [self contentEdgeInsetsForMode:self.mode];
}

- (void)setHitAreaInsets:(UIEdgeInsets)insets
                forShape:(MDCFloatingButtonShape)shape
                  inMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToHitAreaInsets = self.shapeToModeToHitAreaInsets[@(shape)];
  if (!modeToHitAreaInsets) {
    modeToHitAreaInsets = [@{} mutableCopy];
    self.shapeToModeToHitAreaInsets[@(shape)] = modeToHitAreaInsets;
  }
  modeToHitAreaInsets[@(mode)] = [NSValue valueWithUIEdgeInsets:insets];
  if (shape == _shape && mode == self.mode) {
    [self updateShapeAndAllowResize:NO];
  }
}

- (UIEdgeInsets)hitAreaInsetsForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToHitAreaInsets = self.shapeToModeToHitAreaInsets[@(_shape)];
  if (!modeToHitAreaInsets) {
    return UIEdgeInsetsZero;
  }

  NSValue *insetsValue = modeToHitAreaInsets[@(mode)];
  if (insetsValue) {
    return [insetsValue UIEdgeInsetsValue];
  } else {
    return UIEdgeInsetsZero;
  }
}

- (void)updateHitAreaInsets {
  super.hitAreaInsets = [self hitAreaInsetsForMode:self.mode];
}

- (void)updateShapeAndAllowResize:(BOOL)allowsResize {
  BOOL minimumSizeChanged = [self updateMinimumSize];
  BOOL maximumSizeChanged = [self updateMaximumSize];
  [self updateContentEdgeInsets];
  [self updateHitAreaInsets];

  if (allowsResize && (minimumSizeChanged || maximumSizeChanged)) {
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
  }
}

#pragma mark - Deprecations

+ (instancetype)buttonWithShape:(MDCFloatingButtonShape)shape {
  return [[self class] floatingButtonWithShape:shape];
}

@end
