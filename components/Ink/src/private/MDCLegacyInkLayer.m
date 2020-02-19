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

#import "MDCLegacyInkLayer.h"
#import "MDCLegacyInkLayer+Private.h"

#import <UIKit/UIKit.h>

#import "MaterialAvailability.h"

static inline CGPoint MDCLegacyInkLayerInterpolatePoint(CGPoint start,
                                                        CGPoint end,
                                                        CGFloat offsetPercent) {
  CGPoint centerOffsetPoint = CGPointMake(start.x + (end.x - start.x) * offsetPercent,
                                          start.y + (end.y - start.y) * offsetPercent);
  return centerOffsetPoint;
}

static inline CGFloat MDCLegacyInkLayerRadiusBounds(CGFloat maxRippleRadius,
                                                    CGFloat inkLayerRectHypotenuse,
                                                    __unused BOOL bounded) {
  if (maxRippleRadius > 0) {
#ifdef MDC_BOUNDED_INK_IGNORES_MAX_RIPPLE_RADIUS
    if (!bounded) {
      return maxRippleRadius;
    } else {
      static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
        NSLog(@"Implementation of MDCInkView with |MDCInkStyle| MDCInkStyleBounded and "
              @"maxRippleRadius has changed.\n\n"
              @"MDCInkStyleBounded ignores maxRippleRadius. "
              @"Please use |MDCInkStyle| MDCInkStyleUnbounded to continue using maxRippleRadius.");
      });
      return inkLayerRectHypotenuse;
    }
#else
    return maxRippleRadius;
#endif
  } else {
    return inkLayerRectHypotenuse;
  }
}

static inline CGFloat MDCLegacyInkLayerRandom() {
  const uint32_t max_value = 10000;
  return (CGFloat)arc4random_uniform(max_value + 1) / max_value;
}

static inline CGPoint MDCLegacyInkLayerRectGetCenter(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

static inline CGFloat MDCLegacyInkLayerRectHypotenuse(CGRect rect) {
  return (CGFloat)hypot(CGRectGetWidth(rect), CGRectGetHeight(rect));
}

static NSString *const kInkLayerOpacity = @"opacity";
static NSString *const kInkLayerPosition = @"position";
static NSString *const kInkLayerScale = @"transform.scale";

// State tracking for ink.
typedef NS_ENUM(NSInteger, MDCInkRippleState) {
  kInkRippleNone,
  kInkRippleSpreading,
  kInkRippleComplete,
  kInkRippleCancelled,
};

#if MDC_AVAILABLE_SDK_IOS(10_0)
@interface MDCLegacyInkLayerRipple () <CAAnimationDelegate>
@end
#endif  // MDC_AVAILABLE_SDK_IOS(10_0)

@interface MDCLegacyInkLayerRipple ()

@property(nonatomic, assign, getter=isAnimationCleared) BOOL animationCleared;
@property(nonatomic, weak) id<MDCLegacyInkLayerRippleDelegate> animationDelegate;
@property(nonatomic, assign) BOOL bounded;
@property(nonatomic, weak) CALayer *inkLayer;
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGPoint point;
@property(nonatomic, assign) CGRect targetFrame;
@property(nonatomic, assign) MDCInkRippleState rippleState;
@property(nonatomic, strong) UIColor *color;
@end

@implementation MDCLegacyInkLayerRipple

- (instancetype)init {
  self = [super init];
  if (self) {
    _rippleState = kInkRippleNone;
    _animationCleared = YES;
  }
  return self;
}

- (void)setupRipple {
  self.fillColor = self.color.CGColor;
  CGFloat dim = self.radius * 2;
  self.frame = CGRectMake(0, 0, dim, dim);
  UIBezierPath *ripplePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dim, dim)];
  self.path = ripplePath.CGPath;
}

- (void)enter {
  [self.animationDelegate animationDidStart:self];

  _rippleState = kInkRippleSpreading;
  [_inkLayer addSublayer:self];
  _animationCleared = NO;
}

