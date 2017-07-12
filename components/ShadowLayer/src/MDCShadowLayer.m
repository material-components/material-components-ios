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

#import "MDCShadowLayer.h"

static const CGFloat kShadowElevationDialog = 24.0;
static const float kKeyShadowOpacity = 0.26f;
static const float kAmbientShadowOpacity = 0.08f;

static NSString *const MDCShadowLayerElevationKey = @"MDCShadowLayerElevationKey";
static NSString *const MDCShadowLayerShadowMaskEnabledKey = @"MDCShadowLayerShadowMaskEnabledKey";

@implementation MDCShadowMetrics

+ (MDCShadowMetrics *)metricsWithElevation:(CGFloat)elevation {
  if (0.0 < elevation) {
    return [[MDCShadowMetrics alloc] initWithElevation:elevation];
  } else {
    return [MDCShadowMetrics emptyShadowMetrics];
  }
}

- (MDCShadowMetrics *)initWithElevation:(CGFloat)elevation {
  self = [super init];
  if (self) {
    _topShadowRadius = [MDCShadowMetrics ambientShadowBlur:elevation];
    _topShadowOffset = CGSizeMake(0.0, 0.0);
    _topShadowOpacity = kAmbientShadowOpacity;
    _bottomShadowRadius = [MDCShadowMetrics keyShadowBlur:elevation];
    _bottomShadowOffset = CGSizeMake(0.0, [MDCShadowMetrics keyShadowYOff:elevation]);
    _bottomShadowOpacity = kKeyShadowOpacity;
  }
  return self;
}

+ (MDCShadowMetrics *)emptyShadowMetrics {
  static MDCShadowMetrics *emptyShadowMetrics;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    emptyShadowMetrics = [[MDCShadowMetrics alloc] init];
    emptyShadowMetrics->_topShadowRadius = (CGFloat)0.0;
    emptyShadowMetrics->_topShadowOffset = CGSizeMake(0.0, 0.0);
    emptyShadowMetrics->_topShadowOpacity = 0.0f;
    emptyShadowMetrics->_bottomShadowRadius = (CGFloat)0.0;
    emptyShadowMetrics->_bottomShadowOffset = CGSizeMake(0.0, 0.0);
    emptyShadowMetrics->_bottomShadowOpacity = 0.0f;
  });

  return emptyShadowMetrics;
}

+ (CGFloat)ambientShadowBlur:(CGFloat)points {
  CGFloat blur = 0.889544f * points - 0.003701f;
  return blur;
}

+ (CGFloat)keyShadowBlur:(CGFloat)points {
  CGFloat blur = 0.666920f * points - 0.001648f;
  return blur;
}

+ (CGFloat)keyShadowYOff:(CGFloat)points {
  CGFloat yOff = 1.23118f * points - 0.03933f;
  return yOff;
}

@end

@interface MDCShadowLayer ()

@property(nonatomic, strong) CAShapeLayer *topShadow;
@property(nonatomic, strong) CAShapeLayer *bottomShadow;

@end

@implementation MDCShadowLayer

- (instancetype)init {
  self = [super init];
  if (self) {
    _elevation = 0;
    _shadowMaskEnabled = YES;

    [self commonMDCShadowLayerInit];
  }
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    if ([aDecoder containsValueForKey:MDCShadowLayerElevationKey]) {
      _elevation = (CGFloat)[aDecoder decodeDoubleForKey:MDCShadowLayerElevationKey];
    }
    if ([aDecoder containsValueForKey:MDCShadowLayerShadowMaskEnabledKey]) {
      _shadowMaskEnabled = [aDecoder decodeBoolForKey:MDCShadowLayerShadowMaskEnabledKey];
    }

    [self commonMDCShadowLayerInit];
  }
  return self;
}

- (instancetype)initWithLayer:(id)layer {
  if (self = [super initWithLayer:layer]) {
    if ([layer isKindOfClass:[MDCShadowLayer class]]) {
      MDCShadowLayer *otherLayer = (MDCShadowLayer *)layer;
      _elevation = otherLayer.elevation;
      _shadowMaskEnabled = otherLayer.isShadowMaskEnabled;
      _bottomShadow = [[CAShapeLayer alloc] initWithLayer:otherLayer.bottomShadow];
      _topShadow = [[CAShapeLayer alloc] initWithLayer:otherLayer.topShadow];
      [self commonMDCShadowLayerInit];
    }
  }
  return self;
}

/**
 commonMDCShadowLayerInit creates additional layers based on the values of _elevation and
 _shadowMaskEnabled.
 */
