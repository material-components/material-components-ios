// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCThumbView.h"

#import "MaterialShadowElevations.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"

@interface MDCThumbView ()

@property(nonatomic, strong) UIImageView *iconView;
// The shape generator used to define the shape of the thumb view.
@property(nullable, nonatomic, strong) MDCRectangleShapeGenerator *shapeGenerator;
@property(nonatomic, readonly, strong) MDCShapedShadowLayer *layer;

@end

@implementation MDCThumbView

@dynamic layer;

+ (Class)layerClass {
  return [MDCShapedShadowLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // TODO: Remove once MDCShadowLayer is rasterized by default.
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;

    _shadowColor = UIColor.blackColor;
    _shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
    self.layer.shadowColor = _shadowColor.CGColor;
    self.layer.shapeGenerator = _shapeGenerator;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self configureShapeGeneratorWithCornerRadius:self.cornerRadius
                              centerVisibleArea:self.centerVisibleArea];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
  self.layer.shapedBorderWidth = borderWidth;
}

- (CGFloat)borderWidth {
  return self.layer.shapedBorderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
  self.layer.shapedBorderColor = borderColor;
}

- (UIColor *)borderColor {
  return self.layer.shapedBorderColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  if (cornerRadius == _cornerRadius) {
    return;
  }
  _cornerRadius = cornerRadius;

  [self configureShapeGeneratorWithCornerRadius:cornerRadius
                              centerVisibleArea:self.centerVisibleArea];

  [self setNeedsLayout];
}

- (void)setCenterVisibleArea:(BOOL)centerVisibleArea {
  if (centerVisibleArea == _centerVisibleArea) {
    return;
  }
  _centerVisibleArea = centerVisibleArea;

  [self configureShapeGeneratorWithCornerRadius:self.cornerRadius
                              centerVisibleArea:centerVisibleArea];

  [self setNeedsLayout];
}

- (void)configureShapeGeneratorWithCornerRadius:(CGFloat)cornerRadius
                              centerVisibleArea:(BOOL)centerVisibleArea {
  MDCCornerTreatment *cornerTreatment =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:cornerRadius];
  [self.shapeGenerator setCorners:cornerTreatment];

  if (centerVisibleArea) {
    UIEdgeInsets visibleAreaInsets = UIEdgeInsetsZero;
    CGSize visibleAreaSize = CGSizeMake(cornerRadius * 2, cornerRadius * 2);
    CGFloat additionalRequiredHeight =
        MAX(0, CGRectGetHeight(self.bounds) - visibleAreaSize.height);
    CGFloat additionalRequiredWidth = MAX(0, CGRectGetWidth(self.bounds) - visibleAreaSize.width);
    visibleAreaInsets.top = ceil(additionalRequiredHeight * 0.5f);
    visibleAreaInsets.bottom = additionalRequiredHeight - visibleAreaInsets.top;
    visibleAreaInsets.left = ceil(additionalRequiredWidth * 0.5f);
    visibleAreaInsets.right = additionalRequiredWidth - visibleAreaInsets.left;

    self.shapeGenerator.topLeftCornerOffset =
        CGPointMake(visibleAreaInsets.left, visibleAreaInsets.top);
    self.shapeGenerator.topRightCornerOffset =
        CGPointMake(-visibleAreaInsets.right, visibleAreaInsets.top);
    self.shapeGenerator.bottomLeftCornerOffset =
        CGPointMake(visibleAreaInsets.left, -visibleAreaInsets.bottom);
    self.shapeGenerator.bottomRightCornerOffset =
        CGPointMake(-visibleAreaInsets.right, -visibleAreaInsets.bottom);
  }
}

- (MDCShadowElevation)elevation {
  return self.layer.elevation;
}

- (void)setElevation:(MDCShadowElevation)elevation {
  self.layer.elevation = elevation;
}

- (void)setIcon:(nullable UIImage *)icon {
  if (icon == _iconView.image || [icon isEqual:_iconView.image])
    return;

  if (_iconView) {
    [_iconView removeFromSuperview];
    _iconView = nil;
  }
  if (icon) {
    _iconView = [[UIImageView alloc] initWithImage:icon];
    [self addSubview:_iconView];
    // Calculate the inner square of the thumbs circle.
    CGFloat sideLength = (CGFloat)sin(45.0 / 180.0 * M_PI) * _cornerRadius * 2;
    CGFloat topLeft = _cornerRadius - (sideLength / 2);
    _iconView.frame = CGRectMake(topLeft, topLeft, sideLength, sideLength);
  }
}

- (void)setShadowColor:(UIColor *)shadowColor {
  _shadowColor = shadowColor;
  self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  self.layer.shapedBackgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return self.layer.shapedBackgroundColor;
}

@end