- (void)exit {
  if (_rippleState != kInkRippleCancelled) {
    _rippleState = kInkRippleComplete;
  }
}

- (CAKeyframeAnimation *)opacityAnimWithValues:(NSArray<NSNumber *> *)values
                                         times:(NSArray<NSNumber *> *)times {
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kInkLayerOpacity];
  anim.fillMode = kCAFillModeForwards;
  anim.keyTimes = times;
  anim.removedOnCompletion = NO;
  anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  anim.values = values;
  return anim;
}

- (CAKeyframeAnimation *)positionAnimWithPath:(CGPathRef)path
                                     duration:(CGFloat)duration
                               timingFunction:(CAMediaTimingFunction *)timingFunction {
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kInkLayerPosition];
  anim.duration = duration;
  anim.fillMode = kCAFillModeForwards;
  anim.path = path;
  anim.removedOnCompletion = NO;
  anim.timingFunction = timingFunction;
  return anim;
}

- (CAKeyframeAnimation *)scaleAnimWithValues:(NSArray<NSNumber *> *)values
                                       times:(NSArray<NSNumber *> *)times {
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kInkLayerScale];
  anim.fillMode = kCAFillModeForwards;
  anim.keyTimes = times;
  anim.removedOnCompletion = NO;
  anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  anim.values = values;
  return anim;
}

