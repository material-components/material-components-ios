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

#import "MDCInkLayer.h"
#import "MDCInkLayer+Testing.h"

#import <UIKit/UIKit.h>

static inline CGPoint MDCInkLayerInterpolatePoint(CGPoint start,
                                                  CGPoint end,
                                                  CGFloat offsetPercent) {
  CGPoint centerOffsetPoint = CGPointMake(start.x + (end.x - start.x) * offsetPercent,
                                          start.y + (end.y - start.y) * offsetPercent);
  return centerOffsetPoint;
}

static inline CGFloat MDCInkLayerRadiusBounds(CGFloat maxRippleRadius,
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
              @"Please use |MDCInkStyle| MDCInkStyleUnbounded to continue using maxRippleRadius. "
              @"For implementation questions, please email shepj@google.com");
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

static inline CGFloat MDCInkLayerRandom() {
  const uint32_t max_value = 10000;
  return (CGFloat)arc4random_uniform(max_value + 1) / max_value;
}

static inline CGPoint MDCInkLayerRectGetCenter(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

static inline CGFloat MDCInkLayerRectHypotenuse(CGRect rect) {
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

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface MDCInkLayerRipple () <CAAnimationDelegate>
@end
#endif

@interface MDCInkLayerRipple ()

@property(nonatomic, assign, getter=isAnimationCleared) BOOL animationCleared;
@property(nonatomic, weak) id<MDCInkLayerRippleDelegate> animationDelegate;
@property(nonatomic, assign) BOOL bounded;
@property(nonatomic, weak) CALayer *inkLayer;
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGPoint point;
@property(nonatomic, assign) CGRect targetFrame;
@property(nonatomic, assign) MDCInkRippleState rippleState;
@property(nonatomic, strong) UIColor *color;
@end

@implementation MDCInkLayerRipple

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
  CGFloat dim = self.radius * 2.f;
  self.frame = CGRectMake(0, 0, dim, dim);
  UIBezierPath *ripplePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dim, dim)];
  self.path = ripplePath.CGPath;
}

- (void)enter {
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
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.157f:0.72f:0.386f:0.987f];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished {
  if (!self.isAnimationCleared) {
    [self.animationDelegate animationDidStop:anim shapeLayer:self finished:finished];
  }
}

@end

static CGFloat const kInkLayerForegroundBoundedOpacityExitDuration = 0.4f;
static CGFloat const kInkLayerForegroundBoundedPositionExitDuration = 0.3f;
static CGFloat const kInkLayerForegroundBoundedRadiusExitDuration = 0.8f;
static CGFloat const kInkLayerForegroundRadiusGrowthMultiplier = 350.f;
static CGFloat const kInkLayerForegroundUnboundedEnterDelay = 0.08f;
static CGFloat const kInkLayerForegroundUnboundedOpacityEnterDuration = 0.12f;
static CGFloat const kInkLayerForegroundWaveTouchDownAcceleration = 1024.f;
static CGFloat const kInkLayerForegroundWaveTouchUpAcceleration = 3400.f;
static NSString *const kInkLayerForegroundOpacityAnim = @"foregroundOpacityAnim";
static NSString *const kInkLayerForegroundPositionAnim = @"foregroundPositionAnim";
static NSString *const kInkLayerForegroundScaleAnim = @"foregroundScaleAnim";

@interface MDCInkLayerForegroundRipple ()
@property(nonatomic, assign) BOOL useCustomInkCenter;
@property(nonatomic, assign) CGPoint customInkCenter;
@property(nonatomic, strong) CAKeyframeAnimation *foregroundOpacityAnim;
@property(nonatomic, strong) CAKeyframeAnimation *foregroundPositionAnim;
@property(nonatomic, strong) CAKeyframeAnimation *foregroundScaleAnim;
@end

@implementation MDCInkLayerForegroundRipple

