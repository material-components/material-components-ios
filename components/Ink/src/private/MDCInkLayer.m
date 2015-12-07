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

// Default maximum ripple size. (from http://go/qinkdemo)
const CGFloat kMDCInkMaxRippleRadius = 150;
// Actual radius of the ripple in the CAShapeLayer and is used
// to work out the correct scale transform when expanding the ripple.
const CGFloat kMDCInkActualRippleRadius = 20;
// The scale at which the ripple first appears.
const CGFloat kMDCInkRippleInitialScale = 0.01f;
// An applied opacity to the ripple. Since the alpha in the inkColor, this
// is left at 1.0.
const CGFloat kMDCInkRippleInitialOpacity = 1.0f;

// Transform names
static NSString *const kMDCInkLayerAnimationNameRippleSpread = @"RippleSpread";
static NSString *const kMDCInkLayerAnimationNameRippleCondense = @"RippleCondense";
static NSString *const kMDCInkLayerAnimationNameRippleFadeOut = @"RippleFadeOut";
static NSString *const kMDCInkLayerAnimationNameRippleSpreadFurther = @"RippleSpreadFurther";
static NSString *const kMDCInkLayerAnimationNameBackgroundFade = @"BackgroundFade";

// State tracking for ink.
typedef NS_ENUM(NSInteger, MDCInkRippleState) {
  kMDCInkRippleNone,
  kMDCInkRippleSpreading,
};

static inline CGPoint MDCRectGetCenter(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

static inline CGFloat MDCRectHypotenuse(CGRect rect) {
  return hypot(CGRectGetWidth(rect), CGRectGetHeight(rect));
}

@implementation MDCInkLayer {
  // All the ripples we're animating.
  NSMutableArray *_ripples;

  // Background mask.
  CALayer *_backgroundFadeLayer;

  // Time the drop starts to spread.
  CFAbsoluteTime _dropStartTime;

  MDCInkRippleState _rippleState;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor].CGColor;
    _rippleState = kMDCInkRippleNone;
    _inkColor = [self defaultInkColor];
    _maxRippleRadius = kMDCInkMaxRippleRadius;
    _shouldFillBackgroundOnSpread = YES;
    _gravitatesInk = YES;
    _ripples = [NSMutableArray array];

    _backgroundFadeLayer = [CALayer layer];
    _backgroundFadeLayer.bounds = self.bounds;
    _backgroundFadeLayer.position = MDCRectGetCenter(self.bounds);
    _backgroundFadeLayer.backgroundColor = _inkColor.CGColor;
    _backgroundFadeLayer.opacity = 0;
    [self addSublayer:_backgroundFadeLayer];
  }
  return self;
}

- (void)layoutSublayers {
  [super layoutSublayers];

  _backgroundFadeLayer.position = MDCRectGetCenter(self.bounds);
  _backgroundFadeLayer.bounds = self.bounds;
}

#pragma mark - Properties

- (void)setInkColor:(UIColor *)inkColor {
  if (!inkColor) {
    inkColor = [self defaultInkColor];
  }

  _inkColor = inkColor;

  // Update the background colors.
  _backgroundFadeLayer.backgroundColor = _inkColor.CGColor;
  for (CAShapeLayer *ripple in _ripples) {
    ripple.fillColor = _inkColor.CGColor;
  }
}

#pragma mark - Layers

- (CAShapeLayer *)rippleLayer {
  CGRect circleBounds =
      CGRectMake(0, 0, kMDCInkActualRippleRadius * 2, kMDCInkActualRippleRadius * 2);
  CAShapeLayer *circle = [CAShapeLayer layer];
  circle.bounds = circleBounds;
  circle.position = MDCRectGetCenter(self.bounds);
  circle.path = [UIBezierPath bezierPathWithOvalInRect:circleBounds].CGPath;
  circle.opacity = 0;
  circle.fillColor = _inkColor.CGColor;
  return circle;
}

#pragma mark - Animation Functions

