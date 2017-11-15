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

#import "MDCActivityIndicatorMotionSpec.h"

const NSTimeInterval kPointCycleDuration = 4.0f / 3.0f;
const NSTimeInterval kPointCycleMinimumVariableDuration = kPointCycleDuration / 8;

const struct MDCActivityIndicatorMotionSpec kMDCActivityIndicatorMotionSpec = {
  .indeterminate = {
    .outerRotation = {
      .duration = kPointCycleDuration, .curve = _MDMBezier(0, 0, 1, 1),
    },
    .innerRotation = {
      .duration = kPointCycleDuration, .curve = _MDMBezier(0, 0, 1, 1),
    },
    .strokeStart = {
      .delay = kPointCycleDuration / 2,
      .duration = kPointCycleDuration / 2,
      .curve = _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f),
    },
    .strokeEnd = {
      .duration = kPointCycleDuration,
      .curve = _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f),
    },
  },
  .transitionToDeterminate = {
    // Transition timing is calculated at runtime - any duration/delay values provided here will
    // by scaled by the calculated duration.
    .innerRotation = {
      .duration = 1, .curve = _MDMBezier(0, 0, 1, 1),
    },
    .strokeEnd = {
      .duration = 1, .curve = _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f),
    },
  },
  .transitionToIndeterminate = {
    // Transition timing is calculated at runtime.
    .strokeStart = {
      .curve = _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f),
    },
    .strokeEnd = {
      .curve = _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f),
    },
  },
  .progress = {
    .strokeEnd = {
      .duration = kPointCycleDuration / 2,
      .curve = _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f),
    }
  }
};

