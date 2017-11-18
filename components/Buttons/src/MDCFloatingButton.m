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
static const UIEdgeInsets internalLayoutSpacingInsets = (UIEdgeInsets){0, 16, 0, 24};

static NSString *const MDCFloatingButtonTypeKey = @"MDCFloatingButtonTypeKey";
static NSString *const MDCFloatingButtonModeKey = @"MDCFloatingButtonModeKey";
static NSString *const MDCFloatingButtonImagePositionKey = @"MDCFloatingButtonImagePositionKey";
static NSString *const MDCFloatingImageTitlePaddingKey = @"MDCFloatingImageTitlePaddingKey";

static NSString *const MDCFloatingButtonMinimumSizeDictionaryKey
    = @"MDCFloatingButtonMinimumSizeDictionaryKey";
static NSString *const MDCFloatingButtonMaximumSizeDictionaryKey
    = @"MDCFloatingButtonMaximumSizeDictionaryKey";
static NSString *const MDCFloatingButtonContentEdgeInsetsDictionaryKey
    = @"MDCFloatingButtonContentEdgeInsetsDictionaryKey";
static NSString *const MDCFloatingButtonHitAreaInsetsDictionaryKey
    = @"MDCFloatingButtonHitAreaInsetsDictionaryKey";

/* Only used to decode previous versions. */
static NSString *const MDCFloatingButtonShapeKey = @"MDCFloatingButtonShapeKey";

static UIEdgeInsets UIEdgeInsetsFlippedHorizonally(UIEdgeInsets insets) {
  return UIEdgeInsetsMake(insets.top, insets.right, insets.bottom, insets.left);
}

@interface MDCFloatingButton ()
@property(nonatomic, assign) MDCFloatingButtonType type;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *> *typeToModeToHitAreaInsets;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *> *typetoModeToMinimumSize;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *> *typeToModeToMaximumSize;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSValue *> *> *typeToModeToContentEdgeInsets;
@end

@implementation MDCFloatingButton

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


- (instancetype)init {
  return [self initWithFrame:CGRectZero type:MDCFloatingButtonTypeDefault];
}

- (instancetype)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame type:MDCFloatingButtonTypeDefault];
}

- (instancetype)initWithFrame:(CGRect)frame type:(MDCFloatingButtonType)type {
  self = [super initWithFrame:frame];
  if (self) {
    _type = type;
    // The superclass sets contentEdgeInsets from defaultContentEdgeInsets before the _shape is set.
    // Set contentEdgeInsets again to ensure the defaults are for the correct shape.
    [self commonMDCFloatingButtonInit];
    [self updateType];
  }
  return self;
}

