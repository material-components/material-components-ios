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

+ (CGFloat)defaultDimension {
  return MDCFloatingButtonDefaultDimension;
}

+ (CGFloat)miniDimension {
  return MDCFloatingButtonMiniDimension;
}

+ (instancetype)floatingButtonWithShape:(MDCFloatingButtonShape)shape {
  return [[[self class] alloc] initWithFrame:CGRectZero shape:shape];
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

- (CGSize)sizeThatFits:(CGSize)size {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake([[self class] miniDimension], [[self class] miniDimension]);
  }
}

- (CGSize)intrinsicContentSize {
  switch (_shape) {
    case MDCFloatingButtonShapeDefault:
      return CGSizeMake([[self class] defaultDimension], [[self class] defaultDimension]);
    case MDCFloatingButtonShapeMini:
      return CGSizeMake([[self class] miniDimension], [[self class] miniDimension]);
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
  }
}

- (CGFloat)defaultElevationForState:(UIControlState)state {
  return (((state & UIControlStateSelected) == UIControlStateSelected)
              ? MDCShadowElevationFABPressed
              : MDCShadowElevationFABResting);
}

#pragma mark - Deprecations

+ (instancetype)buttonWithShape:(MDCFloatingButtonShape)shape {
  return [[self class] floatingButtonWithShape:shape];
}

@end
