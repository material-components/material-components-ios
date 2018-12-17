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

/**
 Material Design easing curve animation values.

 Use these easing curves to create smooth and consistent motion that conforms to Material Design.
 */
typedef NS_ENUM(NSUInteger, MDCAnimationTimingFunction) {
  /**
   This is the most frequently used interpolation curve for Material Design animations. This curve
   is slow both at the beginning and end. It has similar characteristics to the system's EaseInOut.
   This is known as Standard in the Material Design spec.
   */
  MDCAnimationTimingFunctionStandard,

  /**
   This curve should be used for motion when entering frame or when fading in from 0% opacity. This
   curve is slow at the end. It has similar characteristics to the system's EaseOut. This is known
   as Deceleration in the Material Design spec.
   */
  MDCAnimationTimingFunctionDeceleration,

  /**
   This curve should be used for motion when exiting frame or when fading out to 0% opacity. This
   curve is slow at the beginning. It has similar characteristics to the system's EaseIn. This
   is known as Acceleration in the Material Design spec.
   */
  MDCAnimationTimingFunctionAcceleration,

  /**
   This curve should be used for motion when elements quickly accelerate and decelerate. It is
   used by exiting elements that may return to the screen at any time. The deceleration is
   faster than the standard curve since it doesn't follow an exact path to the off-screen point.
   */
  MDCAnimationTimingFunctionSharp,
  
  /**
   Aliases for depreciated names
   */
  MDCAnimationTimingFunctionEaseInOut = MDCAnimationTimingFunctionStandard,
  MDCAnimationTimingFunctionEaseOut = MDCAnimationTimingFunctionDeceleration,
  MDCAnimationTimingFunctionEaseIn = MDCAnimationTimingFunctionAcceleration,

  /**
   Aliases for various specific timing curve recommendations.
   */
  MDCAnimationTimingFunctionTranslate = MDCAnimationTimingFunctionStandard,
  MDCAnimationTimingFunctionTranslateOnScreen = MDCAnimationTimingFunctionDeceleration,
  MDCAnimationTimingFunctionTranslateOffScreen = MDCAnimationTimingFunctionAcceleration,
  MDCAnimationTimingFunctionFadeIn = MDCAnimationTimingFunctionDeceleration,
  MDCAnimationTimingFunctionFadeOut = MDCAnimationTimingFunctionAcceleration,
};

/**
 Material Design animation curves.
 */
@interface CAMediaTimingFunction (MDCAnimationTiming)

/**
 Returns the corresponding CAMediaTimingFunction for the given curve specified by an enum. The most
 common curve is MDCAnimationTimingFunctionEaseInOut.

 @param type A Material Design media timing function.
 */
+ (nullable CAMediaTimingFunction *)mdc_functionWithType:(MDCAnimationTimingFunction)type;

@end
