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

#import <Foundation/Foundation.h>

#import <MotionInterchange/MotionInterchange.h>

struct MDCActivityIndicatorMotionSpec {
  struct MDCActivityIndicatorMotionSpecIndeterminate {
    MDMMotionTiming outerRotation;
    MDMMotionTiming innerRotation;
    MDMMotionTiming strokeStart;
    MDMMotionTiming strokeEnd;
  } indeterminate;

  struct MDCActivityIndicatorMotionSpecTransitionToDeterminate {
    MDMMotionTiming innerRotation;
    MDMMotionTiming strokeEnd;
  } transitionToDeterminate;

  struct MDCActivityIndicatorMotionSpecTransitionToIndeterminate {
    MDMMotionTiming strokeStart;
    MDMMotionTiming strokeEnd;
  } transitionToIndeterminate;

  struct MDCActivityIndicatorMotionSpecProgress {
    MDMMotionTiming strokeEnd;
  } progress;
};
typedef struct MDCActivityIndicatorMotionSpec MDCActivityIndicatorMotionSpec;

FOUNDATION_EXPORT const NSTimeInterval kPointCycleDuration;
FOUNDATION_EXPORT const NSTimeInterval kPointCycleMinimumVariableDuration;

FOUNDATION_EXPORT const struct MDCActivityIndicatorMotionSpec kMDCActivityIndicatorMotionSpec;