- (void)commonMDCFloatingButtonInit {

  const CGSize miniSizeNormal = CGSizeMake(40, 40);
  const CGSize defaultSizeNormal = CGSizeMake(56, 56);

  NSMutableDictionary *miniMinimumSizes
    = [@{
         @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:miniSizeNormal]
         } mutableCopy];
  NSMutableDictionary *defaultMinimumSizes
      = [@{ @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:defaultSizeNormal],
            @(MDCFloatingButtonModeExtended) : [NSValue valueWithCGSize:CGSizeMake(132, 48)],
            } mutableCopy];
  _typetoModeToMinimumSize
      = [@{
           @(MDCFloatingButtonTypeMini) : miniMinimumSizes,
           @(MDCFloatingButtonTypeDefault) : defaultMinimumSizes,
           } mutableCopy];

  NSMutableDictionary *miniMaxSizes
      = [@{
           @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:miniSizeNormal]
           } mutableCopy];
  NSMutableDictionary *defaultMaxSizes
      = [@{
           @(MDCFloatingButtonModeNormal) : [NSValue valueWithCGSize:defaultSizeNormal],
           @(MDCFloatingButtonModeExtended) : [NSValue valueWithCGSize:CGSizeMake(328, 0)],
           } mutableCopy];

  _typeToModeToMaximumSize
      = [@{
           @(MDCFloatingButtonTypeMini) : miniMaxSizes,
           @(MDCFloatingButtonTypeDefault) : defaultMaxSizes,
           } mutableCopy];

  NSMutableDictionary *miniContentEdgeInsets = [@{} mutableCopy];
  NSMutableDictionary *defaultContentEdgeInsets = [@{} mutableCopy];
  _typeToModeToContentEdgeInsets = [@{ @(MDCFloatingButtonTypeMini) : miniContentEdgeInsets,
                                       @(MDCFloatingButtonTypeDefault) : defaultContentEdgeInsets,
                                       } mutableCopy];

  NSMutableDictionary *miniNormalHitAreaInsets
      = [@{
           @(MDCFloatingButtonModeNormal) :
             [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(-4, -4, -4, -4)],
           } mutableCopy];
  _typeToModeToHitAreaInsets
      = [@{
           @(MDCFloatingButtonTypeMini) : miniNormalHitAreaInsets,
           } mutableCopy];

  super.contentEdgeInsets = [self defaultContentEdgeInsets];
  super.hitAreaInsets = [self defaultHitAreaInsets];
  _imageTitlePadding = 8;
  _imagePosition = MDCFloatingButtonImagePositionLeading;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFloatingButtonInit];
    _type = [aDecoder decodeIntegerForKey:MDCFloatingButtonTypeKey];

    // Migrate (MDCFloatingButtonShapeLargeIcon = 2) to type value .default
    if ([aDecoder containsValueForKey:MDCFloatingButtonShapeKey]) {
      NSInteger shape = [aDecoder decodeIntegerForKey:MDCFloatingButtonShapeKey];
      if (shape == 2) {
        _type = MDCFloatingButtonTypeDefault;
      }
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonMinimumSizeDictionaryKey]) {
      _typetoModeToMinimumSize = [aDecoder decodeObjectForKey:MDCFloatingButtonMinimumSizeDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonMaximumSizeDictionaryKey]) {
      _typeToModeToMaximumSize = [aDecoder decodeObjectForKey:MDCFloatingButtonMaximumSizeDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonContentEdgeInsetsDictionaryKey]) {
      _typeToModeToContentEdgeInsets
          = [aDecoder decodeObjectForKey:MDCFloatingButtonContentEdgeInsetsDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonHitAreaInsetsDictionaryKey]) {
      _typeToModeToHitAreaInsets
          = [aDecoder decodeObjectForKey:MDCFloatingButtonHitAreaInsetsDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonImagePositionKey]) {
      _imagePosition = [aDecoder decodeIntegerForKey:MDCFloatingButtonImagePositionKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingImageTitlePaddingKey]) {
      _imageTitlePadding = (CGFloat)[aDecoder decodeDoubleForKey:MDCFloatingImageTitlePaddingKey];
    }
    [self updateType];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:self.type forKey:MDCFloatingButtonTypeKey];
  [aCoder encodeObject:self.typeToModeToHitAreaInsets forKey:MDCFloatingButtonMinimumSizeDictionaryKey];
  [aCoder encodeObject:self.typeToModeToMaximumSize forKey:MDCFloatingButtonMaximumSizeDictionaryKey];
  [aCoder encodeObject:self.typeToModeToContentEdgeInsets
                forKey:MDCFloatingButtonContentEdgeInsetsDictionaryKey];
  [aCoder encodeObject:self.typeToModeToHitAreaInsets
                forKey:MDCFloatingButtonHitAreaInsetsDictionaryKey];
  [aCoder encodeInteger:self.imagePosition forKey:MDCFloatingButtonImagePositionKey];
  [aCoder encodeDouble:self.imageTitlePadding forKey:MDCFloatingImageTitlePaddingKey];
}

#pragma mark - UIView

- (CGSize)intrinsicContentSizeForModeNormal {
  switch(self.type) {
    case MDCFloatingButtonTypeMini:
      return CGSizeMake(40, 40);
    case MDCFloatingButtonTypeDefault:
      return CGSizeMake(56, 56);
  }
}