- (CGFloat)rippleRadius {
  CGFloat rippleRadius = MDCRectHypotenuse(self.bounds);
  if (_maxRippleRadius > 0) {
    return MIN(rippleRadius, _maxRippleRadius);
  } else {
    return rippleRadius;
  }
}

- (NSTimeInterval)spreadDuration {
  if (_maxRippleRadius > 0) {
    return [self rippleRadius] * 0.003;  // 100pt = 0.3ms
  }
  return 1.1;
}

- (NSTimeInterval)evaporateDuration {
  return 0.3;
}

- (NSTimeInterval)spreadNearlyDoneDuration {
  return [self spreadDuration] / 2;
}

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
    CGFloat fraction = (1 - powf(80.f, -ratio));

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

#pragma mark -

- (void)reset {
  for (NSUInteger i = 0; i < [_ripples count]; i++) {
    [self evaporateWithCompletion:nil];
  }
}

- (void)spreadFromPoint:(CGPoint)point completion:(MDCInkCompletionBlock)completionBlock {
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

  CAShapeLayer *ripple = [self rippleLayer];
  [self addSublayer:ripple];
  [_ripples addObject:ripple];

  // Initialize the blast start point.
  [CATransaction begin];
  [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
  ripple.position = point;
  ripple.opacity = kMDCInkRippleInitialOpacity;
  ripple.transform =
      CATransform3DMakeScale(kMDCInkRippleInitialScale, kMDCInkRippleInitialScale, 1);
  [CATransaction commit];

  // Fade the background.
  if ([_ripples count] < 2) {
    [self backgroundFadeIn];
  }

  // Animate the ripple spreading from the initial size to our desired max size.
  CGFloat scale = [self rippleRadius] / kMDCInkActualRippleRadius;
  CGPoint layerCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  if (_useCustomInkCenter) {
    layerCenter = _customInkCenter;
  }
  CAKeyframeAnimation *rippleSpread = [self inkSpreadAnimationWithDuration:[self spreadDuration]
                                                                 fromScale:kMDCInkRippleInitialScale
                                                                   toScale:scale
                                                                fromCenter:point
                                                                  toCenter:layerCenter];
  rippleSpread.keyPath = @"transform";
  ripple.transform = [[rippleSpread.values lastObject] CATransform3DValue];

  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    _dropStartTime = 0;
    if (completionBlock) {
      completionBlock();
    }
  }];
  [ripple addAnimation:rippleSpread forKey:kMDCInkLayerAnimationNameRippleSpread];
  [CATransaction commit];

  _dropStartTime = CFAbsoluteTimeGetCurrent();
}