- (CAMediaTimingFunction *)logDecelerateEasing {
  // This bezier curve is an approximation of a log curve.
  return
      [[CAMediaTimingFunction alloc] initWithControlPoints:(float)
                                                     0.157:(float)0.72:(float)0.386:(float)0.987];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished {
  if (!self.isAnimationCleared) {
    [self.animationDelegate animationDidStop:anim shapeLayer:self finished:finished];
  }
}

@end

static CGFloat const kInkLayerForegroundBoundedOpacityExitDuration = (CGFloat)0.4;
static CGFloat const kInkLayerForegroundBoundedPositionExitDuration = (CGFloat)0.3;
static CGFloat const kInkLayerForegroundBoundedRadiusExitDuration = (CGFloat)0.8;
static CGFloat const kInkLayerForegroundRadiusGrowthMultiplier = 350;
static CGFloat const kInkLayerForegroundUnboundedEnterDelay = (CGFloat)0.08;
static CGFloat const kInkLayerForegroundUnboundedOpacityEnterDuration = (CGFloat)0.12;
static CGFloat const kInkLayerForegroundWaveTouchDownAcceleration = 1024;
static CGFloat const kInkLayerForegroundWaveTouchUpAcceleration = 3400;
static NSString *const kInkLayerForegroundOpacityAnim = @"foregroundOpacityAnim";
static NSString *const kInkLayerForegroundPositionAnim = @"foregroundPositionAnim";
static NSString *const kInkLayerForegroundScaleAnim = @"foregroundScaleAnim";

@interface MDCLegacyInkLayerForegroundRipple ()
@property(nonatomic, assign) BOOL useCustomInkCenter;
@property(nonatomic, assign) CGPoint customInkCenter;
@property(nonatomic, strong) CAKeyframeAnimation *foregroundOpacityAnim;
@property(nonatomic, strong) CAKeyframeAnimation *foregroundPositionAnim;
@property(nonatomic, strong) CAKeyframeAnimation *foregroundScaleAnim;
@end

@implementation MDCLegacyInkLayerForegroundRipple

- (void)setupRipple {
  CGFloat random = MDCLegacyInkLayerRandom();
  self.radius =
      (CGFloat)((CGFloat)0.9 + random * (CGFloat)0.1) * kInkLayerForegroundRadiusGrowthMultiplier;
  [super setupRipple];
}

- (void)enterWithCompletion:(void (^)(void))completionBlock {
  [super enter];

  if (self.bounded) {
    _foregroundOpacityAnim = [self opacityAnimWithValues:@[ @0 ] times:@[ @0 ]];
    _foregroundScaleAnim = [self scaleAnimWithValues:@[ @0 ] times:@[ @0 ]];
  } else {
    _foregroundOpacityAnim = [self opacityAnimWithValues:@[ @0, @1 ] times:@[ @0, @1 ]];
    _foregroundOpacityAnim.duration = kInkLayerForegroundUnboundedOpacityEnterDuration;

    CGFloat duration = (CGFloat)sqrt(self.radius / kInkLayerForegroundWaveTouchDownAcceleration);
    _foregroundScaleAnim =
        [self scaleAnimWithValues:@[ @0, @1 ]
                            times:@[ @(kInkLayerForegroundUnboundedEnterDelay), @1 ]];
    _foregroundScaleAnim.duration = duration;

    CGFloat xOffset = self.targetFrame.origin.x - self.inkLayer.frame.origin.x;
    CGFloat yOffset = self.targetFrame.origin.y - self.inkLayer.frame.origin.y;

    UIBezierPath *movePath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(self.point.x + xOffset, self.point.y + yOffset);
    CGPoint endPoint = MDCLegacyInkLayerRectGetCenter(self.targetFrame);
    if (self.useCustomInkCenter) {
      endPoint = self.customInkCenter;
    }
    endPoint = CGPointMake(endPoint.x + xOffset, endPoint.y + yOffset);
    [movePath moveToPoint:startPoint];
    [movePath addLineToPoint:endPoint];

    CAMediaTimingFunction *linearTimingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _foregroundPositionAnim = [self positionAnimWithPath:movePath.CGPath
                                                duration:duration
                                          timingFunction:linearTimingFunction];
    _foregroundPositionAnim.keyTimes = @[ @(kInkLayerForegroundUnboundedEnterDelay), @1 ];
    [self addAnimation:_foregroundPositionAnim forKey:kInkLayerForegroundPositionAnim];
  }

  [CATransaction begin];
  if (completionBlock) {
    __weak MDCLegacyInkLayerForegroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^{
      MDCLegacyInkLayerForegroundRipple *strongSelf = weakSelf;
      if (strongSelf.rippleState != kInkRippleCancelled) {
        completionBlock();
      }
    }];
  }
  [self addAnimation:_foregroundOpacityAnim forKey:kInkLayerForegroundOpacityAnim];
  [self addAnimation:_foregroundScaleAnim forKey:kInkLayerForegroundScaleAnim];
  [CATransaction commit];
}

- (void)exit:(BOOL)animated {
  self.rippleState = kInkRippleCancelled;
  [self exit:animated completion:nil];
}

