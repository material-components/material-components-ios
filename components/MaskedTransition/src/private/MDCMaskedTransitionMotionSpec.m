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

#define EaseInEaseOut _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f)
#define EaseIn _MDMBezier(0.4f, 0.0f, 1.0f, 1.0f)
#define EaseOut _MDMBezier(0.0f, 0.0f, 0.2f, 1.0f)

struct MDCMaskedTransitionMotionSpec fullscreen = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.075, .curve = EaseInEaseOut,
    },
    .contentFade = {
      .delay = 0.150, .duration = 0.225, .curve = EaseInEaseOut,
    },
    .floodBackgroundColor = {
      .delay = 0.000, .duration = 0.075, .curve = EaseInEaseOut,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.105, .curve = EaseIn,
    },
    .horizontalMovement = {.curve = { .type = MDMMotionCurveTypeInstant }},
    .verticalMovement = {
      .delay = 0.045, .duration = 0.330, .curve = EaseInEaseOut,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = EaseInEaseOut,
    }
  },
  .shouldSlideWhenCollapsed = true,
  .isCentered = false
};

struct MDCMaskedTransitionMotionSpec bottomSheet = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.075, .curve = EaseInEaseOut, // No spec
    },
    .contentFade = { // No spec for this
      .delay = 0.100, .duration = 0.200, .curve = EaseInEaseOut,
    },
    .floodBackgroundColor = {
      .delay = 0.000, .duration = 0.075, .curve = EaseInEaseOut,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.105, .curve = EaseIn,
    },
    .horizontalMovement = {.curve = { .type = MDMMotionCurveTypeInstant }},
    .verticalMovement = {
      .delay = 0.045, .duration = 0.330, .curve = EaseInEaseOut,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = EaseInEaseOut,
    }
  },
  .shouldSlideWhenCollapsed = true,
  .isCentered = false
};

struct MDCMaskedTransitionMotionSpec bottomCard = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.120, .curve = EaseInEaseOut,
    },
    .contentFade = {
      .delay = 0.150, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .floodBackgroundColor = {
      .delay = 0.075, .duration = 0.075, .curve = EaseInEaseOut,
    },
    .maskTransformation = {
      .delay = 0.045, .duration = 0.225, .curve = EaseIn,
    },
    .horizontalMovement = {
      .delay = 0.000, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.345, .curve = EaseInEaseOut,
    },
    .scrimFade = {
      .delay = 0.075, .duration = 0.150, .curve = EaseInEaseOut,
    }
  },
  .collapse = {
    .iconFade = {
      .delay = 0.150, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .contentFade = {
      .delay = 0.000, .duration = 0.075, .curve = EaseIn,
    },
    .floodBackgroundColor = {
      .delay = 0.060, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.180, .curve = EaseOut,
    },
    .horizontalMovement = {
      .delay = 0.045, .duration = 0.255, .curve = EaseInEaseOut,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.255, .curve = EaseInEaseOut,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = EaseInEaseOut,
    }
  },
  .shouldSlideWhenCollapsed = false,
  .isCentered = true
};

struct MDCMaskedTransitionMotionSpec toolbar = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.120, .curve = EaseInEaseOut,
    },
    .contentFade = {
      .delay = 0.150, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .floodBackgroundColor = {
      .delay = 0.075, .duration = 0.075, .curve = EaseInEaseOut,
    },
    .maskTransformation = {
      .delay = 0.045, .duration = 0.225, .curve = EaseIn,
    },
    .horizontalMovement = {
      .delay = 0.000, .duration = 0.300, .curve = EaseInEaseOut,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.120, .curve = EaseInEaseOut,
    },
    .scrimFade = {
      .delay = 0.075, .duration = 0.150, .curve = EaseInEaseOut,
    }
  },
  .collapse = {
    .iconFade = {
      .delay = 0.150, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .contentFade = {
      .delay = 0.000, .duration = 0.075, .curve = EaseIn,
    },
    .floodBackgroundColor = {
      .delay = 0.060, .duration = 0.150, .curve = EaseInEaseOut,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.180, .curve = EaseOut,
    },
    .horizontalMovement = {
      .delay = 0.105, .duration = 0.195, .curve = EaseInEaseOut,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.255, .curve = EaseInEaseOut,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = EaseInEaseOut,
    }
  },
  .shouldSlideWhenCollapsed = false,
  .isCentered = true
};
