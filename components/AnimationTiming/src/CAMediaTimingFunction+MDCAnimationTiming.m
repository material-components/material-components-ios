/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "CAMediaTimingFunction+MDCAnimationTiming.h"

@implementation CAMediaTimingFunction (MDCAnimationTiming)

+ (CAMediaTimingFunction *)mdc_functionWithType:(MDCAnimationTimingFunction)type {
  switch (type) {
    case MDCAnimationTimingFunctionStandard:
      return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
    case MDCAnimationTimingFunctionDeceleration:
      return [[CAMediaTimingFunction alloc] initWithControlPoints:0.0f:0.0f:0.2f:1.0f];
    case MDCAnimationTimingFunctionAcceleration:
      return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:1.0f:1.0f];
    case MDCAnimationTimingFunctionSharp:
      return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.6f:1.0f];
  }
  NSAssert(NO, @"Invalid MDCAnimationTimingFunction value %i.", (int)type);
  // Reasonable default to use in Release mode for garbage input.
  return nil;
}

@end
