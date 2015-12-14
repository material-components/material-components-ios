/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "private/MDCInkLayer.h"

#import <UIKit/UIKit.h>

static inline CGPoint MDCInkLayerInterpolatePoint(CGPoint start,
                                                  CGPoint end,
                                                  CGFloat offsetPercent) {
  CGPoint centerOffsetPoint = CGPointMake(start.x + (end.x - start.x) * offsetPercent,
                                          start.y + (end.y - start.y) * offsetPercent);
  return centerOffsetPoint;
}

static inline CGPoint MDCInkLayerRectGetCenter(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

static inline CGFloat MDCInkLayerRectHypotenuse(CGRect rect) {
  return hypot(CGRectGetWidth(rect), CGRectGetHeight(rect));
}

static CGFloat const kMDCInkLayerBackgroundOpacityEnterDuration = 0.6f;
static CGFloat const kMDCInkLayerBaseOpacityExitDuration = 0.48f;
static CGFloat const kMDCInkLayerBoundedOpacityExitDuration = 0.4f;
static CGFloat const kMDCInkLayerBoundedOriginExitDuration = 0.3f;
static CGFloat const kMDCInkLayerBoundedPositionExitDuration = 0.4f;
static CGFloat const kMDCInkLayerBoundedRadiusExitDuration = 0.8f;
static CGFloat const kMDCInkLayerFastEnterDuration = 0.12f;
static CGFloat const kMDCInkLayerPositionConstantDuration = 0.5f;
static CGFloat const kMDCInkLayerRadiusGrowthMultiplier = 350.f;
static CGFloat const kMDCInkLayerUnboundedPositionExitAdjustedDuration = 0.15f;
static CGFloat const kMDCInkLayerWaveTouchDownAcceleration = 1024.f;
static CGFloat const kMDCInkLayerWaveTouchUpAcceleration = 3400.f;

static NSString *const kMDCInkLayerBackgroundOpacityAnim = @"backgroundOpacityAnim";
static NSString *const kMDCInkLayerForegroundOpacityAnim = @"foregroundOpacityAnim";
static NSString *const kMDCInkLayerForegroundPositionAnim = @"foregroundPositionAnim";
static NSString *const kMDCInkLayerForegroundScaleAnim = @"foregroundScaleAnim";
static NSString *const kMDCInkLayerOpacity = @"opacity";
static NSString *const kMDCInkLayerPosition = @"position";
static NSString *const kMDCInkLayerScale = @"transform.scale";

// State tracking for ink.
typedef NS_ENUM(NSInteger, MDCInkRippleState) {
  kMDCInkRippleNone,
  kMDCInkRippleSpreading,
};

@implementation MDCInkLayer {
  BOOL _foregroundRippleLayerComplete;

  CAKeyframeAnimation *_backgroundOpacityAnim;
  CAKeyframeAnimation *_foregroundOpacityAnim;
  CAKeyframeAnimation *_foregroundPositionAnim;
  CAKeyframeAnimation *_foregroundScaleAnim;

  CAShapeLayer *_rippleLayer;
  CAShapeLayer *_backgroundRippleLayer;
  CAShapeLayer *_foregroundRippleLayer;

  // Time the drop starts to spread.
  CFAbsoluteTime _dropStartTime;

  CGFloat _maxOpacityLevel;
  CGFloat _radius;
  NSTimer *_clearLayerTimer;

  MDCInkRippleState _rippleState;
  void (^_completionBlock)();
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor].CGColor;
    _rippleState = kMDCInkRippleNone;
    _gravitatesInk = YES;
    _useCustomInkCenter = NO;
    _bounded = YES;

    // The max opacity level is half of the full opacity level. Half of the opacity is for
    // background ripple and half for the foreground ripple.
    _maxOpacityLevel = 1.f;
    _rippleLayer = [CAShapeLayer layer];
    self.sublayers = nil;
    [self addSublayer:_rippleLayer];
  }
  return self;
}

