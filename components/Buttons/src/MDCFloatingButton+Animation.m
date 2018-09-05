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

#import "MDCFloatingButton+Animation.h"

#if TARGET_IPHONE_SIMULATOR
float UIAnimationDragCoefficient(void);  // Private API for simulator animation speed
#endif

static NSString *const kMDCFloatingButtonTransformKey = @"kMDCFloatingButtonTransformKey";
static NSString *const kMDCFloatingButtonOpacityKey = @"kMDCFloatingButtonOpacityKey";

// By using a power of 2 (2^-12), we can reduce rounding errors during transform multiplication
static const CGFloat kMDCFloatingButtonTransformScale = (CGFloat)0.000244140625;

static const NSTimeInterval kMDCFloatingButtonEnterDuration = 0.270f;
static const NSTimeInterval kMDCFloatingButtonExitDuration = 0.180f;

static const NSTimeInterval kMDCFloatingButtonEnterIconDuration = 0.180f;
static const NSTimeInterval kMDCFloatingButtonEnterIconOffset = 0.090f;
static const NSTimeInterval kMDCFloatingButtonExitIconDuration = 0.135f;
static const NSTimeInterval kMDCFloatingButtonExitIconOffset = 0.000f;

static const NSTimeInterval kMDCFloatingButtonOpacityDuration = 0.015f;
static const NSTimeInterval kMDCFloatingButtonOpacityEnterOffset = 0.030f;
static const NSTimeInterval kMDCFloatingButtonOpacityExitOffset = 0.150f;

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
                                  duration:(NSTimeInterval)duration
                               beginOffset:(NSTimeInterval)beginOffset {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
  animation.toValue = toValue;
  animation.fromValue = fromValue;
  animation.timingFunction = timingFunction;
  animation.fillMode = fillMode;
  animation.removedOnCompletion = NO;
  animation.duration = duration;
  if (fabs(beginOffset) > DBL_EPSILON) {
    animation.beginTime = CACurrentMediaTime() + beginOffset;
  }

#if TARGET_IPHONE_SIMULATOR
  animation.duration *= [self fab_dragCoefficient];
  if (fabs(beginOffset) > DBL_EPSILON) {
    animation.beginTime = CACurrentMediaTime() + (beginOffset * [self fab_dragCoefficient]);
  }
#endif

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

- (void)expand:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  void (^expandActions)(void) = ^{
    self.layer.transform =
        CATransform3DConcat(self.layer.transform, [MDCFloatingButton expandTransform]);
    self.layer.opacity = 1;
    self.imageView.layer.transform =
        CATransform3DConcat(self.imageView.layer.transform, [MDCFloatingButton expandTransform]);
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    if (completion) {
      completion();
    }
  };

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:expandActions];

    CABasicAnimation *overallScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue
                                 valueWithCATransform3D:CATransform3DConcat(
                                                            self.layer.transform,
                                                            [MDCFloatingButton expandTransform])]
                   fromValue:nil
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonEnterDuration
                 beginOffset:0];
    [self.layer addAnimation:overallScaleAnimation forKey:kMDCFloatingButtonTransformKey];

    CALayer *iconPresentationLayer = self.imageView.layer.presentationLayer;
    if (iconPresentationLayer) {
      // Transform from a scale of 0, up to the icon view's current (animated) transform
      CALayer *presentationLayer = self.layer.presentationLayer;
      NSValue *fromValue =
          presentationLayer ? [NSValue valueWithCATransform3D:CATransform3DConcat(
                                                                  presentationLayer.transform,
                                                                  CATransform3DMakeScale(0, 0, 1))]
                            : nil;
      CABasicAnimation *iconScaleAnimation = [MDCFloatingButton
          animationWithKeypath:@"transform"
                       toValue:[NSValue valueWithCATransform3D:iconPresentationLayer.transform]
                     fromValue:fromValue
                timingFunction:[[CAMediaTimingFunction alloc]
                                   initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
                      fillMode:kCAFillModeBoth
                      duration:kMDCFloatingButtonEnterIconDuration
                   beginOffset:kMDCFloatingButtonEnterIconOffset];
      [self.imageView.layer addAnimation:iconScaleAnimation forKey:kMDCFloatingButtonTransformKey];
    }

    CABasicAnimation *opacityAnimation = [MDCFloatingButton
        animationWithKeypath:@"opacity"
                     toValue:[NSNumber numberWithInt:1]
                   fromValue:nil
              timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonOpacityDuration
                 beginOffset:kMDCFloatingButtonOpacityEnterOffset];
    [self.layer addAnimation:opacityAnimation forKey:kMDCFloatingButtonOpacityKey];

    [CATransaction commit];
  } else {
    expandActions();
  }
}

- (void)collapse:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  void (^collapseActions)(void) = ^{
    self.layer.transform =
        CATransform3DConcat(self.layer.transform, [MDCFloatingButton collapseTransform]);
    self.layer.opacity = 0;
    self.imageView.layer.transform =
        CATransform3DConcat(self.imageView.layer.transform, [MDCFloatingButton collapseTransform]);
    [self.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    [self.layer removeAnimationForKey:kMDCFloatingButtonOpacityKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    if (completion) {
      completion();
    }
  };

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:collapseActions];

    CABasicAnimation *overallScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue
                                 valueWithCATransform3D:CATransform3DConcat(
                                                            self.layer.transform,
                                                            [MDCFloatingButton collapseTransform])]
                   fromValue:nil
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.4f:0.0f:1.0f:1.0f]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonExitDuration
                 beginOffset:0];
    [self.layer addAnimation:overallScaleAnimation forKey:kMDCFloatingButtonTransformKey];

    CABasicAnimation *iconScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue
                                 valueWithCATransform3D:CATransform3DConcat(
                                                            self.imageView.layer.transform,
                                                            [MDCFloatingButton collapseTransform])]
                   fromValue:nil
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.4f:0.0f:1.0f:1.0f]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonExitIconDuration
                 beginOffset:kMDCFloatingButtonExitIconOffset];
    [self.imageView.layer addAnimation:iconScaleAnimation forKey:kMDCFloatingButtonTransformKey];

    CABasicAnimation *opacityAnimation = [MDCFloatingButton
        animationWithKeypath:@"opacity"
                     toValue:[NSNumber numberWithFloat:0]
                   fromValue:nil
              timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonOpacityDuration
                 beginOffset:kMDCFloatingButtonOpacityExitOffset];
    [self.layer addAnimation:opacityAnimation forKey:kMDCFloatingButtonOpacityKey];

    [CATransaction commit];
  } else {
    collapseActions();
  }
}

@end