- (void)setupRipple {
  CGFloat random = MDCInkLayerRandom();
  self.radius = (CGFloat)(0.9f + random * 0.1f) * kInkLayerForegroundRadiusGrowthMultiplier;
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
    CGPoint endPoint = MDCInkLayerRectGetCenter(self.targetFrame);
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
    __weak MDCInkLayerForegroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^{
      MDCInkLayerForegroundRipple *strongSelf = weakSelf;
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
    __weak MDCInkLayerForegroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^(void) {
      MDCInkLayerForegroundRipple *strongSelf = weakSelf;
      [strongSelf removeFromSuperlayer];

      if ([strongSelf.animationDelegate
              respondsToSelector:@selector(animationDidStop:shapeLayer:finished:)]) {
        [strongSelf.animationDelegate animationDidStop:nil shapeLayer:strongSelf finished:YES];
      }
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
    CGPoint endPoint = MDCInkLayerRectGetCenter(self.targetFrame);
    if (self.useCustomInkCenter) {
      endPoint = self.customInkCenter;
    }
    endPoint = CGPointMake(endPoint.x + xOffset, endPoint.y + yOffset);
    CGPoint centerOffsetPoint = MDCInkLayerInterpolatePoint(startPoint, endPoint, 0.3f);
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
    if (!opacityVal) {
      opacityVal = [NSNumber numberWithFloat:0];
    }
    CGFloat adjustedDuration = kInkLayerForegroundBoundedPositionExitDuration;
    CGFloat normOpacityVal = opacityVal.floatValue;
    CGFloat opacityDuration = normOpacityVal / 3.f;
    _foregroundOpacityAnim.values = @[ opacityVal, @0 ];
    _foregroundOpacityAnim.duration = opacityDuration + adjustedDuration;

    NSNumber *scaleVal = [self.presentationLayer valueForKeyPath:kInkLayerScale];
    if (!scaleVal) {
      scaleVal = [NSNumber numberWithFloat:0];
    }
    CGFloat unboundedDuration = (CGFloat)sqrt(((1.f - scaleVal.floatValue) * self.radius) /
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
    __weak MDCInkLayerForegroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^{
      MDCInkLayerForegroundRipple *strongSelf = weakSelf;
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

static CGFloat const kInkLayerBackgroundOpacityEnterDuration = 0.6f;
static CGFloat const kInkLayerBackgroundBaseOpacityExitDuration = 0.48f;
static CGFloat const kInkLayerBackgroundFastEnterDuration = 0.12f;
static NSString *const kInkLayerBackgroundOpacityAnim = @"backgroundOpacityAnim";

@interface MDCInkLayerBackgroundRipple ()
@property(nonatomic, strong) CAKeyframeAnimation *backgroundOpacityAnim;
@end

@implementation MDCInkLayerBackgroundRipple

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
    __weak MDCInkLayerBackgroundRipple *weakSelf = self;
    [CATransaction setCompletionBlock:^(void) {
      MDCInkLayerBackgroundRipple *strongSelf = weakSelf;
      [strongSelf removeFromSuperlayer];

      if ([strongSelf.animationDelegate
              respondsToSelector:@selector(animationDidStop:shapeLayer:finished:)]) {
        [strongSelf.animationDelegate animationDidStop:nil shapeLayer:strongSelf finished:YES];
      }
    }];
    [CATransaction commit];
    return;
  }

  NSNumber *opacityVal = [self.presentationLayer valueForKeyPath:kInkLayerOpacity];
  if (!opacityVal) {
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

@interface MDCInkLayer ()

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

@property(nonatomic, strong) CAShapeLayer *compositeRipple;
@property(nonatomic, strong) NSMutableArray<MDCInkLayerForegroundRipple *> *foregroundRipples;
@property(nonatomic, strong) NSMutableArray<MDCInkLayerBackgroundRipple *> *backgroundRipples;

@end

@implementation MDCInkLayer

- (instancetype)init {
  self = [super init];
  if (self) {
    self.masksToBounds = YES;
    _bounded = YES;
    _compositeRipple = [CAShapeLayer layer];
    _foregroundRipples = [NSMutableArray array];
    _backgroundRipples = [NSMutableArray array];
    [self addSublayer:_compositeRipple];
  }
  return self;
}

- (void)layoutSublayers {
  [super layoutSublayers];
  CGFloat radius = MDCInkLayerRadiusBounds(_maxRippleRadius,
                                           MDCInkLayerRectHypotenuse(self.bounds) / 2.f, _bounded);

  CGRect rippleFrame =
      CGRectMake(-(radius * 2.f - self.bounds.size.width) / 2.f,
                 -(radius * 2.f - self.bounds.size.height) / 2.f, radius * 2.f, radius * 2.f);
  _compositeRipple.frame = rippleFrame;
  CGRect rippleBounds = CGRectMake(0, 0, radius * 2.f, radius * 2.f);
  CAShapeLayer *rippleMaskLayer = [CAShapeLayer layer];
  UIBezierPath *ripplePath = [UIBezierPath bezierPathWithOvalInRect:rippleBounds];
  rippleMaskLayer.path = ripplePath.CGPath;
  _compositeRipple.mask = rippleMaskLayer;
}

- (void)resetAllInk:(BOOL)animated {
  for (MDCInkLayerForegroundRipple *foregroundRipple in self.foregroundRipples) {
    [foregroundRipple exit:animated];
  }
  for (MDCInkLayerBackgroundRipple *backgroundRipple in self.backgroundRipples) {
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
    MDCInkLayerForegroundRipple *foregroundRipple =
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

  CGFloat radius = MDCInkLayerRadiusBounds(_maxRippleRadius,
                                           MDCInkLayerRectHypotenuse(self.bounds) / 2.f, _bounded);

  MDCInkLayerBackgroundRipple *backgroundRipple = [[MDCInkLayerBackgroundRipple alloc] init];
  backgroundRipple.inkLayer = _compositeRipple;
  backgroundRipple.targetFrame = self.bounds;
  backgroundRipple.point = point;
  backgroundRipple.color = self.inkColor;
  backgroundRipple.radius = radius;
  backgroundRipple.bounded = self.bounded;
  backgroundRipple.animationDelegate = self;
  [backgroundRipple setupRipple];

  MDCInkLayerForegroundRipple *foregroundRipple = [[MDCInkLayerForegroundRipple alloc] init];
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

#pragma mark - MDCInkLayerRippleDelegate

- (void)animationDidStop:(__unused CAAnimation *)anim
              shapeLayer:(CAShapeLayer *)shapeLayer
                finished:(__unused BOOL)finished {
  // Even when the ripple is "exited" without animation, we need to remove it from compositeRipple
  [shapeLayer removeFromSuperlayer];
  [shapeLayer removeAllAnimations];

  if ([shapeLayer isMemberOfClass:[MDCInkLayerForegroundRipple class]]) {
    [self.foregroundRipples removeObject:(MDCInkLayerForegroundRipple *)shapeLayer];
  } else if ([shapeLayer isMemberOfClass:[MDCInkLayerBackgroundRipple class]]) {
    [self.backgroundRipples removeObject:(MDCInkLayerBackgroundRipple *)shapeLayer];
  }
}

@end