- (void)layoutSublayers {
  _rippleLayer.frame = self.frame;
  _radius = MDCInkLayerRectHypotenuse(self.bounds) / 2.f;
  if (_maxRippleRadius > 0) {
    _radius = _maxRippleRadius;
  }
  CGRect rippleRect = CGRectMake(-(_radius * 2.f - self.bounds.size.width) / 2.f,
                                 -(_radius * 2.f - self.bounds.size.height) / 2.f,
                                 _radius * 2.f,
                                 _radius * 2.f);
  CAShapeLayer *rippleMaskLayer = [CAShapeLayer layer];
  UIBezierPath *ripplePath = [UIBezierPath bezierPathWithOvalInRect:rippleRect];
  rippleMaskLayer.path = ripplePath.CGPath;
  _rippleLayer.mask = rippleMaskLayer;
}

#pragma mark - Properties

- (void)setInkColor:(UIColor *)inkColor {
  _inkColor = inkColor;
}

- (void)setFillsBackgroundOnSpread:(BOOL)shouldFill {
  _shouldFillBackgroundOnSpread = shouldFill;
  if (shouldFill) {
    CGFloat radius = MDCInkLayerRectHypotenuse([[UIScreen mainScreen] bounds]);
    _maxRippleRadius = radius;
  }
}

#pragma mark - Animation Functions

- (CAKeyframeAnimation *)inkSpreadAnimationWithDuration:(NSTimeInterval)duration
                                              fromScale:(CGFloat)fromScale
                                                toScale:(CGFloat)toScale
                                             fromCenter:(CGPoint)fromCenter
                                               toCenter:(CGPoint)toCenter {
  // Create a keyframe for each frame based on the scale equation.
  NSUInteger kFramesPerSecond = 60;

  // If the expansion is linear, then only the first transform (the identity transform) is added to
  // the values array in the loop below.
  NSUInteger frameCount =
      self.userLinearExpansion ? 1 : (NSUInteger)ceil(duration * kFramesPerSecond);
  NSMutableArray *values = [NSMutableArray arrayWithCapacity:frameCount + 1];
  NSMutableArray *times = [NSMutableArray arrayWithCapacity:frameCount + 1];

  for (NSUInteger frame = 0; frame < frameCount; frame++) {
    CGFloat ratio = frame / (CGFloat)frameCount;
    [times addObject:@(ratio)];

    // This is the spread formula:
    CGFloat fraction = (CGFloat)(1 - pow(80, -ratio));

    // Work out the transform for both scaling and translating.
    CATransform3D transform = CATransform3DIdentity;
    if (_gravitatesInk) {
      CGPoint offset = CGPointMake((toCenter.x - fromCenter.x) * fraction,
                                   (toCenter.y - fromCenter.y) * fraction);
      transform = CATransform3DTranslate(transform, offset.x, offset.y, 1);
    }

    CGFloat scale = toScale * fraction;
    transform = CATransform3DScale(transform, scale, scale, 1);

    [values addObject:[NSValue valueWithCATransform3D:transform]];
  }

  // Add the ending condition.
  CATransform3D finalTransform = CATransform3DIdentity;
  if (_gravitatesInk) {
    finalTransform = CATransform3DTranslate(finalTransform, (toCenter.x - fromCenter.x),
                                            (toCenter.y - fromCenter.y), 1);
  }
  finalTransform = CATransform3DScale(finalTransform, toScale, toScale, 1);
  [times addObject:@(1.0)];
  [values addObject:[NSValue valueWithCATransform3D:finalTransform]];

  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.values = values;
  animation.keyTimes = times;
  animation.duration = duration;
  return animation;
}

- (void)spreadFromPoint:(CGPoint)point completion:(void (^)())completionBlock {
  _rippleState = kMDCInkRippleSpreading;

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
  [self startBackgroundRipple];
  [self startForegroundRippleAtPoint:point];
  _dropStartTime = CFAbsoluteTimeGetCurrent();
}