- (void)exit:(BOOL)animated completion:(void (^)(void))completionBlock {
  [super exit];

  if (!animated) {
    [self removeAllAnimations];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.opacity = 0;
    __weak MDCLegacyInkLayerForegroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^(void) {
      MDCLegacyInkLayerForegroundRipple *strongSelf = weakSelf;
      [strongSelf removeFromSuperlayer];
      [strongSelf.animationDelegate animationDidStop:nil shapeLayer:strongSelf finished:YES];
    }];
    [CATransaction commit];
    return;
  }

  if (self.bounded) {
    _foregroundOpacityAnim.values = @[ @1, @0 ];
    _foregroundOpacityAnim.duration = kInkLayerForegroundBoundedOpacityExitDuration;

    // Bounded ripples move slightly towards the center of the tap target. Unbounded ripples
    // move to the center of the tap target.

    CGFloat xOffset = self.targetFrame.origin.x - self.inkLayer.frame.origin.x;
    CGFloat yOffset = self.targetFrame.origin.y - self.inkLayer.frame.origin.y;

    CGPoint startPoint = CGPointMake(self.point.x + xOffset, self.point.y + yOffset);
    CGPoint endPoint = MDCLegacyInkLayerRectGetCenter(self.targetFrame);
    if (self.useCustomInkCenter) {
      endPoint = self.customInkCenter;
    }
    endPoint = CGPointMake(endPoint.x + xOffset, endPoint.y + yOffset);
    CGPoint centerOffsetPoint =
        MDCLegacyInkLayerInterpolatePoint(startPoint, endPoint, (CGFloat)0.3);
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:startPoint];
    [movePath addLineToPoint:centerOffsetPoint];

    _foregroundPositionAnim =
        [self positionAnimWithPath:movePath.CGPath
                          duration:kInkLayerForegroundBoundedPositionExitDuration
                    timingFunction:[self logDecelerateEasing]];
    _foregroundScaleAnim.values = @[ @0, @1 ];
    _foregroundScaleAnim.keyTimes = @[ @0, @1 ];
    _foregroundScaleAnim.duration = kInkLayerForegroundBoundedRadiusExitDuration;
  } else {
    NSNumber *opacityVal = [self.presentationLayer valueForKeyPath:kInkLayerOpacity];
    if (opacityVal == nil) {
      opacityVal = [NSNumber numberWithFloat:0];
    }
    CGFloat adjustedDuration = kInkLayerForegroundBoundedPositionExitDuration;
    CGFloat normOpacityVal = opacityVal.floatValue;
    CGFloat opacityDuration = normOpacityVal / 3;
    _foregroundOpacityAnim.values = @[ opacityVal, @0 ];
    _foregroundOpacityAnim.duration = opacityDuration + adjustedDuration;

    NSNumber *scaleVal = [self.presentationLayer valueForKeyPath:kInkLayerScale];
    if (scaleVal == nil) {
      scaleVal = [NSNumber numberWithFloat:0];
    }
    CGFloat unboundedDuration = (CGFloat)sqrt(((1 - scaleVal.floatValue) * self.radius) /
                                              (kInkLayerForegroundWaveTouchDownAcceleration +
                                               kInkLayerForegroundWaveTouchUpAcceleration));
    _foregroundPositionAnim.duration = unboundedDuration + adjustedDuration;
    _foregroundScaleAnim.values = @[ scaleVal, @1 ];
    _foregroundScaleAnim.duration = unboundedDuration + adjustedDuration;
  }

  _foregroundOpacityAnim.keyTimes = @[ @0, @1 ];
  if (_foregroundOpacityAnim.duration < _foregroundScaleAnim.duration) {
    _foregroundScaleAnim.delegate = self;
  } else {
    _foregroundOpacityAnim.delegate = self;
  }

  _foregroundOpacityAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  _foregroundPositionAnim.timingFunction = [self logDecelerateEasing];
  _foregroundScaleAnim.timingFunction = [self logDecelerateEasing];

  [CATransaction begin];
  if (completionBlock) {
    __weak MDCLegacyInkLayerForegroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^{
      MDCLegacyInkLayerForegroundRipple *strongSelf = weakSelf;
      if (strongSelf.rippleState != kInkRippleCancelled) {
        completionBlock();
      }
    }];
  }
  [self addAnimation:_foregroundOpacityAnim forKey:kInkLayerForegroundOpacityAnim];
  [self addAnimation:_foregroundPositionAnim forKey:kInkLayerForegroundPositionAnim];
  [self addAnimation:_foregroundScaleAnim forKey:kInkLayerForegroundScaleAnim];
  [CATransaction commit];
}

- (void)removeAllAnimations {
  [super removeAllAnimations];
  _foregroundOpacityAnim = nil;
  _foregroundPositionAnim = nil;
  _foregroundScaleAnim = nil;
  self.animationCleared = YES;
}

@end

static CGFloat const kInkLayerBackgroundOpacityEnterDuration = (CGFloat)0.6;
static CGFloat const kInkLayerBackgroundBaseOpacityExitDuration = (CGFloat)0.48;
static CGFloat const kInkLayerBackgroundFastEnterDuration = (CGFloat)0.12;
static NSString *const kInkLayerBackgroundOpacityAnim = @"backgroundOpacityAnim";

