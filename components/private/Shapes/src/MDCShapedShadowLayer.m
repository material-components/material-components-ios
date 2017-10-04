/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCShapedShadowLayer.h"

#import "MDCShapeGenerating.h"

@implementation MDCShapedShadowLayer {
  CAShapeLayer *_colorLayer;
}

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

- (void)layoutSublayers {
  // We have to set the path before calling [super layoutSublayers] because we need the shadowPath
  // to be correctly set before MDCShadowLayer performs layoutSublayers.
  CGRect standardizedBounds = CGRectStandardize(self.bounds);
  self.path = [self.shapeGenerator pathForSize:standardizedBounds.size];

  [super layoutSublayers];

  CGRect bounds = self.bounds;
  CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  _colorLayer.position = center;
  _colorLayer.bounds = bounds;
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator {
  _shapeGenerator = shapeGenerator;

  CGRect standardizedBounds = CGRectStandardize(self.bounds);
  self.path = [self.shapeGenerator pathForSize:standardizedBounds.size];
}

- (void)setPath:(CGPathRef)path {
  self.shadowPath = path;
  _colorLayer.path = path;
}

- (CGPathRef)path {
  return _colorLayer.path;
}

- (void)setFillColor:(CGColorRef)fillColor {
  _colorLayer.fillColor = fillColor;
}

- (CGColorRef)fillColor {
  return _colorLayer.fillColor;
}

- (void)commonMDCShapedShadowLayerInit {
  self.backgroundColor = [UIColor clearColor].CGColor;
  _colorLayer = [CAShapeLayer layer];
  [self addSublayer:_colorLayer];
}

@end