- (CGSize)intrinsicContentSizeForModeExtended {
  const CGSize intrinsicTitleSize
      = [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  const CGSize intrinsicImageSize
      = [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  CGFloat intrinsicWidth = intrinsicTitleSize.width + intrinsicImageSize.width
      + self.imageTitlePadding + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
  CGFloat intrinsicHeight = MAX(intrinsicTitleSize.height, intrinsicImageSize.height)
      + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
  return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (CGSize)intrinsicContentSize {
  if (self.mode == MDCFloatingButtonModeNormal) {
    return [self intrinsicContentSizeForModeNormal];
  } else if (self.mode == MDCFloatingButtonModeExtended) {
    return [self intrinsicContentSizeForModeExtended];
  }
  return [super intrinsicContentSize];
}

//- (CGSize)sizeThatFits:(CGSize)size {
//  switch(self.shape) {
//    case MDCFloatingButtonShapeDefault:
//    case MDCFloatingButtonShapeMini:
//    case MDCFloatingButtonShapeLargeIcon:
//      return [super sizeThatFits:size];
//    case MDCFloatingButtonShapeExtendedLeadingIcon:
//    case MDCFloatingButtonShapeExtendedTrailingIcon: {
//      // UIButton will compute the size basically the same as MDCFloatingButton,
//      // but without the |imageTitlePadding|
//      const CGSize superSize = [super sizeThatFits:size];
//      return CGSizeMake(superSize.width + self.imageTitlePadding, superSize.height);
//    }
//  }
//}


- (CGSize)sizeThatFits:(__unused CGSize)size {
  const CGSize intrinsicSize = [self intrinsicContentSize];
  CGSize finalSize = intrinsicSize;
  if (self.minimumSize.height > 0) {
    finalSize.height = MAX(self.minimumSize.height, finalSize.height);
  }
  if (self.maximumSize.height > 0) {
    finalSize.height = MIN(self.maximumSize.height, finalSize.height);
  }
  if (self.minimumSize.width > 0) {
    finalSize.width = MAX(self.minimumSize.width, finalSize.width);
  }
  if (self.maximumSize.width > 0) {
    finalSize.width = MIN(self.maximumSize.width, finalSize.width);
  }
  return finalSize;
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
  // and a .leadingIcon shape for this button.

  UIEdgeInsets adjustedLayoutInsets = internalLayoutSpacingInsets;
  UIEdgeInsets adjustedContentEdgeInsets = self.contentEdgeInsets;
  if (self.contentEdgeInsetsFlippedForTrailingImagePosition
      && self.imagePosition == MDCFloatingButtonImagePositionTrailing)  {
    adjustedLayoutInsets = UIEdgeInsetsFlippedHorizonally(internalLayoutSpacingInsets);
    adjustedContentEdgeInsets = UIEdgeInsetsFlippedHorizonally(self.contentEdgeInsets);
  }
  const CGRect insetBounds = UIEdgeInsetsInsetRect(UIEdgeInsetsInsetRect(self.bounds,
                                                                         adjustedLayoutInsets),
                                                   adjustedContentEdgeInsets);
  NSLog(@"\nBounds: %@\nInBnds: %@", NSStringFromCGRect(self.bounds), NSStringFromCGRect(insetBounds));
  const CGFloat imageViewWidth = CGRectGetWidth(self.imageView.bounds);
  const CGFloat boundsCenterY = CGRectGetMidY(insetBounds);
  CGFloat titleWidthAvailable = CGRectGetWidth(insetBounds);
  titleWidthAvailable -= imageViewWidth;
  titleWidthAvailable -= self.imageTitlePadding;

  const CGFloat availableHeight = CGRectGetHeight(insetBounds);
  CGSize titleIntrinsicSize
      = [self.titleLabel sizeThatFits:CGSizeMake(titleWidthAvailable, availableHeight)];

  const CGSize titleSize = CGSizeMake(MAX(0, MIN(titleIntrinsicSize.width, titleWidthAvailable)),
                                      MAX(0, MIN(titleIntrinsicSize.height, availableHeight)));

  BOOL isRTL = self.mdf_effectiveUserInterfaceLayoutDirection
      == UIUserInterfaceLayoutDirectionRightToLeft;
  BOOL isLeadingIcon = self.imagePosition == MDCFloatingButtonImagePositionLeading;

  CGPoint titleCenter;
  CGPoint imageCenter;
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
  CGRect oldBounds = self.titleLabel.bounds;
  self.titleLabel.center = titleCenter;
  CGRect midBounds = self.titleLabel.bounds;
  (void)midBounds;
  (void)oldBounds;
  CGRect newBounds = CGRectStandardize(self.titleLabel.bounds);
  self.titleLabel.bounds = (CGRect){newBounds.origin, titleSize};
  self.titleLabel.frame = UIEdgeInsetsInsetRect(self.titleLabel.frame, self.titleEdgeInsets);
  CGRect lastBounds = self.titleLabel.bounds;
  (void)lastBounds;

}

#pragma mark - Subclassing

- (UIEdgeInsets)defaultContentEdgeInsets {
  NSMutableDictionary *modeToContentEdgeInsets = self.typeToModeToContentEdgeInsets[@(self.type)];
  if (!modeToContentEdgeInsets) {
    return UIEdgeInsetsZero;
  }

  NSValue *insetsValue = modeToContentEdgeInsets[@(self.mode)];
  if (insetsValue) {
    return [insetsValue UIEdgeInsetsValue];
  } else {
    return UIEdgeInsetsZero;
  }
}

- (UIEdgeInsets)defaultHitAreaInsets {
  NSMutableDictionary *modeToHitAreaInsets = self.typeToModeToHitAreaInsets[@(self.type)];
  if (!modeToHitAreaInsets) {
    return UIEdgeInsetsZero;
  }

  NSValue *insetsValue = modeToHitAreaInsets[@(self.mode)];
  if (insetsValue) {
    return [insetsValue UIEdgeInsetsValue];
  } else {
    return UIEdgeInsetsZero;
  }
}

#pragma mark - Extended FAB changes
- (void)setMinimumSize:(__unused CGSize)size {
  NSAssert(NO, @"Not available. Use setMinimumSize:forType:mode: instead");
}

- (void)setMinimumSize:(CGSize)size
               forType:(MDCFloatingButtonType)type
                  mode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMinimumSize = self.typetoModeToMinimumSize[@(self.type)];
  if (!modeToMinimumSize) {
    modeToMinimumSize = [@{} mutableCopy];
    self.typetoModeToMinimumSize[@(self.type)] = modeToMinimumSize;
  }
  modeToMinimumSize[@(mode)] = [NSValue valueWithCGSize:size];
  if (type == self.type && mode == self.mode) {
    [self updateType];
  }
}

- (void)setMaximumSize:(__unused CGSize)size {
  NSAssert(NO, @"Not available. Use setMaximumSize:forType:mode: instead");
}

- (void)setMaximumSize:(CGSize)size
               forType:(MDCFloatingButtonType)type
                  mode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMaximumSize = self.typeToModeToMaximumSize[@(self.type)];
  if (!modeToMaximumSize) {
    modeToMaximumSize = [@{} mutableCopy];
    self.typeToModeToMaximumSize[@(self.type)] = modeToMaximumSize;
  }
  modeToMaximumSize[@(mode)] = [NSValue valueWithCGSize:size];
  if (type == self.type && mode == self.mode) {
    [self updateType];
  }
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                     forType:(MDCFloatingButtonType)type
                        mode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToContentEdgeInsets = self.typeToModeToContentEdgeInsets[@(self.type)];
  if (!modeToContentEdgeInsets) {
    modeToContentEdgeInsets = [@{} mutableCopy];
    self.typeToModeToContentEdgeInsets[@(self.type)] = modeToContentEdgeInsets;
  }
  modeToContentEdgeInsets[@(mode)] = [NSValue valueWithUIEdgeInsets:contentEdgeInsets];
  if (type == self.type && mode == self.mode) {
    [self updateType];
  }
}

- (void)setHitAreaInsets:(UIEdgeInsets)insets
                 forType:(MDCFloatingButtonType)type
                    mode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToHitAreaInsets = self.typeToModeToHitAreaInsets[@(self.type)];
  if (!modeToHitAreaInsets) {
    modeToHitAreaInsets = [@{} mutableCopy];
    self.typeToModeToHitAreaInsets[@(self.type)] = modeToHitAreaInsets;
  }
  modeToHitAreaInsets[@(mode)] = [NSValue valueWithUIEdgeInsets:insets];
  if (type == self.type && mode == self.mode) {
    [self updateType];
  }
}

