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

static const CGFloat kMDCFloatingButtonTransformScale = 0.00001F;

static const NSTimeInterval kMDCFloatingButtonEnterDuration = 0.270F;
static const NSTimeInterval kMDCFloatingButtonExitDuration = 0.180F;

static const NSTimeInterval kMDCFloatingButtonEnterIconDuration = 10.180F;
static const NSTimeInterval kMDCFloatingButtonEnterIconOffset = 0.090F;
static const NSTimeInterval kMDCFloatingButtonExitIconDuration = 0.135F;
static const NSTimeInterval kMDCFloatingButtonExitIconOffset = 0.000F;

static const NSTimeInterval kMDCFloatingButtonOpacityDuration = 0.015F;
static const NSTimeInterval kMDCFloatingButtonOpacityEnterOffset = 0.030F;
static const NSTimeInterval kMDCFloatingButtonOpacityExitOffset = 0.150F;

@implementation MDCFloatingButton (Animation)

#if TARGET_IPHONE_SIMULATOR
- (float)fab_dragCoefficient {
  if (&UIAnimationDragCoefficient) {
    float coeff = UIAnimationDragCoefficient();
    if (coeff > 1) {
      return coeff;
    }
  }
  return 1;
}
#endif

- (void)enter:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  void (^enterActions)(void) = ^{
    self.layer.transform = CATransform3DIdentity;
    self.layer.opacity = 1;
    self.imageView.layer.transform = CATransform3DIdentity;
    [self.layer removeAnimationForKey:@"kMDCFloatingButtontransform"];
    [self.layer removeAnimationForKey:@"kMDCFloatingButtonopacity"];
    [self.imageView.layer removeAnimationForKey:@"kMDCFloatingButtontransform"];
    if (completion) {
      completion();
    }
    NSLog(@"%@", [self.layer animationKeys]);

  };
  NSLog(@"%@", [self.layer animationKeys]);

  [self.layer removeAllAnimations];
  [self.imageView.layer removeAllAnimations];

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:enterActions];

    CABasicAnimation *overallScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    overallScaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    overallScaleAnimation.timingFunction =
        [[CAMediaTimingFunction alloc] initWithControlPoints:0.0f:0.0f:0.2f:1.0f];
    overallScaleAnimation.fillMode = kCAFillModeForwards;
    overallScaleAnimation.removedOnCompletion = NO;
    overallScaleAnimation.duration = kMDCFloatingButtonEnterDuration;
#if TARGET_IPHONE_SIMULATOR
    overallScaleAnimation.duration *= [self fab_dragCoefficient];
#endif
    [self.layer addAnimation:overallScaleAnimation forKey:@"kMDCFloatingButtontransform"];

    CABasicAnimation *iconScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    iconScaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    iconScaleAnimation.timingFunction =
        [[CAMediaTimingFunction alloc] initWithControlPoints:0.0f:0.0f:0.2f:1.0f];
    iconScaleAnimation.fillMode = kCAFillModeForwards;
    iconScaleAnimation.removedOnCompletion = NO;
    iconScaleAnimation.duration = kMDCFloatingButtonEnterIconDuration;
    iconScaleAnimation.beginTime = CACurrentMediaTime() + kMDCFloatingButtonEnterIconOffset;
#if TARGET_IPHONE_SIMULATOR
    iconScaleAnimation.duration *= [self fab_dragCoefficient];
    iconScaleAnimation.beginTime =
        CACurrentMediaTime() + (kMDCFloatingButtonEnterIconOffset * [self fab_dragCoefficient]);
#endif
    [self.imageView.layer addAnimation:iconScaleAnimation forKey:@"kMDCFloatingButtontransform"];

    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue = [NSNumber numberWithInt:1];
    opacityAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.duration = kMDCFloatingButtonOpacityDuration;
    opacityAnimation.beginTime = CACurrentMediaTime() + kMDCFloatingButtonOpacityEnterOffset;
#if TARGET_IPHONE_SIMULATOR
    opacityAnimation.duration *= [self fab_dragCoefficient];
    opacityAnimation.beginTime =
        CACurrentMediaTime() + (kMDCFloatingButtonOpacityEnterOffset * [self fab_dragCoefficient]);
