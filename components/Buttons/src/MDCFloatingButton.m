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
static NSString *const MDCFloatingButtonShapeKey = @"MDCFloatingButtonShapeKey";
static NSString *const MDCFloatingButtonMinimumSizeDictionaryKey
    = @"MDCFloatingButtonMinimumSizeDictionaryKey";
static NSString *const MDCFloatingButtonMaximumSizeDictionaryKey
    = @"MDCFloatingButtonMaximumSizeDictionaryKey";
static NSString *const MDCFloatingButtonContentEdgeInsetsDictionaryKey
    = @"MDCFloatingButtonContentEdgeInsetsDictionaryKey";
static NSString *const MDCFloatingButtonHitAreaInsetsDictionaryKey
    = @"MDCFloatingButtonHitAreaInsetsDictionaryKey";

@interface MDCFloatingButton ()
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToHitAreaInsets;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToMinimumSize;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToMaximumSize;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToContentEdgeInsets;
@end

@implementation MDCFloatingButton

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
    [self commonMDCFloatingButtonInit];
    [self updateShape];
  }
  return self;
}

- (void)commonMDCFloatingButtonInit {
  _shapeToMinimumSize = [NSMutableDictionary dictionaryWithCapacity:5];
  self.shapeToMinimumSize[@(MDCFloatingButtonShapeDefault)]
      = [NSValue valueWithCGSize:CGSizeMake(56, 56)];
  self.shapeToMinimumSize[@(MDCFloatingButtonShapeMini)]
      = [NSValue valueWithCGSize:CGSizeMake(40, 40)];
  self.shapeToMinimumSize[@(MDCFloatingButtonShapeExtendedLeadingIcon)]
      = [NSValue valueWithCGSize:CGSizeMake(132, 48)];
  self.shapeToMinimumSize[@(MDCFloatingButtonShapeExtendedTrailingIcon)]
      = [NSValue valueWithCGSize:CGSizeMake(132, 48)];
  _shapeToMaximumSize = [NSMutableDictionary dictionaryWithCapacity:5];
  self.shapeToMaximumSize[@(MDCFloatingButtonShapeDefault)]
      = [NSValue valueWithCGSize:CGSizeMake(56, 56)];
  self.shapeToMaximumSize[@(MDCFloatingButtonShapeMini)]
      = [NSValue valueWithCGSize:CGSizeMake(40, 40)];
  self.shapeToMaximumSize[@(MDCFloatingButtonShapeExtendedLeadingIcon)]
      = [NSValue valueWithCGSize:CGSizeMake(328, 0)];
  self.shapeToMaximumSize[@(MDCFloatingButtonShapeExtendedTrailingIcon)]
      = [NSValue valueWithCGSize:CGSizeMake(328, 0)];
  _shapeToContentEdgeInsets = [NSMutableDictionary dictionaryWithCapacity:5];
  self.shapeToContentEdgeInsets[@(MDCFloatingButtonShapeDefault)]
      = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
  self.shapeToContentEdgeInsets[@(MDCFloatingButtonShapeExtendedLeadingIcon)]
      = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 24)];
  self.shapeToContentEdgeInsets[@(MDCFloatingButtonShapeExtendedTrailingIcon)]
      = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 24, 0, 16)];
  _shapeToHitAreaInsets = [NSMutableDictionary dictionaryWithCapacity:5];
  self.shapeToHitAreaInsets[@(MDCFloatingButtonShapeDefault)]
      = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
  self.shapeToHitAreaInsets[@(MDCFloatingButtonShapeMini)]
      = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(-4, -4, -4, -4)];

  super.contentEdgeInsets = [self defaultContentEdgeInsets];
  super.hitAreaInsets = [self defaultHitAreaInsets];
  _imageTitlePadding = 8;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFloatingButtonInit];
    _shape = [aDecoder decodeIntegerForKey:MDCFloatingButtonShapeKey];
    if ([aDecoder containsValueForKey:MDCFloatingButtonMinimumSizeDictionaryKey]) {
      _shapeToMinimumSize = [aDecoder decodeObjectForKey:MDCFloatingButtonMinimumSizeDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonMaximumSizeDictionaryKey]) {
      _shapeToMaximumSize = [aDecoder decodeObjectForKey:MDCFloatingButtonMaximumSizeDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonContentEdgeInsetsDictionaryKey]) {
      _shapeToContentEdgeInsets
          = [aDecoder decodeObjectForKey:MDCFloatingButtonContentEdgeInsetsDictionaryKey];
    }
    if ([aDecoder containsValueForKey:MDCFloatingButtonHitAreaInsetsDictionaryKey]) {
      _shapeToHitAreaInsets
          = [aDecoder decodeObjectForKey:MDCFloatingButtonHitAreaInsetsDictionaryKey];
    }
    [self updateShape];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:self.shape forKey:MDCFloatingButtonShapeKey];
  [aCoder encodeObject:self.shapeToMinimumSize forKey:MDCFloatingButtonMinimumSizeDictionaryKey];
  [aCoder encodeObject:self.shapeToMaximumSize forKey:MDCFloatingButtonMaximumSizeDictionaryKey];
  [aCoder encodeObject:self.shapeToContentEdgeInsets
                forKey:MDCFloatingButtonContentEdgeInsetsDictionaryKey];
  [aCoder encodeObject:self.shapeToHitAreaInsets
                forKey:MDCFloatingButtonHitAreaInsetsDictionaryKey];
}

