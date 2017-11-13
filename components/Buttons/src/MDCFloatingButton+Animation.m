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

#import "MDCFloatingButton+Animation.h"

#if TARGET_IPHONE_SIMULATOR
float UIAnimationDragCoefficient(void);  // Private API for simulator animation speed
#endif

static NSString *const kMDCFloatingButtonTransformCollapseKey =
    @"kMDCFloatingButtonTransformCollapseKey";
static NSString *const kMDCFloatingButtonTransformExpandKey =
    @"kMDCFloatingButtonTransformExpandKey";
static NSString *const kMDCFloatingButtonOpacityHiddenKey = @"kMDCFloatingButtonOpacityHiddenKey";
static NSString *const kMDCFloatingButtonOpacityVisibleKey = @"kMDCFloatingButtonOpacityVisibleKey";

// By using a power of 2 (2^-12), we can reduce rounding errors during transform multiplication
static const CGFloat kMDCFloatingButtonTransformScale = (CGFloat)0.000244140625;

static const NSTimeInterval kMDCFloatingButtonEnterDuration = 0.270f;
static const NSTimeInterval kMDCFloatingButtonExitDuration = 0.180f;

static const NSTimeInterval kMDCFloatingButtonEnterIconDuration = 0.180f;
static const NSTimeInterval kMDCFloatingButtonEnterIconDelay = 0.090f;
static const NSTimeInterval kMDCFloatingButtonExitIconDuration = 0.135f;
static const NSTimeInterval kMDCFloatingButtonExitIconDelay = 0.000f;

static const NSTimeInterval kMDCFloatingButtonOpacityDuration = 0.015f;
static const NSTimeInterval kMDCFloatingButtonOpacityEnterDelay = 0.030f;
static const NSTimeInterval kMDCFloatingButtonOpacityExitDelay = 0.150f;

@implementation MDCFloatingButton (Animation)

+ (CATransform3D)collapseTransform {
  return CATransform3DMakeScale(kMDCFloatingButtonTransformScale, kMDCFloatingButtonTransformScale,
                                1);
}

+ (CATransform3D)expandTransform {
  return CATransform3DInvert([MDCFloatingButton collapseTransform]);
}

+ (CABasicAnimation *)animationWithKeypath:(nonnull NSString *)keyPath
                                   toValue:(nonnull id)toValue
                                 fromValue:(nullable id)fromValue
                            timingFunction:(nonnull CAMediaTimingFunction *)timingFunction
                                  fillMode:(nonnull NSString *)fillMode
                                  duration:(CFTimeInterval)duration
                                 beginTime:(CFTimeInterval)beginTime {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
  animation.toValue = toValue;
  animation.fromValue = fromValue;
  animation.timingFunction = timingFunction;
  animation.fillMode = fillMode;
  animation.removedOnCompletion = NO;
  animation.duration = duration;
  if (fabs(beginTime) > DBL_EPSILON) {
    animation.beginTime = beginTime;
  }

  return animation;
}

#if TARGET_IPHONE_SIMULATOR
+ (float)fab_dragCoefficient {
  if (&UIAnimationDragCoefficient) {
    float coeff = UIAnimationDragCoefficient();
    if (coeff > 1) {
      return coeff;
    }
  }
  return 1;
}
#endif

+ (CFTimeInterval)fab_animationDurationFromWallTimeDuration:(CFTimeInterval)duration
                                                   forLayer:(CALayer *)layer {
  CFTimeInterval finalDuration = duration;

#if TARGET_IPHONE_SIMULATOR
  finalDuration *= [self fab_dragCoefficient];
#endif

  return [layer convertTime:finalDuration fromLayer:nil];
}

+ (CFTimeInterval)fab_animationBeginTimeFromWallTimeDelay:(CFTimeInterval)delay
                                                 forLayer:(CALayer *)layer {
  CFTimeInterval beginTime = delay;

#if TARGET_IPHONE_SIMULATOR
  beginTime *= [self fab_dragCoefficient];
#endif

  beginTime += CACurrentMediaTime();
  return beginTime;
}