- (void)commonMDCShadowLayerInit {
  if (!_bottomShadow) {
    _bottomShadow = [CAShapeLayer layer];
    _bottomShadow.backgroundColor = [UIColor clearColor].CGColor;
    _bottomShadow.shadowColor = [UIColor blackColor].CGColor;
    [self addSublayer:_bottomShadow];
  }

  if (!_topShadow) {
    _topShadow = [CAShapeLayer layer];
    _topShadow.backgroundColor = [UIColor clearColor].CGColor;
    _topShadow.shadowColor = [UIColor blackColor].CGColor;
    [self addSublayer:_topShadow];
  }

  // Setup shadow layer state based off _elevation and _shadowMaskEnabled
  MDCShadowMetrics *shadowMetrics = [MDCShadowMetrics metricsWithElevation:_elevation];
  _topShadow.shadowOffset = shadowMetrics.topShadowOffset;
  _topShadow.shadowRadius = shadowMetrics.topShadowRadius;
  _topShadow.shadowOpacity = shadowMetrics.topShadowOpacity;
  _bottomShadow.shadowOffset = shadowMetrics.bottomShadowOffset;
  _bottomShadow.shadowRadius = shadowMetrics.bottomShadowRadius;
  _bottomShadow.shadowOpacity = shadowMetrics.bottomShadowOpacity;

  // TODO(#1021): We shouldn't be calling property accessors in an init method.
  if (_shadowMaskEnabled) {
    _topShadow.mask = [self shadowLayerMaskForLayer:_topShadow];
    _bottomShadow.mask = [self shadowLayerMaskForLayer:_bottomShadow];
  }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeDouble:_elevation forKey:MDCShadowLayerElevationKey];
  [aCoder encodeBool:_shadowMaskEnabled forKey:MDCShadowLayerShadowMaskEnabledKey];
  // Additional state is calculated at deserialization time based on _elevation and
  // _shadowMaskEnabled so we don't need to store them.
}

- (void)layoutSublayers {
  [super layoutSublayers];
  [self commonLayoutSublayers];
}

- (void)setBounds:(CGRect)bounds {
  BOOL sizeChanged = !CGSizeEqualToSize(self.bounds.size, bounds.size);
  [super setBounds:bounds];
  if (sizeChanged) {
    // Invalidate our shadow paths.
    _bottomShadow.shadowPath = nil;
    _topShadow.shadowPath = nil;
    [self setNeedsLayout];
  }
}

#pragma mark - CALayer change monitoring.

/** Returns a shadowPath based on the layer properties. */
- (UIBezierPath *)defaultShadowPath {
  CGFloat cornerRadius = self.cornerRadius;
  if (0.0 < cornerRadius) {
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
  }
  return [UIBezierPath bezierPathWithRect:self.bounds];
}

- (void)setShadowPath:(CGPathRef)shadowPath {
  super.shadowPath = shadowPath;
  _topShadow.shadowPath = shadowPath;
  _bottomShadow.shadowPath = shadowPath;
  if (_shadowMaskEnabled) {
    _topShadow.mask = [self shadowLayerMaskForLayer:_topShadow];
    _bottomShadow.mask = [self shadowLayerMaskForLayer:_bottomShadow];
  }
}

- (void)setShadowColor:(CGColorRef)shadowColor {
  super.shadowColor = shadowColor;
  _topShadow.shadowColor = shadowColor;
  _bottomShadow.shadowColor = shadowColor;
}

#pragma mark - shouldRasterize forwarding

- (void)setShouldRasterize:(BOOL)shouldRasterize {
  [super setShouldRasterize:shouldRasterize];
  _topShadow.shouldRasterize = shouldRasterize;
  _bottomShadow.shouldRasterize = shouldRasterize;
}

#pragma mark - Shadow Spread

// Returns how far aware the shadow is spread from the edge of the layer.
+ (CGSize)shadowSpreadForElevation:(CGFloat)elevation {
  MDCShadowMetrics *metrics = [MDCShadowMetrics metricsWithElevation:elevation];

  CGSize shadowSpread = CGSizeZero;
  shadowSpread.width = MAX(metrics.topShadowRadius, metrics.bottomShadowRadius) +
                       MAX(metrics.topShadowOffset.width, metrics.bottomShadowOffset.width);
  shadowSpread.height = MAX(metrics.topShadowRadius, metrics.bottomShadowRadius) +
                        MAX(metrics.topShadowOffset.height, metrics.bottomShadowOffset.height);

  return shadowSpread;
}

#pragma mark - Pseudo Shadow Masks

- (void)setShadowMaskEnabled:(BOOL)shadowMaskEnabled {
  _shadowMaskEnabled = shadowMaskEnabled;
  if (_shadowMaskEnabled) {
    _topShadow.mask = [self shadowLayerMaskForLayer:_topShadow];
    _bottomShadow.mask = [self shadowLayerMaskForLayer:_bottomShadow];
  } else {
    _topShadow.mask = nil;
    _bottomShadow.mask = nil;
  }
}

