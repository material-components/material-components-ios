// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UIView+MDCShadowAnimations.h"  // SubtargetImport

@implementation UIView (MDCShadowAnimations)

#pragma mark - Public

- (void)mdc_animateCornerRadiusToValue:(CGFloat)value
                              duration:(CGFloat)duration
                               options:(UIViewAnimationOptions)options
                        timingFunction:(CAMediaTimingFunction *)timingFunction
                            completion:(void (^)(BOOL finished))completion {
  [self mdc_transactionAnimationWithRect:nil
                            animationKey:@"shadowAnimation"
                             centerValue:nil
                            cornerRadius:@(value)
                                duration:duration
                                 options:options
                                 pathKey:@"shadowPath"
                          timingFunction:timingFunction
                              completion:completion];
}

- (void)mdc_animateBoundsToRect:(CGRect)rect
                       duration:(CGFloat)duration
                        options:(UIViewAnimationOptions)options
                 timingFunction:(CAMediaTimingFunction *)timingFunction
                     completion:(void (^)(BOOL finished))completion {
  [self mdc_transactionAnimationWithRect:[NSValue valueWithCGRect:rect]
                            animationKey:@"shadowAnimation"
                             centerValue:nil
                            cornerRadius:nil
                                duration:duration
                                 options:options
                                 pathKey:@"shadowPath"
                          timingFunction:timingFunction
                              completion:completion];
}

- (void)mdc_animateBoundsWithCenterToRect:(CGRect)rect
                                   center:(CGPoint)center
                                 duration:(CGFloat)duration
                                  options:(UIViewAnimationOptions)options
                           timingFunction:(CAMediaTimingFunction *)timingFunction
                               completion:(void (^)(BOOL finished))completion {
  [self mdc_transactionAnimationWithRect:[NSValue valueWithCGRect:rect]
                            animationKey:@"shadowAnimation"
                             centerValue:[NSValue valueWithCGPoint:center]
                            cornerRadius:nil
                                duration:duration
                                 options:options
                                 pathKey:@"shadowPath"
                          timingFunction:timingFunction
                              completion:completion];
}

- (void)mdc_animateBoundsWithCornerRadiusToRect:(CGRect)rect
                                   cornerRadius:(CGFloat)cornerRadius
                                       duration:(CGFloat)duration
                                        options:(UIViewAnimationOptions)options
                                 timingFunction:(CAMediaTimingFunction *)timingFunction
                                     completion:(void (^)(BOOL finished))completion {
  [self mdc_transactionAnimationWithRect:[NSValue valueWithCGRect:rect]
                            animationKey:@"shadowAnimation"
                             centerValue:nil
                            cornerRadius:@(cornerRadius)
                                duration:duration
                                 options:options
                                 pathKey:@"shadowPath"
                          timingFunction:timingFunction
                              completion:completion];
}

- (void)mdc_animateBoundsWithCenterAndCornerRadiusToRect:(CGRect)rect
                                                  center:(CGPoint)center
                                            cornerRadius:(CGFloat)cornerRadius
                                                duration:(CGFloat)duration
                                                 options:(UIViewAnimationOptions)options
                                          timingFunction:(CAMediaTimingFunction *)timingFunction
                                              completion:(void (^)(BOOL finished))completion {
  [self mdc_transactionAnimationWithRect:[NSValue valueWithCGRect:rect]
                            animationKey:@"shadowAnimation"
                             centerValue:[NSValue valueWithCGPoint:center]
                            cornerRadius:@(cornerRadius)
                                duration:duration
                                 options:options
                                 pathKey:@"shadowPath"
                          timingFunction:timingFunction
                              completion:completion];
}

#pragma mark - Private

- (void)mdc_transactionAnimationWithRect:(nullable NSValue *)rectValue
                            animationKey:(NSString *)animationKey
                             centerValue:(nullable NSValue *)centerValue
                            cornerRadius:(nullable NSNumber *)cornerRadiusNumber
                                duration:(CGFloat)duration
                                 options:(UIViewAnimationOptions)options
                                 pathKey:(NSString *)pathKey
                          timingFunction:(CAMediaTimingFunction *)timingFunction
                              completion:(void (^)(BOOL finished))completion {
  CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:pathKey];

  CGFloat targetCornerRadius =
      cornerRadiusNumber ? [cornerRadiusNumber floatValue] : self.layer.cornerRadius;
  CGRect targetRect = rectValue ? rectValue.CGRectValue : self.bounds;
  CGPoint targetCenter = centerValue ? centerValue.CGPointValue : self.center;

  shadowAnimation.fromValue = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:self.layer.cornerRadius];

  shadowAnimation.toValue = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                       cornerRadius:targetCornerRadius];

  [CATransaction begin];
  [CATransaction setAnimationDuration:duration];
  [CATransaction setAnimationTimingFunction:timingFunction];

  /// delay must be 0 for this CATransaction implementation to work.
  [UIView animateWithDuration:duration
                        delay:0.0
                      options:options
                   animations:^{
                     if (cornerRadiusNumber) {
                       self.layer.cornerRadius = targetCornerRadius;
                     }

                     if (rectValue) {
                       self.bounds = targetRect;
                     }

                     /// self.center cannot be used to check against whether or not the center
                     /// should change. Optional center parameter must be passed in, as self.center
                     /// could potentially change while animating.
                     if (centerValue) {
                       self.center = targetCenter;
                     }

                     /// If no rect value is passed, manually call setNeedsLayout.
                     /// This is needed for a corner radius change when size is not changed.
                     /// setNeedsLayout is otherwise called in MDCShadowLayer's setBounds.
                     if (!rectValue) {
                       [self setNeedsLayout];
                       [self layoutIfNeeded];
                     }
                   }
                   completion:completion];

  /// Update the animation associated with the layer.
  /// Since there is only one animation per key, this does not result in multiple shadow animations.
  [self.layer addAnimation:shadowAnimation forKey:animationKey];

  [CATransaction commit];
}

@end
