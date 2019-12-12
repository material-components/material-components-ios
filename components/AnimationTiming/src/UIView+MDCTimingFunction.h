// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (MDCTimingFunction)

/**
 A convienence method for applying a timing function to animations.

 @param timingFunction A timing function for the easing curve animation.
 @param duration The time the animation takes.
 @param delay The time to wait before the animation begins.
 @param options Configuration options for the timing function.
 @param animations Animations to which the timing function will apply.
 @param completion A completion block fired after the animations complete.
 */
+ (void)mdc_animateWithTimingFunction:(nullable CAMediaTimingFunction *)timingFunction
                             duration:(NSTimeInterval)duration
                                delay:(NSTimeInterval)delay
                              options:(UIViewAnimationOptions)options
                           animations:(void (^__nonnull)(void))animations
                           completion:(void (^__nullable)(BOOL finished))completion;

@end