// Creates a layer mask that has a hole cut inside so that the original contents
// of the view is no obscured by the shadow the top/bottom pseudo shadow layers
// cast.
- (CAShapeLayer *)shadowLayerMaskForLayer:(CALayer *)layer {
  CAShapeLayer *maskLayer = [CAShapeLayer layer];

  CGSize shadowSpread = [MDCShadowLayer shadowSpreadForElevation:kShadowElevationDialog];
  CGRect bounds = layer.bounds;
  CGRect maskRect = CGRectInset(bounds, -shadowSpread.width * 2, -shadowSpread.height * 2);

  UIBezierPath *path = [UIBezierPath bezierPathWithRect:maskRect];
  UIBezierPath *innerPath = nil;
  if (self.shadowPath != nil) {
    innerPath = [UIBezierPath bezierPathWithCGPath:(_Nonnull CGPathRef)self.shadowPath];
  } else if (self.cornerRadius > 0) {
    innerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
  } else {
    innerPath = [UIBezierPath bezierPathWithRect:self.bounds];
  }
  [path appendPath:innerPath];
  [path setUsesEvenOddFillRule:YES];

  maskLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  maskLayer.bounds = maskRect;
  maskLayer.path = path.CGPath;
  maskLayer.fillRule = kCAFillRuleEvenOdd;
  maskLayer.fillColor = [UIColor blackColor].CGColor;
  return maskLayer;
}

- (void)setElevation:(CGFloat)elevation {
  _elevation = elevation;
  MDCShadowMetrics *shadowMetrics = [MDCShadowMetrics metricsWithElevation:elevation];
  [self setMetrics:shadowMetrics];
}

- (void)setMetrics:(MDCShadowMetrics *)shadowMetrics {
  CABasicAnimation *topOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
  topOffsetAnimation.fromValue = nil;
  topOffsetAnimation.toValue = [NSValue valueWithCGSize:shadowMetrics.topShadowOffset];

  CABasicAnimation *bottomOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
  bottomOffsetAnimation.fromValue = nil;
  bottomOffsetAnimation.toValue = [NSValue valueWithCGSize:shadowMetrics.bottomShadowOffset];

  CABasicAnimation *topRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
  topRadiusAnimation.fromValue = nil;
  topRadiusAnimation.toValue = @(shadowMetrics.topShadowRadius);

  CABasicAnimation *bottomRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
  bottomRadiusAnimation.fromValue = nil;
  bottomRadiusAnimation.toValue = @(shadowMetrics.bottomShadowRadius);

  CABasicAnimation *topOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
  topOpacityAnimation.fromValue = nil;
  topOpacityAnimation.toValue = @(shadowMetrics.topShadowOpacity);

  CABasicAnimation *bottomOpacityAnimation =
      [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
  bottomOpacityAnimation.fromValue = nil;
  bottomOpacityAnimation.toValue = @(shadowMetrics.bottomShadowOpacity);

  // Group all animations together.
  CAAnimationGroup *topAnimations = [CAAnimationGroup animation];
  topAnimations.animations = @[ topOffsetAnimation, topRadiusAnimation, topOpacityAnimation ];

  CAAnimationGroup *bottomAnimations = [CAAnimationGroup animation];
  bottomAnimations.animations =
      @[ bottomOffsetAnimation, bottomRadiusAnimation, bottomOpacityAnimation ];

  [_topShadow removeAllAnimations];
  [_bottomShadow removeAllAnimations];
  [_topShadow addAnimation:topAnimations forKey:nil];
  [_bottomShadow addAnimation:bottomAnimations forKey:nil];

  // Set the final animation value in to the model layer.
  _topShadow.shadowOffset = shadowMetrics.topShadowOffset;
  _topShadow.shadowRadius = shadowMetrics.topShadowRadius;
  _topShadow.shadowOpacity = shadowMetrics.topShadowOpacity;
  _bottomShadow.shadowOffset = shadowMetrics.bottomShadowOffset;
  _bottomShadow.shadowRadius = shadowMetrics.bottomShadowRadius;
  _bottomShadow.shadowOpacity = shadowMetrics.bottomShadowOpacity;
}

#pragma mark - Private

- (void)commonLayoutSublayers {
  CGRect bounds = self.bounds;

  _bottomShadow.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  _bottomShadow.bounds = bounds;
  _topShadow.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  _topShadow.bounds = bounds;

  if (_shadowMaskEnabled) {
    _bottomShadow.mask = [self shadowLayerMaskForLayer:_bottomShadow];
    _topShadow.mask = [self shadowLayerMaskForLayer:_topShadow];
  }
  // Enforce shadowPaths because otherwise no shadows can be drawn. If a shadowPath
  // is already set, use that, otherwise fallback to just a regular rect because path.
  if (!_bottomShadow.shadowPath) {
    if (self.shadowPath) {
      _bottomShadow.shadowPath = self.shadowPath;
    } else {
      _bottomShadow.shadowPath = [self defaultShadowPath].CGPath;
    }
  }
  if (!_topShadow.shadowPath) {
    if (self.shadowPath) {
      _topShadow.shadowPath = self.shadowPath;
    } else {
      _topShadow.shadowPath = [self defaultShadowPath].CGPath;
    }
  }
}

@end