- (void)evaporateWithCompletion:(MDCInkCompletionBlock)completionBlock {
  // Pop the first ripple out of the list and evaporate that.
  CAShapeLayer *ripple = [_ripples firstObject];
  if (!ripple)
    return;
  [_ripples removeObject:ripple];

  // Remove background if this is the last ripple.
  if ([_ripples count] < 1) {
    [self backgroundFadeOut];
  }

  // Spread the ink outwards while fading it out.
  BOOL completedInkSpread =
      _shouldFillBackgroundOnSpread &&
      (CFAbsoluteTimeGetCurrent() - _dropStartTime) > [self spreadNearlyDoneDuration];

  CGFloat doubleScale = 2 * [self rippleRadius] / kMDCInkActualRippleRadius;
  CATransform3D doubleScaleTransform = CATransform3DMakeScale(doubleScale, doubleScale, 1);
  CABasicAnimation *rippleExpand = [CABasicAnimation animationWithKeyPath:@"transform"];
  rippleExpand.fromValue = nil;
  rippleExpand.toValue = [NSValue valueWithCATransform3D:doubleScaleTransform];
  if (completedInkSpread) {
    ripple.transform = doubleScaleTransform;
  }

  CABasicAnimation *rippleFadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
  rippleFadeOut.fromValue = nil;
  rippleFadeOut.toValue = @(0);
  ripple.opacity = 0;

  [CATransaction begin];
  [CATransaction setAnimationDuration:[self evaporateDuration]];
  [CATransaction setAnimationTimingFunction:
                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
  [CATransaction setCompletionBlock:^{
    [ripple removeFromSuperlayer];
    if ([_ripples count] < 1) {
      _rippleState = kMDCInkRippleNone;
    }
    if (completionBlock) {
      completionBlock();
    }
  }];
  [ripple addAnimation:rippleFadeOut forKey:kMDCInkLayerAnimationNameRippleFadeOut];
  if (completedInkSpread) {
    [ripple addAnimation:rippleExpand forKey:kMDCInkLayerAnimationNameRippleSpreadFurther];
  }
  [CATransaction commit];
}

- (void)evaporateToPoint:(CGPoint)point completion:(MDCInkCompletionBlock)completionBlock {
  CAShapeLayer *ripple = [_ripples firstObject];
  if (!ripple)
    return;
  [_ripples removeObject:ripple];

  if ([_ripples count] < 1) {
    [self backgroundFadeOut];
  }

  CGPoint translation = CGPointMake(point.x - ripple.position.x, point.y - ripple.position.y);
  CATransform3D rippleTransform = CATransform3DIdentity;
  rippleTransform = CATransform3DTranslate(rippleTransform, translation.x, translation.y, 1);
  rippleTransform = CATransform3DScale(rippleTransform, 0.2f, 0.2f, 1);

  CABasicAnimation *rippleCondense = [CABasicAnimation animationWithKeyPath:@"transform"];
  rippleCondense.fromValue = nil;
  rippleCondense.toValue = [NSValue valueWithCATransform3D:rippleTransform];
  ripple.transform = rippleTransform;

  CABasicAnimation *rippleFadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
  rippleFadeOut.fromValue = nil;  // @(kMDCInkRippleInitialOpacity);
  rippleFadeOut.toValue = @(0);
  ripple.opacity = 0;

  [CATransaction begin];
  [CATransaction setAnimationDuration:[self evaporateDuration]];
  [CATransaction setAnimationTimingFunction:
                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
  [CATransaction setCompletionBlock:^{
    [ripple removeFromSuperlayer];
    if ([_ripples count] < 1) {
      _rippleState = kMDCInkRippleNone;
    }
    if (completionBlock) {
      completionBlock();
    }
  }];
  [ripple addAnimation:rippleCondense forKey:kMDCInkLayerAnimationNameRippleCondense];
  [ripple addAnimation:rippleFadeOut forKey:kMDCInkLayerAnimationNameRippleFadeOut];
  [CATransaction commit];
}

#pragma mark - Background Fading

- (void)backgroundFadeIn {
  if (_shouldFillBackgroundOnSpread) {
    CABasicAnimation *backgroundFadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    backgroundFadeIn.fromValue = @(0);
    backgroundFadeIn.toValue = @(kMDCInkRippleInitialOpacity);
    backgroundFadeIn.duration = [self spreadDuration];
    backgroundFadeIn.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _backgroundFadeLayer.opacity = kMDCInkRippleInitialOpacity;
    [_backgroundFadeLayer addAnimation:backgroundFadeIn
                                forKey:kMDCInkLayerAnimationNameBackgroundFade];
  }
}

- (void)backgroundFadeOut {
  if (_shouldFillBackgroundOnSpread) {
    CABasicAnimation *backgroundFadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    backgroundFadeOut.fromValue = nil;
    backgroundFadeOut.toValue = @(0);
    backgroundFadeOut.duration = [self evaporateDuration];
    backgroundFadeOut.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _backgroundFadeLayer.opacity = 0;
    [_backgroundFadeLayer addAnimation:backgroundFadeOut
                                forKey:kMDCInkLayerAnimationNameBackgroundFade];
  }
}

- (UIColor *)defaultInkColor {
  return [[UIColor alloc] initWithWhite:1 alpha:0.25];
}

@end