- (void)expand:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  // If both X- and Y-scale values are 1 or greater, do not expand
  if (self.layer.transform.m11 >= 1 && self.layer.transform.m22 >= 1) {
    return;
  }

  void (^expandActions)(void) = ^{
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformExpandKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityVisibleKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformExpandKey];
    if (completion) {
      completion();
    }
  };

  CATransform3D layerTransformToValue =
      CATransform3DConcat(self.layer.transform, [MDCFloatingButton expandTransform]);

  CALayer *iconPresentationLayer = self.imageView.layer.presentationLayer;
  CATransform3D iconTransformToValue =
      iconPresentationLayer ? iconPresentationLayer.transform : self.imageView.layer.transform;

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:expandActions];

    CALayer *presentationLayer = self.layer.presentationLayer;
    NSValue *fromValue =
        presentationLayer ? [NSValue valueWithCATransform3D:presentationLayer.transform] : nil;

    CFTimeInterval duration =
        [MDCFloatingButton fab_animationDurationFromWallTimeDuration:kMDCFloatingButtonEnterDuration
                                                            forLayer:self.layer];
    CFTimeInterval beginTime =
        [MDCFloatingButton fab_animationBeginTimeFromWallTimeDelay:0 forLayer:self.layer];

    CABasicAnimation *overallScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue valueWithCATransform3D:layerTransformToValue]
                   fromValue:fromValue
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
                    fillMode:kCAFillModeBoth
                    duration:duration
                   beginTime:beginTime];
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformExpandKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformCollapseKey];
    [self.layer addAnimation:overallScaleAnimation forKey:kMDCFloatingButtonTransformExpandKey];

    if (iconPresentationLayer) {
      // Transform from a scale of 0, up to the icon view's current (animated) transform
      NSValue *iconTransformFromValue =
          presentationLayer ? [NSValue valueWithCATransform3D:CATransform3DConcat(
                                                                  presentationLayer.transform,
                                                                  CATransform3DMakeScale(0, 0, 1))]
                            : nil;

      duration = [MDCFloatingButton
          fab_animationDurationFromWallTimeDuration:kMDCFloatingButtonEnterIconDuration
                                           forLayer:self.imageView.layer];
      beginTime = [MDCFloatingButton
          fab_animationBeginTimeFromWallTimeDelay:kMDCFloatingButtonEnterIconDelay
                                         forLayer:self.imageView.layer];
      CABasicAnimation *iconScaleAnimation = [MDCFloatingButton
          animationWithKeypath:@"transform"
                       toValue:[NSValue valueWithCATransform3D:iconTransformToValue]
                     fromValue:iconTransformFromValue
                timingFunction:[[CAMediaTimingFunction alloc]
                                   initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
                      fillMode:kCAFillModeBoth
                      duration:duration
                     beginTime:beginTime];
      [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformExpandKey];
      [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformCollapseKey];
      [self.imageView.layer addAnimation:iconScaleAnimation
                                  forKey:kMDCFloatingButtonTransformExpandKey];
    }

    duration = [MDCFloatingButton
        fab_animationDurationFromWallTimeDuration:kMDCFloatingButtonOpacityDuration
                                         forLayer:self.layer];
    beginTime = [MDCFloatingButton
        fab_animationBeginTimeFromWallTimeDelay:kMDCFloatingButtonOpacityEnterDelay
                                       forLayer:self.layer];

    CABasicAnimation *opacityAnimation = [MDCFloatingButton
        animationWithKeypath:@"opacity"
                     toValue:[NSNumber numberWithInt:1]
                   fromValue:(presentationLayer
                                  ? [NSNumber numberWithFloat:presentationLayer.opacity]
                                  : nil)timingFunction
                            :[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                    fillMode:kCAFillModeBoth
                    duration:duration
                   beginTime:beginTime];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityHiddenKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityVisibleKey];
    [self.layer addAnimation:opacityAnimation forKey:kMDCFloatingButtonOpacityVisibleKey];

    [CATransaction commit];

    self.layer.transform = layerTransformToValue;
    self.layer.opacity = 1;
    self.imageView.layer.transform = iconTransformToValue;
  } else {
    self.layer.transform = layerTransformToValue;
    self.layer.opacity = 1;
    self.imageView.layer.transform = iconTransformToValue;
    expandActions();
  }
}