@interface MDCLegacyInkLayerBackgroundRipple ()
@property(nonatomic, strong, nullable) CAKeyframeAnimation *backgroundOpacityAnim;
@end

@implementation MDCLegacyInkLayerBackgroundRipple

- (void)enter {
  [super enter];
  _backgroundOpacityAnim = [self opacityAnimWithValues:@[ @0, @1 ] times:@[ @0, @1 ]];
  _backgroundOpacityAnim.duration = kInkLayerBackgroundOpacityEnterDuration;
  [self addAnimation:_backgroundOpacityAnim forKey:kInkLayerBackgroundOpacityAnim];
}

- (void)exit:(BOOL)animated {
  [super exit];

  if (!animated) {
    [self removeAllAnimations];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.opacity = 0;
    __weak MDCLegacyInkLayerBackgroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^(void) {
      MDCLegacyInkLayerBackgroundRipple *strongSelf = weakSelf;
      [strongSelf removeFromSuperlayer];
      [strongSelf.animationDelegate animationDidStop:nil shapeLayer:strongSelf finished:YES];
    }];
    [CATransaction commit];
    return;
  }

  NSNumber *opacityVal = [self.presentationLayer valueForKeyPath:kInkLayerOpacity];
  if (opacityVal == nil) {
    opacityVal = [NSNumber numberWithFloat:0];
  }
  CGFloat duration = kInkLayerBackgroundBaseOpacityExitDuration;
  if (self.bounded) {
    // The end (tap release) animation should continue at the opacity level of the start animation.
    CGFloat enterDuration = (1 - opacityVal.floatValue / 1) * kInkLayerBackgroundFastEnterDuration;
    duration += enterDuration;
    _backgroundOpacityAnim = [self opacityAnimWithValues:@[ opacityVal, @1, @0 ]
                                                   times:@[ @0, @(enterDuration / duration), @1 ]];
  } else {
    _backgroundOpacityAnim = [self opacityAnimWithValues:@[ opacityVal, @0 ] times:@[ @0, @1 ]];
  }
  _backgroundOpacityAnim.duration = duration;
  _backgroundOpacityAnim.delegate = self;
  [self addAnimation:_backgroundOpacityAnim forKey:kInkLayerBackgroundOpacityAnim];
}

- (void)removeAllAnimations {
  [super removeAllAnimations];
  _backgroundOpacityAnim = nil;
  self.animationCleared = YES;
}

@end

@interface MDCLegacyInkLayer ()

/**
 Reset the bottom-most ink applied to the layer with a completion handler to be called on completion
 if applicable.

 @param animated Enables the ink ripple fade out animation.
 @param completionBlock Block called after the completion of the animation.
 */
- (void)resetBottomInk:(BOOL)animated completion:(void (^)(void))completionBlock;

/**
 Reset the bottom-most ink applied to the layer with a completion handler to be called on completion
 if applicable.

 @param animated Enables the ink ripple fade out animation.
 @param point Evaporate the ink towards the point.
 @param completionBlock Block called after the completion of the animation.
 */
- (void)resetBottomInk:(BOOL)animated
               toPoint:(CGPoint)point
            completion:(void (^)(void))completionBlock;

@property(nonatomic, strong, nonnull) CAShapeLayer *compositeRipple;
@property(nonatomic, strong, nonnull)
    NSMutableArray<MDCLegacyInkLayerForegroundRipple *> *foregroundRipples;
@property(nonatomic, strong, nonnull)
    NSMutableArray<MDCLegacyInkLayerBackgroundRipple *> *backgroundRipples;

@end

@implementation MDCLegacyInkLayer