- (void)startBackgroundRipple {
  if (_clearLayerTimer) {
    [_clearLayerTimer invalidate];
  }
  _backgroundRippleLayer = [CAShapeLayer layer];
  _backgroundRippleLayer.fillColor = self.inkColor.CGColor;
  _backgroundRippleLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
  _backgroundRippleLayer.masksToBounds = YES;
  [_rippleLayer addSublayer:_backgroundRippleLayer];

  UIBezierPath *ripplePath =
      [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                        0,
                                                        _radius * 2.f,
                                                        _radius * 2.f)];
  _backgroundRippleLayer.path = ripplePath.CGPath;
  CGPoint origin = self.frame.origin;
  _backgroundRippleLayer.frame =
      CGRectMake(origin.x - (_radius * 2.f - self.bounds.size.width) / 2.f,
                 origin.y - (_radius * 2.f - self.bounds.size.height) / 2.f,
                 _radius * 2.f,
                 _radius * 2.f);
  _backgroundOpacityAnim = [self opacityAnimWithValues:@[ @0, @(_maxOpacityLevel) ]
                                                 times:@[ @0, @1.f ]];
  _backgroundOpacityAnim.duration = kMDCInkLayerBackgroundOpacityEnterDuration;
  [_backgroundRippleLayer addAnimation:_backgroundOpacityAnim
                                forKey:kMDCInkLayerBackgroundOpacityAnim];
}

- (void)endBackgroundRipple {
  NSNumber *opacityVal =
      [_backgroundRippleLayer.presentationLayer valueForKeyPath:kMDCInkLayerOpacity];
  if (!opacityVal) {
    opacityVal = [NSNumber numberWithFloat:0];
  }

  // The end (tap release) animation should continue at the opacity level of the start animation.
  CGFloat enterDuration = (1 - opacityVal.floatValue / _maxOpacityLevel) *
                          kMDCInkLayerFastEnterDuration;
  CGFloat duration = kMDCInkLayerBaseOpacityExitDuration + enterDuration;
  _backgroundOpacityAnim =
      [self opacityAnimWithValues:@[ opacityVal, @(_maxOpacityLevel), @0 ]
                            times:@[ @0, @(enterDuration / duration), @1.f ]];
  _backgroundOpacityAnim.duration = duration;
  [_backgroundRippleLayer addAnimation:_backgroundOpacityAnim
                                forKey:kMDCInkLayerBackgroundOpacityAnim];
}

