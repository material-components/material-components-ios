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

static const CGFloat MDCFloatingButtonDefaultDimension = 56.0f;
static const CGFloat MDCFloatingButtonMiniDimension = 40.0f;
static NSString *const MDCFloatingButtonShapeKey = @"MDCFloatingButtonShapeKey";
static NSString *const MDCFloatingButtonMinimumSizeDictionaryKey
    = @"MDCFloatingButtonMinimumSizeDictionaryKey";
static NSString *const MDCFloatingButtonMaximumSizeDictionaryKey
    = @"MDCFloatingButtonMaximumSizeDictionaryKey";
static NSString *const MDCFloatingButtonContentEdgeInsetsDictionaryKey
    = @"MDCFloatingButtonContentEdgeInsetsDictionaryKey";

@interface MDCFloatingButton ()
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToHitAreaInsets;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToMinimumSize;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToMaximumSize;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, NSValue *> *shapeToContentEdgeInsets;
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
    super.contentEdgeInsets = [self defaultContentEdgeInsets];
    super.hitAreaInsets = [self defaultHitAreaInsets];
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
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
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
}

#pragma mark - UIView

- (CGSize)intrinsicContentSize {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake([[self class] miniDimension], [[self class] miniDimension]);
    case MDCFloatingButtonShapeLargeIcon:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeExtendedTrailingIcon:
    case MDCFloatingButtonShapeExtendedLeadingIcon:
      return [super intrinsicContentSize];
  }
}

- (void)layoutSubviews {
  // We have to set cornerRadius before laying out subviews so that the boundingPath is correct.
  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
  [super layoutSubviews];
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

- (void)updateMinimumSize {
  NSValue *sizeValue = self.shapeToMinimumSize[@(self.shape)];
  if (!sizeValue && self.shape != MDCFloatingButtonShapeDefault) {
    sizeValue = self.shapeToMinimumSize[@(MDCFloatingButtonShapeDefault)];
  }

  if (sizeValue) {
    super.minimumSize = [sizeValue CGSizeValue];
  } else {
    super.minimumSize = CGSizeZero;
  }
}

- (void)updateMaximumSize {
  NSValue *sizeValue = self.shapeToMaximumSize[@(self.shape)];
  if (!sizeValue && self.shape != MDCFloatingButtonShapeDefault) {
    sizeValue = self.shapeToMaximumSize[@(MDCFloatingButtonShapeDefault)];
  }

  if (sizeValue) {
    super.maximumSize = [sizeValue CGSizeValue];
  } else {
    super.maximumSize = CGSizeZero;
  }
}

- (void)updateContentEdgeInsets {
  NSValue *insetsValue = self.shapeToContentEdgeInsets[@(self.shape)];
  if (!insetsValue && self.shape != MDCFloatingButtonShapeDefault) {
    insetsValue = self.shapeToContentEdgeInsets[@(MDCFloatingButtonShapeDefault)];
  }

  if (insetsValue) {
    super.contentEdgeInsets = insetsValue.UIEdgeInsetsValue;
  } else {
    super.contentEdgeInsets = UIEdgeInsetsZero;
  }
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
  [self updateMinimumSize];
  [self updateMaximumSize];
  [self updateContentEdgeInsets];
}

#pragma mark - Deprecations

+ (instancetype)buttonWithShape:(MDCFloatingButtonShape)shape {
  return [[self class] floatingButtonWithShape:shape];
}

@end
