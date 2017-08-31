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
  }
  return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _shape = [aDecoder decodeIntegerForKey:MDCFloatingButtonShapeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_shape forKey:MDCFloatingButtonShapeKey];
}

#pragma mark - UIView

- (CGSize)sizeThatFits:(__unused CGSize)size {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake([[self class] miniDimension], [[self class] miniDimension]);
    case MDCFloatingButtonShapeLargeIcon:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
  }
}

- (CGSize)intrinsicContentSize {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake([[self class] miniDimension], [[self class] miniDimension]);
    case MDCFloatingButtonShapeLargeIcon:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
  }
}

#pragma mark - Subclassing

- (UIBezierPath *)boundingPath {
  return [UIBezierPath bezierPathWithOvalInRect:self.bounds];
}

- (CGFloat)cornerRadius {
  return CGRectGetWidth(self.bounds) / 2;
}

- (UIEdgeInsets)defaultContentEdgeInsets {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return UIEdgeInsetsMake(16, 16, 16, 16);
    case MDCFloatingButtonShapeMini:
      return UIEdgeInsetsMake(8, 8, 8, 8);
    case MDCFloatingButtonShapeLargeIcon:
      return UIEdgeInsetsMake(10, 10, 10, 10);
  }
}

- (UIEdgeInsets)defaultHitAreaInsets {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return UIEdgeInsetsZero;
    case MDCFloatingButtonShapeMini:
      // Increase the touch target from (40, 40) to the minimum (48, 48)
      return UIEdgeInsetsMake(-4, -4, -4, -4);
    case MDCFloatingButtonShapeLargeIcon:
      return UIEdgeInsetsZero;
  }
}

#pragma mark - Deprecations

+ (instancetype)buttonWithShape:(MDCFloatingButtonShape)shape {
  return [[self class] floatingButtonWithShape:shape];
}

@end