- (void)startForegroundRippleAtPoint:(CGPoint)point {
  _foregroundRippleLayer = [CAShapeLayer layer];
  _foregroundRippleLayer.fillColor = self.inkColor.CGColor;
  _foregroundRippleLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
  [_rippleLayer addSublayer:_foregroundRippleLayer];

  if ([self isBounded]) {
    // Ripples have a random size element so the ripple effect looks more natural when the
    // user taps multiple times in a row.
    CGFloat random = (CGFloat)rand() / RAND_MAX;
    _radius = (CGFloat)(0.9f + random * 0.1f) * kMDCInkLayerRadiusGrowthMultiplier;
  }
  CGRect frame = CGRectMake(0, 0, _radius * 2.f, _radius * 2.f);
  _foregroundRippleLayer.frame = frame;
  UIBezierPath *ripplePath =
      [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                        0,
                                                        _radius * 2.f,
                                                        _radius * 2.f)];
  _foregroundRippleLayer.path = ripplePath.CGPath;
  _foregroundOpacityAnim = [self opacityAnimWithValues:@[ @1, @(_maxOpacityLevel) ]
                                                 times:@[ @0, @1.f ]];
  [_foregroundRippleLayer addAnimation:_foregroundOpacityAnim
                                forKey:kMDCInkLayerForegroundOpacityAnim];

  _foregroundRippleLayerComplete = NO;
  CGFloat duration = (CGFloat)sqrt(_radius / kMDCInkLayerWaveTouchDownAcceleration) +
                     kMDCInkLayerPositionConstantDuration;
  UIBezierPath *movePath = [UIBezierPath bezierPath];

  // Bounded ripples move slightly towards the center of the tap target. Unbounded ripples
  // move to the center of the tap target.
  CGPoint endPoint = MDCInkLayerRectGetCenter(self.frame);
  CGPoint centerOffsetPoint = MDCInkLayerInterpolatePoint(point, endPoint, 0.3f);
  if (self.useCustomInkCenter) {
    endPoint = self.customInkCenter;
  }
  [movePath moveToPoint:point];
  if (_gravitatesInk) {
    if ([self isBounded]) {
      [movePath addLineToPoint:centerOffsetPoint];
    } else {
      [movePath addLineToPoint:endPoint];
    }
  } else {
    [movePath addLineToPoint:point];
  }

  CAMediaTimingFunction *timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  _foregroundPositionAnim = [self positionAnimWithPath:movePath.CGPath
                                              duration:duration
                                        timingFunction:timingFunction];
  [_foregroundRippleLayer addAnimation:_foregroundPositionAnim
                                forKey:kMDCInkLayerForegroundPositionAnim];

  // Bounded ripples have different timing and durations than unbounded ripples.
  if ([self isBounded]) {
    _foregroundScaleAnim = [self scaleAnimWithValues:@[ @0 ] times:@[ @0 ]];
    [_foregroundRippleLayer addAnimation:_foregroundScaleAnim
                                  forKey:kMDCInkLayerForegroundScaleAnim];
  } else {
    _foregroundScaleAnim = [self scaleAnimWithValues:@[ @0, @1.f ] times:@[ @0, @1.f ]];
    _foregroundScaleAnim.duration = duration;
    [_foregroundRippleLayer addAnimation:_foregroundScaleAnim
                                  forKey:kMDCInkLayerForegroundScaleAnim];
  }
}