- (instancetype)init {
  self = [super init];
  if (self) {
    self.masksToBounds = YES;
    [self commonMDCLegacyInkLayerInit];
    _animating = NO;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if (self) {
    _animating = NO;
    // Discard any sublayers, which should be the composite ripple and any active ripples
    if (self.sublayers.count > 0) {
      NSArray<CALayer *> *sublayers = [self.sublayers copy];
      for (CALayer *sublayer in sublayers) {
        [sublayer removeFromSuperlayer];
      }
    }
    [self commonMDCLegacyInkLayerInit];
  }

  return self;
}

- (void)commonMDCLegacyInkLayerInit {
  static UIColor *defaultInkColor;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    defaultInkColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.08];
  });

  _bounded = YES;
  _inkColor = defaultInkColor;
  _compositeRipple = [CAShapeLayer layer];
  _foregroundRipples = [NSMutableArray array];
  _backgroundRipples = [NSMutableArray array];
  [self addSublayer:_compositeRipple];
}

- (void)layoutSublayers {
  [super layoutSublayers];
  CGFloat radius = MDCLegacyInkLayerRadiusBounds(
      _maxRippleRadius, MDCLegacyInkLayerRectHypotenuse(self.bounds) / 2, _bounded);

  CGRect rippleFrame =
      CGRectMake(-(radius * 2 - self.bounds.size.width) / 2,
                 -(radius * 2 - self.bounds.size.height) / 2, radius * 2, radius * 2);
  _compositeRipple.frame = rippleFrame;
  CGRect rippleBounds = CGRectMake(0, 0, radius * 2, radius * 2);
  CAShapeLayer *rippleMaskLayer = [CAShapeLayer layer];
  UIBezierPath *ripplePath = [UIBezierPath bezierPathWithOvalInRect:rippleBounds];
  rippleMaskLayer.path = ripplePath.CGPath;
  _compositeRipple.mask = rippleMaskLayer;
}

- (void)enterAllInks {
  for (MDCLegacyInkLayerForegroundRipple *foregroundRipple in self.foregroundRipples) {
    [foregroundRipple enterWithCompletion:nil];
  }
  for (MDCLegacyInkLayerBackgroundRipple *backgroundRipple in self.backgroundRipples) {
    [backgroundRipple enter];
  }
}

- (void)resetAllInk:(BOOL)animated {
  for (MDCLegacyInkLayerForegroundRipple *foregroundRipple in self.foregroundRipples) {
    [foregroundRipple exit:animated];
  }
  for (MDCLegacyInkLayerBackgroundRipple *backgroundRipple in self.backgroundRipples) {
    [backgroundRipple exit:animated];
  }
}

- (void)resetBottomInk:(BOOL)animated completion:(void (^)(void))completionBlock {
  if (self.foregroundRipples.count > 0) {
    [[self.foregroundRipples objectAtIndex:(self.foregroundRipples.count - 1)]
              exit:animated
        completion:completionBlock];
  }
  if (self.backgroundRipples.count > 0) {
    [[self.backgroundRipples objectAtIndex:(self.backgroundRipples.count - 1)] exit:animated];
  }
}

- (void)resetBottomInk:(BOOL)animated
               toPoint:(CGPoint)point
            completion:(void (^)(void))completionBlock {
  if (self.foregroundRipples.count > 0) {
    MDCLegacyInkLayerForegroundRipple *foregroundRipple =
        [self.foregroundRipples objectAtIndex:(self.foregroundRipples.count - 1)];
    foregroundRipple.point = point;
    [foregroundRipple exit:animated completion:completionBlock];
  }
  if (self.backgroundRipples.count > 0) {
    [[self.backgroundRipples objectAtIndex:(self.backgroundRipples.count - 1)] exit:animated];
  }
}

#pragma mark - Properties

