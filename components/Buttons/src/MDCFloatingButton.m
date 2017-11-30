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
static NSString *const MDCFloatingButtonMinimumSizeDictionaryKey = @"MDCFloatingButtonMinimumSizeDictionaryKey";

@interface MDCFloatingButton ()
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *,
    NSMutableDictionary<NSNumber *, NSValue *> *> *shapeToModeToMinimumSize;
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
    [self updateShape];
  }
  return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _shape = [aDecoder decodeIntegerForKey:MDCFloatingButtonShapeKey];
    // Required to migrate any previously-archived FloatingButtons from .largeIcon shape value
    if (@(_shape).integerValue >= 2) {
      _shape = MDCFloatingButtonShapeDefault;
    }
    // Shape must be set first before the common initialization
    [self commonMDCFloatingButtonInit];

    if ([aDecoder containsValueForKey:MDCFloatingButtonModeKey]) {
      _mode = [aDecoder decodeIntegerForKey:MDCFloatingButtonModeKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonImageLocationKey]) {
      _imageLocation = [aDecoder decodeIntegerForKey:MDCFloatingButtonImageLocationKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonImageTitleSpacingKey]) {
      _imageTitleSpacing =
          (CGFloat)[aDecoder decodeDoubleForKey:MDCFloatingButtonImageTitleSpacingKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonMinimumSizeDictionaryKey]) {
      _shapeToModeToMinimumSize = (NSMutableDictionary *)
          [aDecoder decodeObjectForKey:MDCFloatingButtonMinimumSizeDictionaryKey];
    }
    [self updateShape];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_shape forKey:MDCFloatingButtonShapeKey];
  [aCoder encodeInteger:self.mode forKey:MDCFloatingButtonModeKey];
  [aCoder encodeInteger:self.imageLocation forKey:MDCFloatingButtonImageLocationKey];
  [aCoder encodeDouble:self.imageTitleSpacing forKey:MDCFloatingButtonImageTitleSpacingKey];
  [aCoder encodeObject:self.shapeToModeToMinimumSize
                forKey:MDCFloatingButtonMinimumSizeDictionaryKey];
}

- (void)commonMDCFloatingButtonInit {
  _imageTitleSpacing = MDCFloatingButtonDefaultImageTitleSpacing;

  const CGSize miniSizeNormal = CGSizeMake(40, 40);
  const CGSize defaultSizeNormal = CGSizeMake(56, 56);

  if (!_shapeToModeToMinimumSize) {
    NSMutableDictionary *miniMinimumSizes =
        [@{ @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:miniSizeNormal]
            } mutableCopy];
    NSMutableDictionary *defaultMinimumSizes =
        [@{ @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:defaultSizeNormal],
            @(MDCFloatingButtonModeExpanded) : [NSValue valueWithCGSize:CGSizeMake(132, 48)],
            } mutableCopy];
    _shapeToModeToMinimumSize =
        [@{ @(MDCFloatingButtonShapeMini) : miniMinimumSizes,
            @(MDCFloatingButtonShapeDefault) : defaultMinimumSizes,
            } mutableCopy];
  }

  // The superclass sets contentEdgeInsets from defaultContentEdgeInsets before the _shape is set.
  // Set contentEdgeInsets again to ensure the defaults are for the correct shape.
  self.contentEdgeInsets = [self defaultContentEdgeInsets];
  self.hitAreaInsets = [self defaultHitAreaInsets];
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
                    : MDFInsetsFlippedHorizontally(internalLayoutSpacingInsets);

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
  BOOL isLTR =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;

  // If we are LTR with a leading image, the image goes on the left.
  // If we are RTL with a trailing image, the image goes on the left.
  if ((isLTR && isLeadingIcon) || (!isLTR && !isLeadingIcon)) {
    const CGFloat imageCenterX = CGRectGetMinX(insetBounds) + (imageViewWidth / 2);
    const CGFloat titleCenterX = CGRectGetMaxX(insetBounds) - (titleWidthAvailable / 2);
    titleCenter = CGPointMake(titleCenterX, boundsCenterY);
    imageCenter = CGPointMake(imageCenterX, boundsCenterY);
  }
  // If we are LTR with a trailing image, the image goes on the right.
  // If we are RTL with a leading image, the image goes on the right.
  else {
    const CGFloat imageCenterX = CGRectGetMaxX(insetBounds) - (imageViewWidth / 2);
    const CGFloat titleCenterX = CGRectGetMinX(insetBounds) + (titleWidthAvailable / 2);
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
  BOOL needsShapeUpdate = _mode != mode;
  _mode = mode;
  if (needsShapeUpdate) {
    [self updateShape];
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
  if (shape == _shape && mode == _mode) {
    [self updateShape];
  }
}

- (CGSize)minimumSizeForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMinimumSize = self.shapeToModeToMinimumSize[@(_shape)];
  if(!modeToMinimumSize) {
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
  BOOL sizeChanged = (newSize.width > self.minimumSize.width)
      || (newSize.height > self.minimumSize.height);
  super.minimumSize = newSize;
  if (sizeChanged) {
    [self invalidateIntrinsicContentSize];
  }
  return sizeChanged;
}

- (void)updateShape {
  BOOL needsLayout = [self updateMinimumSize];
  if (needsLayout) {
    [self invalidateIntrinsicContentSize];
    [self sizeToFit];
  }
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