- (void)endForegroundRipple {
  _foregroundOpacityAnim = [self opacityAnimWithValues:@[ @(_maxOpacityLevel), @0 ]
                                                 times:@[ @0, @1.f ]];
  _foregroundOpacityAnim.duration = kMDCInkLayerBoundedOpacityExitDuration;
  [_foregroundRippleLayer addAnimation:_foregroundOpacityAnim
                                forKey:kMDCInkLayerForegroundOpacityAnim];

  if (!_foregroundRippleLayerComplete) {
    UIBezierPath *movePath = [UIBezierPath bezierPath];

    // Bounded ripples move slightly towards the center of the tap target. Unbounded ripples
    // move to the center of the tap target.
    CGPoint startPoint = [[_foregroundRippleLayer.presentationLayer
        valueForKeyPath:kMDCInkLayerPosition] CGPointValue];
    CGPoint endPoint = MDCInkLayerRectGetCenter(self.frame);
    CGPoint centerOffsetPoint = MDCInkLayerInterpolatePoint(startPoint, endPoint, 0.3f);
    if (self.useCustomInkCenter) {
      endPoint = self.customInkCenter;
    }
    if (_gravitatesInk) {
      [movePath moveToPoint:startPoint];
      if ([self isBounded]) {
        [movePath addLineToPoint:centerOffsetPoint];
      } else {
        [movePath addLineToPoint:endPoint];
      }
    } else {
      [movePath moveToPoint:startPoint];
      [movePath addLineToPoint:startPoint];
    }
    _foregroundPositionAnim = [self positionAnimWithPath:movePath.CGPath
                                                duration:kMDCInkLayerBoundedPositionExitDuration
                                          timingFunction:[self logDecelerateEasing]];
    [_foregroundRippleLayer addAnimation:_foregroundPositionAnim
                                  forKey:kMDCInkLayerForegroundPositionAnim];
  }

  _foregroundScaleAnim.keyTimes = @[ @0, @1.f ];
  _foregroundScaleAnim.timingFunction = [self logDecelerateEasing];

  if ([self isBounded]) {
    _foregroundOpacityAnim.duration = kMDCInkLayerBoundedOpacityExitDuration;
    _foregroundScaleAnim.values = @[ @0, @1.f ];
    _foregroundScaleAnim.duration = kMDCInkLayerBoundedRadiusExitDuration;
    _foregroundPositionAnim.duration = kMDCInkLayerBoundedOriginExitDuration;
  } else {
    NSNumber *opacityVal =
        [_foregroundRippleLayer.presentationLayer valueForKeyPath:kMDCInkLayerOpacity];
    if (!opacityVal) {
      opacityVal = [NSNumber numberWithFloat:0];
    }
    CGFloat normOpacityVal = opacityVal.floatValue / _maxOpacityLevel;
    CGFloat opacityDuration = normOpacityVal / 3.f;
    _foregroundOpacityAnim.duration = opacityDuration;
    NSNumber *scaleVal =
        [_foregroundRippleLayer.presentationLayer valueForKeyPath:kMDCInkLayerScale];
    if (!scaleVal) {
      scaleVal = [NSNumber numberWithFloat:0];
    }
    CGFloat unboundedDuration = (CGFloat)sqrt(((1.f - scaleVal.floatValue) * _radius) /
                                              (kMDCInkLayerWaveTouchDownAcceleration + kMDCInkLayerWaveTouchUpAcceleration)) +
                                kMDCInkLayerUnboundedPositionExitAdjustedDuration;
    _foregroundPositionAnim.duration = unboundedDuration;
    _foregroundScaleAnim.duration = unboundedDuration;
    _foregroundScaleAnim.values = @[ scaleVal, @1.f ];
  }
  [_foregroundRippleLayer addAnimation:_foregroundScaleAnim
                                forKey:kMDCInkLayerForegroundScaleAnim];
  _clearLayerTimer =
      [NSTimer scheduledTimerWithTimeInterval:kMDCInkLayerBoundedRadiusExitDuration
                                       target:self
                                     selector:@selector(reset)
                                     userInfo:nil
                                      repeats:NO];
}

- (void)reset {
  _rippleLayer.sublayers = nil;
}

- (CAKeyframeAnimation *)opacityAnimWithValues:(NSArray *)values times:(NSArray *)times {
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kMDCInkLayerOpacity];
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
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kMDCInkLayerPosition];
  anim.delegate = self;
  anim.duration = duration;
  anim.fillMode = kCAFillModeForwards;
  anim.path = path;
  anim.removedOnCompletion = NO;
  anim.timingFunction = timingFunction;
  return anim;
}

- (CAKeyframeAnimation *)scaleAnimWithValues:(NSArray *)values times:(NSArray *)times {
  CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kMDCInkLayerScale];
  anim.fillMode = kCAFillModeForwards;
  anim.keyTimes = times;
  anim.removedOnCompletion = NO;
  anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  anim.values = values;
  return anim;
}

- (void)evaporateWithCompletion:(void (^)())completionBlock {
  [self endBackgroundRipple];
  [self endForegroundRipple];
  _completionBlock = completionBlock;
}

- (void)evaporateToPoint:(CGPoint)point completion:(void (^)())completionBlock {
  [self endBackgroundRipple];
  [self endForegroundRipple];
  _completionBlock = completionBlock;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  if (flag) {
    _foregroundRippleLayerComplete = YES;
    if (_completionBlock) {
      _completionBlock();
    }
  }
}

- (CAMediaTimingFunction *)logDecelerateEasing {
  // This bezier curve is an approximation of a log curve used in other implementations of ink.
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.157f:0.72f:0.386f:0.987f];
}

@end
