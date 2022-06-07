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

#import <UIKit/UIKit.h>

/**
 Allows animation of shadows for changes applied to a view's bounds and layer.cornerRadius.
 Use these implementations instead of UIView.animate when modifying these properties.
 These implementations do not support the use of a delay parameter.
 */
@interface UIView (MDCShadowAnimations)

/**
 Animates the corner radius of a UIView's layer to a new CGFloat value
 Accounts for shadow animation

 @param value The new corner radius that will be applied to the UIView's layer
 @param duration The duration of the animation
 @param options UIViewAnimatingOptions
 @param timingFunction The CAMediaTimingFunction for the animation
 @param completion Animation completion handler
 */
- (void)mdc_animateCornerRadiusToValue:(CGFloat)value
                              duration:(CGFloat)duration
                               options:(UIViewAnimationOptions)options
                        timingFunction:(CAMediaTimingFunction *)timingFunction
                            completion:(void (^)(BOOL finished))completion;

/**
 Animates the bounds of a UIView to a new CGRect value
 Accounts for shadow animation

 @param rect The new bounds that will be applied to the UIView
 @param duration The duration of the animation
 @param options UIViewAnimatingOptions
 @param timingFunction The CAMediaTimingFunction for the animation
 @param completion Animation completion handler
 */
- (void)mdc_animateBoundsToRect:(CGRect)rect
                       duration:(CGFloat)duration
                        options:(UIViewAnimationOptions)options
                 timingFunction:(CAMediaTimingFunction *)timingFunction
                     completion:(void (^)(BOOL finished))completion;

/**
 Animates the bounds of a UIView to a new CGRect value
 Animates the center of a UIView to a new CGPoint value
 Accounts for shadow animation

 @param rect The new bounds that will be applied to the UIView
 @param center The new center that will be applied to the UIView
 @param duration The duration of the animation
 @param options UIViewAnimatingOptions
 @param timingFunction The CAMediaTimingFunction for the animation
 @param completion Animation completion handler
 */
- (void)mdc_animateBoundsWithCenterToRect:(CGRect)rect
                                   center:(CGPoint)center
                                 duration:(CGFloat)duration
                                  options:(UIViewAnimationOptions)options
                           timingFunction:(CAMediaTimingFunction *)timingFunction
                               completion:(void (^)(BOOL finished))completion;

/**
 Animates the bounds of a UIView to a new CGRect value
 Animates the corner radius of a UIView's layer to a new CGFloat value
 Accounts for shadow animation

 @param rect The new bounds that will be applied to the UIView
 @param cornerRadius The new corner radius that will be applied to the UIView's layer
 @param duration The duration of the animation
 @param options UIViewAnimatingOptions
 @param timingFunction The CAMediaTimingFunction for the animation
 @param completion Animation completion handler
 */
- (void)mdc_animateBoundsWithCornerRadiusToRect:(CGRect)rect
                                   cornerRadius:(CGFloat)cornerRadius
                                       duration:(CGFloat)duration
                                        options:(UIViewAnimationOptions)options
                                 timingFunction:(CAMediaTimingFunction *)timingFunction
                                     completion:(void (^)(BOOL finished))completion;

/**
 Animates the bounds of a UIView to a new CGRect value
 Animates the center of a UIView to a new CGPoint value
 Animates the corner radius of a UIView's layer to a new CGFloat value
 Accounts for shadow animation

 @param rect The new bounds that will be applied to the UIView
 @param center The new center that will be applied to the UIView
 @param cornerRadius The new corner radius that will be applied to the UIView's layer
 @param duration The duration of the animation
 @param options UIViewAnimatingOptions
 @param timingFunction The CAMediaTimingFunction for the animation
 @param completion Animation completion handler
 */
- (void)mdc_animateBoundsWithCenterAndCornerRadiusToRect:(CGRect)rect
                                                  center:(CGPoint)center
                                            cornerRadius:(CGFloat)cornerRadius
                                                duration:(CGFloat)duration
                                                 options:(UIViewAnimationOptions)options
                                          timingFunction:(CAMediaTimingFunction *)timingFunction
                                              completion:(void (^)(BOOL finished))completion;
@end