#pragma mark - UIView

- (CGSize)intrinsicContentSize {
  NSLog(@"intrinsicContentSize");
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake([[self class] miniDimension], [[self class] miniDimension]);
    case MDCFloatingButtonShapeLargeIcon:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeExtendedTrailingIcon:
    case MDCFloatingButtonShapeExtendedLeadingIcon: {
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
  }
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
  NSLog(@"sizeThaTFits:");
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
  NSLog(@"Layout");
  // We have to set cornerRadius before laying out subviews so that the boundingPath is correct.
  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
  [super layoutSubviews];

  if (self.shape == MDCFloatingButtonShapeDefault
      || self.shape == MDCFloatingButtonShapeMini
      || self.shape == MDCFloatingButtonShapeLargeIcon) {
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

  const CGRect insetBounds = UIEdgeInsetsInsetRect(self.bounds, self.contentEdgeInsets);
  const CGFloat imageViewWidth = CGRectGetWidth(self.imageView.bounds);
  const CGFloat boundsCenterY = CGRectGetMidY(insetBounds);
  CGFloat titleWidthAvailable = CGRectGetWidth(insetBounds);
  titleWidthAvailable -= imageViewWidth;
  titleWidthAvailable -= self.imageTitlePadding;

  const CGFloat availableHeight = CGRectGetHeight(insetBounds);
  CGSize titleIntrinsicSize
      = [self.titleLabel sizeThatFits:CGSizeMake(titleWidthAvailable, availableHeight)];

  const CGSize titleSize = CGSizeMake(MIN(titleIntrinsicSize.width, titleWidthAvailable),
                                      MIN(titleIntrinsicSize.height, availableHeight));

  BOOL isRTL = self.mdf_effectiveUserInterfaceLayoutDirection
      == UIUserInterfaceLayoutDirectionRightToLeft;
  BOOL isLeadingIcon = self.shape == MDCFloatingButtonShapeExtendedLeadingIcon;

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
  self.titleLabel.center = titleCenter;
  self.titleLabel.bounds = (CGRect){CGRectStandardize(self.titleLabel.bounds).origin, titleSize};
  self.titleLabel.frame = UIEdgeInsetsInsetRect(self.titleLabel.frame, self.titleEdgeInsets);

}

#pragma mark - Subclassing

- (UIEdgeInsets)defaultContentEdgeInsets {
  NSValue *insetsValue = self.shapeToContentEdgeInsets[@(self.shape)];
  if (!insetsValue && self.shape != MDCFloatingButtonShapeDefault) {
    insetsValue = self.shapeToContentEdgeInsets[@(MDCFloatingButtonShapeDefault)];
  }

  if (insetsValue) {
    return [insetsValue UIEdgeInsetsValue];
  } else {
    return UIEdgeInsetsZero;
  }
}

- (UIEdgeInsets)defaultHitAreaInsets {
  NSValue *insetsValue = self.shapeToHitAreaInsets[@(self.shape)];
  if (!insetsValue && self.shape != MDCFloatingButtonShapeDefault) {
    insetsValue = self.shapeToHitAreaInsets[@(MDCFloatingButtonShapeDefault)];
  }

  if (insetsValue) {
    return [insetsValue UIEdgeInsetsValue];
  } else {
    return UIEdgeInsetsZero;
  }
}

#pragma mark - Extended FAB changes
- (void)setMinimumSize:(__unused CGSize)size {
  NSAssert(NO, @"Not available. Use setMinimumSize:forShape: instead");
}

- (void)setMinimumSize:(CGSize)size forShape:(MDCFloatingButtonShape)shape {
  self.shapeToMinimumSize[@(shape)] = [NSValue valueWithCGSize:size];
  if (shape == self.shape) {
    [self updateShape];
  }
}

- (void)setMaximumSize:(__unused CGSize)size {
  NSAssert(NO, @"Not available. Use setMaximumSize:forShape: instead");
}

- (void)setMaximumSize:(CGSize)size forShape:(MDCFloatingButtonShape)shape {
  self.shapeToMaximumSize[@(shape)] = [NSValue valueWithCGSize:size];
  if (shape == self.shape) {
    [self updateShape];
  }
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets forShape:(MDCFloatingButtonShape)shape {
  self.shapeToContentEdgeInsets[@(shape)] = [NSValue valueWithUIEdgeInsets:contentEdgeInsets];
  if (shape == self.shape) {
    [self updateShape];
  }
}

- (void)setHitAreaInsets:(UIEdgeInsets)insets forShape:(MDCFloatingButtonShape)shape {
  self.shapeToHitAreaInsets[@(shape)] = [NSValue valueWithUIEdgeInsets:insets];
  if (shape == self.shape) {
    [self updateShape];
  }
}

- (void)setShape:(MDCFloatingButtonShape)shape {
  _shape = shape;
  [self updateShape];
}

- (BOOL)updateMinimumSize {
  NSValue *sizeValue = self.shapeToMinimumSize[@(self.shape)];
  if (!sizeValue && self.shape != MDCFloatingButtonShapeDefault) {
    sizeValue = self.shapeToMinimumSize[@(MDCFloatingButtonShapeDefault)];
  }

  CGSize newSize = CGSizeZero;
  if (sizeValue) {
    newSize = [sizeValue CGSizeValue];
  }

  BOOL sizeChanged = (newSize.width > self.minimumSize.width)
      || (newSize.height > self.minimumSize.height);
  super.minimumSize = newSize;
  if (sizeChanged) {
    [self invalidateIntrinsicContentSize];
  }
  return sizeChanged;
}

- (BOOL)updateMaximumSize {
  NSValue *sizeValue = self.shapeToMaximumSize[@(self.shape)];
  if (!sizeValue && self.shape != MDCFloatingButtonShapeDefault) {
    sizeValue = self.shapeToMaximumSize[@(MDCFloatingButtonShapeDefault)];
  }

  CGSize newSize = CGSizeZero;
  if (sizeValue) {
    newSize = [sizeValue CGSizeValue];
  }

  BOOL sizeChanged = !CGSizeEqualToSize(newSize, CGSizeZero)
      && ((newSize.width < self.maximumSize.width) || (newSize.height < self.maximumSize.height));
  super.maximumSize = newSize;
  if (sizeChanged) {
    [self invalidateIntrinsicContentSize];
  }
  return sizeChanged;
}

- (UIEdgeInsets)insetsForShape:(MDCFloatingButtonShape)shape {
  NSValue *insetsValue = self.shapeToContentEdgeInsets[@(shape)];
  if (!insetsValue && shape != MDCFloatingButtonShapeDefault) {
    insetsValue = self.shapeToContentEdgeInsets[@(MDCFloatingButtonShapeDefault)];
  }

  if (insetsValue) {
    return insetsValue.UIEdgeInsetsValue;
  } else {
    return UIEdgeInsetsZero;
  }
}

- (void)updateContentEdgeInsets {
  super.contentEdgeInsets = [self insetsForShape:self.shape];
}

- (void)updateHitAreaInsets {
  NSValue *insetsValue = self.shapeToHitAreaInsets[@(self.shape)];
  if (!insetsValue && self.shape != MDCFloatingButtonShapeDefault) {
    insetsValue = self.shapeToHitAreaInsets[@(MDCFloatingButtonShapeDefault)];
  }

  if (insetsValue) {
    super.hitAreaInsets = [insetsValue UIEdgeInsetsValue];
  }
}

- (void)updateShape {
  BOOL needsLayout = [self updateMinimumSize];
  needsLayout |= [self updateMaximumSize];
  [self updateContentEdgeInsets];
  [self updateHitAreaInsets];
  if (needsLayout) {
    [self sizeToFit];
  }
}

#pragma mark - Deprecations

+ (instancetype)buttonWithShape:(MDCFloatingButtonShape)shape {
  return [[self class] floatingButtonWithShape:shape];
}

@end
