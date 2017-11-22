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

#import "MDCMaskedTransitionMotionSpec.h"

@implementation MDCMaskedTransitionMotionSpec

+ (MDMMotionCurve)easeInEaseOut {
  return MDMMotionCurveMakeBezier(0.4f, 0.0f, 0.2f, 1.0f);
}

+ (MDMMotionCurve)easeIn {
  return MDMMotionCurveMakeBezier(0.4f, 0.0f, 1.0f, 1.0f);
}

+ (MDMMotionCurve)easeOut {
  return MDMMotionCurveMakeBezier(0.0f, 0.0f, 0.2f, 1.0f);
}

+ (MDCMaskedTransitionMotionSpecContext)fullscreen {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  return (MDCMaskedTransitionMotionSpecContext){
    .expansion = {
      .iconFade = {
        .delay = 0.000, .duration = 0.075, .curve = easeInEaseOut,
      },
      .contentFade = {
        .delay = 0.150, .duration = 0.225, .curve = easeInEaseOut,
      },
      .floodBackgroundColor = {
        .delay = 0.000, .duration = 0.075, .curve = easeInEaseOut,
      },
      .maskTransformation = {
        .delay = 0.000, .duration = 0.105, .curve = easeIn,
      },
      .horizontalMovement = {.curve = { .type = MDMMotionCurveTypeInstant }},
      .verticalMovement = {
        .delay = 0.045, .duration = 0.330, .curve = easeInEaseOut,
      },
      .scrimFade = {
        .delay = 0.000, .duration = 0.150, .curve = easeInEaseOut,
      }
    },
    .shouldSlideWhenCollapsed = true,
    .isCentered = false
  };
}

+ (MDCMaskedTransitionMotionSpecContext)bottomSheet {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  return (MDCMaskedTransitionMotionSpecContext){
    .expansion = {
      .iconFade = {
        .delay = 0.000, .duration = 0.075, .curve = easeInEaseOut, // No spec
      },
      .contentFade = { // No spec for this
        .delay = 0.100, .duration = 0.200, .curve = easeInEaseOut,
      },
      .floodBackgroundColor = {
        .delay = 0.000, .duration = 0.075, .curve = easeInEaseOut,
      },
      .maskTransformation = {
        .delay = 0.000, .duration = 0.105, .curve = easeIn,
      },
      .horizontalMovement = {.curve = { .type = MDMMotionCurveTypeInstant }},
      .verticalMovement = {
        .delay = 0.045, .duration = 0.330, .curve = easeInEaseOut,
      },
      .scrimFade = {
        .delay = 0.000, .duration = 0.150, .curve = easeInEaseOut,
      }
    },
    .shouldSlideWhenCollapsed = true,
    .isCentered = false
  };
}

+ (MDCMaskedTransitionMotionSpecContext)bottomCard {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  MDMMotionCurve easeOut = [self easeOut];
  return (MDCMaskedTransitionMotionSpecContext){
    .expansion = {
      .iconFade = {
        .delay = 0.000, .duration = 0.120, .curve = easeInEaseOut,
      },
      .contentFade = {
        .delay = 0.150, .duration = 0.150, .curve = easeInEaseOut,
      },
      .floodBackgroundColor = {
        .delay = 0.075, .duration = 0.075, .curve = easeInEaseOut,
      },
      .maskTransformation = {
        .delay = 0.045, .duration = 0.225, .curve = easeIn,
      },
      .horizontalMovement = {
        .delay = 0.000, .duration = 0.150, .curve = easeInEaseOut,
      },
      .verticalMovement = {
        .delay = 0.000, .duration = 0.345, .curve = easeInEaseOut,
      },
      .scrimFade = {
        .delay = 0.075, .duration = 0.150, .curve = easeInEaseOut,
      }
    },
    .collapse = {
      .iconFade = {
        .delay = 0.150, .duration = 0.150, .curve = easeInEaseOut,
      },
      .contentFade = {
        .delay = 0.000, .duration = 0.075, .curve = easeIn,
      },
      .floodBackgroundColor = {
        .delay = 0.060, .duration = 0.150, .curve = easeInEaseOut,
      },
      .maskTransformation = {
        .delay = 0.000, .duration = 0.180, .curve = easeOut,
      },
      .horizontalMovement = {
        .delay = 0.045, .duration = 0.255, .curve = easeInEaseOut,
      },
      .verticalMovement = {
        .delay = 0.000, .duration = 0.255, .curve = easeInEaseOut,
      },
      .scrimFade = {
        .delay = 0.000, .duration = 0.150, .curve = easeInEaseOut,
      }
    },
    .shouldSlideWhenCollapsed = false,
    .isCentered = true
  };
}

+ (MDCMaskedTransitionMotionSpecContext)toolbar {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  MDMMotionCurve easeOut = [self easeOut];
  return (MDCMaskedTransitionMotionSpecContext){
    .expansion = {
      .iconFade = {
        .delay = 0.000, .duration = 0.120, .curve = easeInEaseOut,
      },
      .contentFade = {
        .delay = 0.150, .duration = 0.150, .curve = easeInEaseOut,
      },
      .floodBackgroundColor = {
        .delay = 0.075, .duration = 0.075, .curve = easeInEaseOut,
      },
      .maskTransformation = {
        .delay = 0.045, .duration = 0.225, .curve = easeIn,
      },
      .horizontalMovement = {
        .delay = 0.000, .duration = 0.300, .curve = easeInEaseOut,
      },
      .verticalMovement = {
        .delay = 0.000, .duration = 0.120, .curve = easeInEaseOut,
      },
      .scrimFade = {
        .delay = 0.075, .duration = 0.150, .curve = easeInEaseOut,
      }
    },
    .collapse = {
      .iconFade = {
        .delay = 0.150, .duration = 0.150, .curve = easeInEaseOut,
      },
      .contentFade = {
        .delay = 0.000, .duration = 0.075, .curve = easeIn,
      },
      .floodBackgroundColor = {
        .delay = 0.060, .duration = 0.150, .curve = easeInEaseOut,
      },
      .maskTransformation = {
        .delay = 0.000, .duration = 0.180, .curve = easeOut,
      },
      .horizontalMovement = {
        .delay = 0.105, .duration = 0.195, .curve = easeInEaseOut,
      },
      .verticalMovement = {
        .delay = 0.000, .duration = 0.255, .curve = easeInEaseOut,
      },
      .scrimFade = {
        .delay = 0.000, .duration = 0.150, .curve = easeInEaseOut,
      }
    },
    .shouldSlideWhenCollapsed = false,
    .isCentered = true
  };
}

@end
