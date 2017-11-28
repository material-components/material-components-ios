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

#import "MDCDialogTransitionMotionSpec.h"

@implementation MDCDialogTransitionMotionSpec

+ (MDMMotionCurve)linear {
  return MDMLinearMotionCurve;
}

+ (MDMMotionCurve)deceleration {
  return MDMMotionCurveMakeBezier(0.00f, 0.00f, 0.20f, 1.00f);
}

+ (MDCDialogTransitionAppearanceTimings)appearance {
  return (MDCDialogTransitionAppearanceTimings){
    .contentOpacity = {
      .duration = 0.150, .delay = 0.000, .curve = [self linear]
    },
    .scrimOpacity = {
      .duration = 0.150, .delay = 0.000, .curve = [self linear]
    },
    .contentScale = {
      .duration = 0.150, .delay = 0.000, .curve = [self deceleration]
    },
    .contentScaleFromValue = (CGFloat)0.8,
    .transitionDuration = 0.150,
  };
}

+ (MDCDialogTransitionDisappearanceTimings)disappearance {
  return (MDCDialogTransitionDisappearanceTimings){
    .contentOpacity = {
      .duration = 0.150, .delay = 0.000, .curve = [self linear]
    },
    .scrimOpacity = {
      .duration = 0.150, .delay = 0.000, .curve = [self linear]
    },
    .transitionDuration = 0.150,
  };
}

@end
