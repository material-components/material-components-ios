/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCThumbView.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"

@interface MDCThumbView ()

@property(nonatomic, strong) UIImageView *iconView;

@end

@implementation MDCThumbView

static const CGFloat kMinTouchSize = 48;

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // TODO: Remove once MDCShadowLayer is rasterized by default.
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
  }
  return self;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
  _borderWidth = borderWidth;
  self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (void)setHasShadow:(BOOL)hasShadow {
  _hasShadow = hasShadow;
  self.elevation = hasShadow ? MDCShadowElevationCardResting : MDCShadowElevationNone;
}

- (MDCShadowElevation)elevation {
  return [self shadowLayer].elevation;
}

- (void)setElevation:(MDCShadowElevation)elevation {
  [self shadowLayer].elevation = elevation;
}

- (MDCShadowLayer *)shadowLayer {
  return (MDCShadowLayer *)self.layer;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath =
      [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius].CGPath;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(__unused UIEvent *)event {
  CGFloat dx = MIN(0, _cornerRadius - kMinTouchSize / 2);
  // Converts point to presentation layer coordinate system so gesture will land on the right visual
  // position. Assuming superview is not animated.
  if (self.layer.presentationLayer) {
    point = [(CALayer *)self.layer.presentationLayer convertPoint:point
                                                        fromLayer:self.layer.modelLayer];
  }
  CGRect rect = CGRectInset(self.bounds, dx, dx);
  return CGRectContainsPoint(rect, point);
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

@end