- (void)spreadFromPoint:(CGPoint)point completion:(void (^)(void))completionBlock {
  // Create a mask layer before drawing the ink using the superlayer's shadowPath
  // if it exists. This helps the FAB when it is not rectangular.
  if (self.masksToBounds && self.superlayer.shadowPath) {
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = self.superlayer.shadowPath;
    mask.fillColor = [UIColor whiteColor].CGColor;
    self.mask = mask;
  } else {
    self.mask = nil;
  }

  CGFloat radius = MDCLegacyInkLayerRadiusBounds(
      _maxRippleRadius, MDCLegacyInkLayerRectHypotenuse(self.bounds) / 2, _bounded);

  MDCLegacyInkLayerBackgroundRipple *backgroundRipple =
      [[MDCLegacyInkLayerBackgroundRipple alloc] init];
  backgroundRipple.inkLayer = _compositeRipple;
  backgroundRipple.targetFrame = self.bounds;
  backgroundRipple.point = point;
  backgroundRipple.color = self.inkColor;
  backgroundRipple.radius = radius;
  backgroundRipple.bounded = self.bounded;
  backgroundRipple.animationDelegate = self;
  [backgroundRipple setupRipple];

  MDCLegacyInkLayerForegroundRipple *foregroundRipple =
      [[MDCLegacyInkLayerForegroundRipple alloc] init];
  foregroundRipple.inkLayer = _compositeRipple;
  foregroundRipple.targetFrame = self.bounds;
  foregroundRipple.point = point;
  foregroundRipple.color = self.inkColor;
  foregroundRipple.radius = radius;
  foregroundRipple.bounded = self.bounded;
  foregroundRipple.animationDelegate = self;
  foregroundRipple.useCustomInkCenter = self.useCustomInkCenter;
  foregroundRipple.customInkCenter = self.customInkCenter;
  [foregroundRipple setupRipple];

  [backgroundRipple enter];
  [self.backgroundRipples addObject:backgroundRipple];
  [foregroundRipple enterWithCompletion:completionBlock];
  [self.foregroundRipples addObject:foregroundRipple];
}

- (void)evaporateWithCompletion:(void (^)(void))completionBlock {
  [self resetBottomInk:YES completion:completionBlock];
}

- (void)evaporateToPoint:(CGPoint)point completion:(void (^)(void))completionBlock {
  [self resetBottomInk:YES toPoint:point completion:completionBlock];
}

#pragma mark - MDCLegacyRippleInkLayerDelegate

- (void)animationDidStart:(MDCLegacyInkLayerRipple *)layerRipple {
  if (!self.isAnimating) {
    self.animating = YES;

    if ([self.animationDelegate respondsToSelector:@selector(legacyInkLayerAnimationDidStart:)]) {
      [self.animationDelegate legacyInkLayerAnimationDidStart:self];
    }
  }
}

- (void)animationDidStop:(__unused CAAnimation *)anim
              shapeLayer:(MDCLegacyInkLayerRipple *)layerRipple
                finished:(__unused BOOL)finished {
  // Even when the ripple is "exited" without animation, we need to remove it from compositeRipple
  [layerRipple removeFromSuperlayer];
  [layerRipple removeAllAnimations];

  if ([layerRipple isKindOfClass:[MDCLegacyInkLayerForegroundRipple class]]) {
    [self.foregroundRipples removeObject:(MDCLegacyInkLayerForegroundRipple *)layerRipple];
  } else if ([layerRipple isKindOfClass:[MDCLegacyInkLayerBackgroundRipple class]]) {
    [self.backgroundRipples removeObject:(MDCLegacyInkLayerBackgroundRipple *)layerRipple];
  }

  // Check if all ink layer animations did finish and call animation end callback
  if (self.isAnimating && self.foregroundRipples.count == 0 && self.backgroundRipples.count == 0) {
    self.animating = NO;
    if ([self.animationDelegate respondsToSelector:@selector(legacyInkLayerAnimationDidEnd:)]) {
      [self.animationDelegate legacyInkLayerAnimationDidEnd:self];
    }
  }
}

@end
