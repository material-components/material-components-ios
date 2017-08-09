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

static NSString *const kMDCFloatingButtonTransformKey = @"kMDCFloatingButtonTransformKey";
static NSString *const kMDCFloatingButtonOpacityKey = @"kMDCFloatingButtonOpacityKey";

static const CGFloat kMDCFloatingButtonTransformScale = 0.00001f;

static const NSTimeInterval kMDCFloatingButtonEnterDuration = 0.270f;
static const NSTimeInterval kMDCFloatingButtonExitDuration = 0.180f;

static const NSTimeInterval kMDCFloatingButtonEnterIconDuration = 0.180f;
static const NSTimeInterval kMDCFloatingButtonEnterIconOffset = 0.090f;
static const NSTimeInterval kMDCFloatingButtonExitIconDuration = 0.135f;
static const NSTimeInterval kMDCFloatingButtonExitIconOffset = 0.000f;

static const NSTimeInterval kMDCFloatingButtonOpacityDuration = 0.015f;
static const NSTimeInterval kMDCFloatingButtonOpacityEnterOffset = 0.030f;
static const NSTimeInterval kMDCFloatingButtonOpacityExitOffset = 0.150f;

@interface MDCButton (Private)
@property (nonatomic, strong) UIView *innerView;
@end

@implementation MDCFloatingButton (Animation)

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
  void (^enterActions)(void) = ^{
    self.innerView.layer.transform = CATransform3DIdentity;
    self.innerView.layer.opacity = 1;
    self.imageView.layer.transform = CATransform3DIdentity;
    [self setNeedsLayout];
    [self.innerView.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    [self.innerView.layer removeAnimationForKey:kMDCFloatingButtonOpacityKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    if (completion) {
      completion();
    }
  };

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:enterActions];

    CABasicAnimation *overallScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]
                   fromValue:nil
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonEnterDuration
                 beginOffset:0];
    [self.innerView.layer addAnimation:overallScaleAnimation forKey:kMDCFloatingButtonTransformKey];

    CABasicAnimation *iconScaleAnimation = [MDCFloatingButton
        animationWithKeypath:@"transform"
                     toValue:[NSValue valueWithCATransform3D:self.innerView.layer.presentationLayer.transform]
                   fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)]
              timingFunction:[[CAMediaTimingFunction alloc]
                                 initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
                    fillMode:kCAFillModeBoth
                    duration:kMDCFloatingButtonEnterIconDuration
                 beginOffset:kMDCFloatingButtonEnterIconOffset];
    [self.imageView.layer addAnimation:iconScaleAnimation forKey:kMDCFloatingButtonTransformKey];

    CABasicAnimation *opacityAnimation = [MDCFloatingButton
        animationWithKeypath:@"opacity"
                     toValue:[NSNumber numberWithInt:1]
                   fromValue:nil
              timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                    fillMode:kCAFillModeForwards
                    duration:kMDCFloatingButtonOpacityDuration
                 beginOffset:kMDCFloatingButtonOpacityEnterOffset];
    [self.innerView.layer addAnimation:opacityAnimation forKey:kMDCFloatingButtonOpacityKey];

    [CATransaction commit];
  } else {
    enterActions();
  }
}

- (void)collapse:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  CATransform3D scaleTransform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(
      kMDCFloatingButtonTransformScale, kMDCFloatingButtonTransformScale));

  void (^exitActions)() = ^{
    self.innerView.layer.transform = scaleTransform;
    self.innerView.layer.opacity = 0;
    self.imageView.layer.transform = scaleTransform;
    [self setNeedsLayout];
    [self.innerView.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    [self.innerView.layer removeAnimationForKey:kMDCFloatingButtonOpacityKey];
    [self.imageView.layer removeAnimationForKey:kMDCFloatingButtonTransformKey];
    if (completion) {
      completion();
    }
  };

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:exitActions];

    CABasicAnimation *overallScaleAnimation =
        [MDCFloatingButton animationWithKeypath:@"transform"
                                        toValue:[NSValue valueWithCATransform3D:scaleTransform]
                                      fromValue:nil
                                 timingFunction:[[CAMediaTimingFunction alloc]
                                                    initWithControlPoints:0.4f:0.0f:1.0f:1.0f]
                                       fillMode:kCAFillModeForwards
                                       duration:kMDCFloatingButtonExitDuration
                                    beginOffset:0];
    [self.innerView.layer addAnimation:overallScaleAnimation forKey:kMDCFloatingButtonTransformKey];

    CABasicAnimation *iconScaleAnimation =
        [MDCFloatingButton animationWithKeypath:@"transform"
                                        toValue:[NSValue valueWithCATransform3D:scaleTransform]
                                      fromValue:nil
                                 timingFunction:[[CAMediaTimingFunction alloc]
                                                    initWithControlPoints:0.0f:0.0f:0.2f:1.0f]
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
    [self.innerView.layer addAnimation:opacityAnimation forKey:kMDCFloatingButtonOpacityKey];

    [CATransaction commit];
  } else {
    exitActions();
  }
}

#pragma mark - UIView frame overrides

/*
 Override the value of the frame so that it appears to be consistent with how the view would look
 when it is not scaled. This is necessary because when the view is transformed by an affine scale,
 the frame will be modified. Apple is very clear that if a UIView's transform is not the identity
 transform, then the value of the frame is undefined and should be ignored.

 Unfortunately, much of our layout code assumes that frames are valid and relies on them instead of
 the view's center and bounds for positioning information. As a result, this method will determine
 what the frame would look like without the transform by using the center and bounds.

 https://developer.apple.com/documentation/uikit/uiview/1622621-frame
 */
//- (CGRect)frame {
//  CGRect frame = [super frame];
//  if (CATransform3DEqualToTransform(self.layer.transform, CATransform3DIdentity)) {
//    return frame;
//  }
//  CGFloat width = CGRectGetWidth(self.bounds);
//  CGFloat height = CGRectGetHeight(self.bounds);
//  return CGRectMake(self.center.x - (width / 2.f), self.center.y - (height / 2.f),
//                    CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
//}

/*
 Apple documents clearly that when a non-identity transform is applied to a UIView, frame
 adjustments should be replaced with center/bounds adjustments instead. Unfortunately since most of
 our existing code does not perform this check, we handle frame adjustments with non-identity
 transforms internally.

 https://developer.apple.com/documentation/uikit/uiview/1622621-frame
 */
//- (void)setFrame:(CGRect)frame {
//  if (CATransform3DEqualToTransform(self.layer.transform, CATransform3DIdentity)) {
//    [super setFrame:frame];
//  } else {
//    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
//    CGSize boundsSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
//    self.center = center;
//    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds),
//                             boundsSize.width, boundsSize.height);
//  }
//}

@end