#endif
    [self.layer addAnimation:opacityAnimation forKey:@"kMDCFloatingButtonopacity"];

    [CATransaction commit];
  } else {
    enterActions();
  }
}

- (void)exit:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  CATransform3D scaleTransform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(
      kMDCFloatingButtonTransformScale, kMDCFloatingButtonTransformScale));
  NSLog(@"%@", [self.layer animationKeys]);
  void (^exitActions)() = ^{
    self.layer.transform = scaleTransform;
    self.layer.opacity = 0;
    self.imageView.layer.transform = scaleTransform;
    [self.layer removeAnimationForKey:@"kMDCFloatingButtontransformexit"];
    [self.layer removeAnimationForKey:@"kMDCFloatingButtonopacityexit"];
    [self.imageView.layer removeAnimationForKey:@"kMDCFloatingButtontransformexit"];
    if (completion) {
      completion();
    }
    NSLog(@"%@", [self.layer animationKeys]);
  };

  [self.layer removeAllAnimations];
  [self.imageView.layer removeAllAnimations];

  if (animated) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:exitActions];

    CABasicAnimation *overallScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    overallScaleAnimation.toValue = [NSValue valueWithCATransform3D:scaleTransform];
    overallScaleAnimation.timingFunction =
        [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:1.0f:1.0f];
    overallScaleAnimation.fillMode = kCAFillModeForwards;
    overallScaleAnimation.removedOnCompletion = NO;
    overallScaleAnimation.duration = kMDCFloatingButtonExitDuration;
#if TARGET_IPHONE_SIMULATOR
    overallScaleAnimation.duration *= [self fab_dragCoefficient];
#endif
    [self.layer addAnimation:overallScaleAnimation forKey:@"kMDCFloatingButtontransformexit"];

    CABasicAnimation *iconScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    iconScaleAnimation.toValue = [NSValue valueWithCATransform3D:scaleTransform];
    iconScaleAnimation.timingFunction =
        [[CAMediaTimingFunction alloc] initWithControlPoints:0.0f:0.0f:0.2f:1.0f];
    iconScaleAnimation.fillMode = kCAFillModeForwards;
    iconScaleAnimation.removedOnCompletion = NO;
    iconScaleAnimation.duration = kMDCFloatingButtonExitIconDuration;
    iconScaleAnimation.beginTime = CACurrentMediaTime() + kMDCFloatingButtonExitIconOffset;
#if TARGET_IPHONE_SIMULATOR
    iconScaleAnimation.duration *= [self fab_dragCoefficient];
    iconScaleAnimation.beginTime =
        CACurrentMediaTime() + (kMDCFloatingButtonExitIconOffset * [self fab_dragCoefficient]);
#endif
    [self.imageView.layer addAnimation:iconScaleAnimation
                                forKey:@"kMDCFloatingButtontransformexit"];

    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0];
    opacityAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.duration = kMDCFloatingButtonOpacityDuration;
    opacityAnimation.beginTime = CACurrentMediaTime() + kMDCFloatingButtonOpacityExitOffset;
#if TARGET_IPHONE_SIMULATOR
    opacityAnimation.duration *= [self fab_dragCoefficient];
    opacityAnimation.beginTime =
        CACurrentMediaTime() + (kMDCFloatingButtonOpacityExitOffset * [self fab_dragCoefficient]);
#endif
    [self.layer addAnimation:opacityAnimation forKey:@"kMDCFloatingButtonopacityexit"];

    [CATransaction commit];
  } else {
    exitActions();
  }
}

#pragma mark - UIView overrides to handle non-identity transforms

- (CGRect)frame {
  CGRect frame = [super frame];
  if (CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity)) {
    return frame;
  }
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = CGRectGetHeight(self.bounds);
  return CGRectMake(self.center.x - (width / 2.F), self.center.y - (height / 2.F),
                    CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setFrame:(CGRect)frame {
  if (CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity)) {
    [super setFrame:frame];
  } else {
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGSize boundsSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.center = center;
    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds),
                             boundsSize.width, boundsSize.height);
  }
}

@end