- (void)collapse:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  void (^collapseActions)(void) = ^{
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformCollapseKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityHiddenKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformCollapseKey];

    if (completion) {
      completion();
    }
  };

  CATransform3D layerTransformToValue =
      CATransform3DConcat(self.layer.transform, [MDCFloatingButton collapseTransform]);

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:collapseActions];

    CFTimeInterval duration =
        [MDCFloatingButton fab_animationDurationFromWallTimeDuration:kMDCFloatingButtonExitDuration
                                                            forLayer:self.layer];
    CFTimeInterval beginTime =
        [MDCFloatingButton fab_animationBeginTimeFromWallTimeDelay:0 forLayer:self.layer];

    CALayer *presentationLayer = self.layer.presentationLayer;
    NSValue *fromValue =
        presentationLayer ? [NSValue valueWithCATransform3D:presentationLayer.transform] : nil;
    CABasicAnimation *overallScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue valueWithCATransform3D:layerTransformToValue]
                   fromValue:fromValue
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.4f:0.0f:1.0f:1.0f]
                    fillMode:kCAFillModeBoth
                    duration:duration
                   beginTime:beginTime];
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformCollapseKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformExpandKey];
    [self.layer addAnimation:overallScaleAnimation forKey:kMDCFloatingButtonTransformCollapseKey];

    duration = [MDCFloatingButton
        fab_animationDurationFromWallTimeDuration:kMDCFloatingButtonExitIconDuration
                                         forLayer:self.layer];
    beginTime =
        [MDCFloatingButton fab_animationBeginTimeFromWallTimeDelay:kMDCFloatingButtonExitIconDelay
                                                          forLayer:self.layer];

    CABasicAnimation *iconScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue
                                 valueWithCATransform3D:CATransform3DConcat(
                                                            self.imageView.layer.transform,
                                                            [MDCFloatingButton collapseTransform])]
                   fromValue:nil
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.4f:0.0f:1.0f:1.0f]
                    fillMode:kCAFillModeBoth
                    duration:duration
                   beginTime:beginTime];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformExpandKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformCollapseKey];
    [self.imageView.layer addAnimation:iconScaleAnimation
                                forKey:kMDCFloatingButtonTransformCollapseKey];

    duration = [MDCFloatingButton
        fab_animationDurationFromWallTimeDuration:kMDCFloatingButtonOpacityDuration
                                         forLayer:self.layer];
    beginTime = [MDCFloatingButton
        fab_animationBeginTimeFromWallTimeDelay:kMDCFloatingButtonOpacityExitDelay
                                       forLayer:self.layer];

    CABasicAnimation *opacityAnimation = [MDCFloatingButton
        animationWithKeypath:@"opacity"
                     toValue:[NSNumber numberWithFloat:0]
                   fromValue:(presentationLayer
                                  ? [NSNumber numberWithFloat:presentationLayer.opacity]
                                  : nil)timingFunction
                            :[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                    fillMode:kCAFillModeBoth
                    duration:duration
                   beginTime:beginTime];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityVisibleKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityHiddenKey];
    [self.layer addAnimation:opacityAnimation forKey:kMDCFloatingButtonOpacityHiddenKey];

    [CATransaction commit];

    self.layer.transform = layerTransformToValue;
    self.layer.opacity = 0;
    self.imageView.layer.transform =
        CATransform3DConcat(self.imageView.layer.transform, [MDCFloatingButton collapseTransform]);
  } else {
    self.layer.transform = layerTransformToValue;
    self.layer.opacity = 0;
    self.imageView.layer.transform =
        CATransform3DConcat(self.imageView.layer.transform, [MDCFloatingButton collapseTransform]);
    collapseActions();
  }
}

@end
