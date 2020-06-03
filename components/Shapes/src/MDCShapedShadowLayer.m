// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCShapedShadowLayer.h"

#import "MDCShapeGenerating.h"
#import "MaterialColor.h"

@implementation MDCShapedShadowLayer

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCShapedShadowLayerInit];
  }
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCShapedShadowLayerInit];
  }
  return self;
}

- (instancetype)initWithLayer:(id)layer {
  self = [super initWithLayer:layer];
  if (self && [self isKindOfClass:[MDCShapedShadowLayer class]]) {
    MDCShapedShadowLayer *otherLayer = (MDCShapedShadowLayer *)layer;

    _shapeGenerator = [otherLayer.shapeGenerator copyWithZone:NULL];
    // We don't need to copy fillColor because that gets copied by [super initWithLayer:].

    // [CALayer initWithLayer:] copies all sublayers, so we have to manually fetch our CAShapeLayer.
    CALayer *sublayer = [[self sublayers] firstObject];
    if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
      _colorLayer = (CAShapeLayer *)sublayer;
    }
  }
  return self;
}

- (void)commonMDCShapedShadowLayerInit {
  self.backgroundColor = [UIColor clearColor].CGColor;
  _colorLayer = [CAShapeLayer layer];
  _colorLayer.delegate = self;
  _shapeLayer = [CAShapeLayer layer];
  [self addSublayer:_colorLayer];
}

- (void)layoutSublayers {
  [super layoutSublayers];

  CGRect bounds = self.bounds;
  CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  _colorLayer.position = center;
  _colorLayer.bounds = bounds;
}

- (void)prepareShadowPath {
  if (self.shapeGenerator) {
    CGRect standardizedBounds = CGRectStandardize(self.bounds);
    self.path = [self.shapeGenerator pathForSize:standardizedBounds.size];
  }
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator {
  _shapeGenerator = shapeGenerator;

  CGRect standardizedBounds = CGRectStandardize(self.bounds);
  self.path = [self.shapeGenerator pathForSize:standardizedBounds.size];
}

- (void)setPath:(CGPathRef)path {
  self.shadowPath = path;
  _colorLayer.path = path;
  _shapeLayer.path = path;

  if (CGPathIsEmpty(path)) {
    self.backgroundColor = self.shapedBackgroundColor.CGColor;
    self.borderColor = self.shapedBorderColor.CGColor;
    self.borderWidth = self.shapedBorderWidth;

    _colorLayer.fillColor = nil;
    _colorLayer.strokeColor = nil;
    _colorLayer.lineWidth = 0;
  } else {
    self.backgroundColor = nil;
    self.borderColor = nil;
    self.borderWidth = 0;

    _colorLayer.fillColor = self.shapedBackgroundColor.CGColor;
    _colorLayer.strokeColor = self.shapedBorderColor.CGColor;
    _colorLayer.lineWidth = self.shapedBorderWidth;
  }
}

- (CGPathRef)path {
  return _colorLayer.path;
}

- (void)setShapedBackgroundColor:(UIColor *)shapedBackgroundColor {
  _shapedBackgroundColor = shapedBackgroundColor;

  if ([self.delegate isKindOfClass:[UIView class]]) {
    UIView *view = (UIView *)self.delegate;
    _shapedBackgroundColor =
        [_shapedBackgroundColor mdc_resolvedColorWithTraitCollection:view.traitCollection];
  }

  if (CGPathIsEmpty(self.path)) {
    self.backgroundColor = _shapedBackgroundColor.CGColor;
    _colorLayer.fillColor = nil;
  } else {
    self.backgroundColor = nil;
    _colorLayer.fillColor = _shapedBackgroundColor.CGColor;
  }
}

- (void)setShapedBorderColor:(UIColor *)shapedBorderColor {
  _shapedBorderColor = shapedBorderColor;

  if ([self.delegate isKindOfClass:[UIView class]]) {
    UIView *view = (UIView *)self.delegate;
    _shapedBorderColor =
        [_shapedBorderColor mdc_resolvedColorWithTraitCollection:view.traitCollection];
  }
  if (CGPathIsEmpty(self.path)) {
    self.borderColor = _shapedBorderColor.CGColor;
    _colorLayer.strokeColor = nil;
  } else {
    self.borderColor = nil;
    _colorLayer.strokeColor = _shapedBorderColor.CGColor;
  }
}

- (void)setShapedBorderWidth:(CGFloat)shapedBorderWidth {
  _shapedBorderWidth = shapedBorderWidth;

  if (CGPathIsEmpty(self.path)) {
    self.borderWidth = _shapedBorderWidth;
    _colorLayer.lineWidth = 0;
  } else {
    self.borderWidth = 0;
    _colorLayer.lineWidth = _shapedBorderWidth;
  }
}

@end