- (void)setMode:(MDCFloatingButtonMode)mode {
  _mode = mode;
  [self updateType];
}

- (CGSize)minimumSizeForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMinimumSize = self.typetoModeToMinimumSize[@(self.type)];
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

- (CGSize)maximumSizeForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToMaximumSize = self.typeToModeToMaximumSize[@(self.type)];
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

  BOOL sizeChanged = !CGSizeEqualToSize(newSize, CGSizeZero)
      && ((newSize.width < self.maximumSize.width) || (newSize.height < self.maximumSize.height));
  super.maximumSize = newSize;
  if (sizeChanged) {
    [self invalidateIntrinsicContentSize];
  }
  return sizeChanged;
}

- (UIEdgeInsets)contentEdgeInsetsForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToContentEdgeInsets = self.typeToModeToContentEdgeInsets[@(self.type)];
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

- (UIEdgeInsets)hitAreaInsetsForMode:(MDCFloatingButtonMode)mode {
  NSMutableDictionary *modeToHitAreaInsets = self.typeToModeToHitAreaInsets[@(self.type)];
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

- (void)updateType {
  BOOL needsLayout = [self updateMinimumSize];
  needsLayout |= [self updateMaximumSize];
  [self updateContentEdgeInsets];
  [self updateHitAreaInsets];
  if (needsLayout) {
    [self sizeToFit];
  }
}

#pragma mark - Deprecations


+ (instancetype)floatingButtonWithShape:(MDCFloatingButtonType)type {
  return [[[self class] alloc] initWithFrame:CGRectZero type:type];
}

+ (instancetype)buttonWithShape:(MDCFloatingButtonType)type {
  return [[[self class] alloc] initWithFrame:CGRectZero type:type];
}

@end
