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

#define MDMEightyForty _MDMBezier(0.4f, 0.0f, 0.2f, 1.0f)
#define MDMFortyOut _MDMBezier(0.4f, 0.0f, 1.0f, 1.0f)
#define MDMEightyIn _MDMBezier(0.0f, 0.0f, 0.2f, 1.0f)

struct MDCMaskedTransitionMotionSpec fullscreen = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.075, .curve = MDMEightyForty,
    },
    .contentFade = {
      .delay = 0.150, .duration = 0.225, .curve = MDMEightyForty,
    },
    .floodBackgroundColor = {
      .delay = 0.000, .duration = 0.075, .curve = MDMEightyForty,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.105, .curve = MDMFortyOut,
    },
    .horizontalMovement = {.curve = { .type = MDMMotionCurveTypeInstant }},
    .verticalMovement = {
      .delay = 0.045, .duration = 0.330, .curve = MDMEightyForty,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = MDMEightyForty,
    }
  },
  .shouldSlideWhenCollapsed = true,
  .isCentered = false
};

struct MDCMaskedTransitionMotionSpec bottomSheet = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.075, .curve = MDMEightyForty, // No spec
    },
    .contentFade = { // No spec for this
      .delay = 0.100, .duration = 0.200, .curve = MDMEightyForty,
    },
    .floodBackgroundColor = {
      .delay = 0.000, .duration = 0.075, .curve = MDMEightyForty,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.105, .curve = MDMFortyOut,
    },
    .horizontalMovement = {.curve = { .type = MDMMotionCurveTypeInstant }},
    .verticalMovement = {
      .delay = 0.045, .duration = 0.330, .curve = MDMEightyForty,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = MDMEightyForty,
    }
  },
  .shouldSlideWhenCollapsed = true,
  .isCentered = false
};

struct MDCMaskedTransitionMotionSpec bottomCard = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.120, .curve = MDMEightyForty,
    },
    .contentFade = {
      .delay = 0.150, .duration = 0.150, .curve = MDMEightyForty,
    },
    .floodBackgroundColor = {
      .delay = 0.075, .duration = 0.075, .curve = MDMEightyForty,
    },
    .maskTransformation = {
      .delay = 0.045, .duration = 0.225, .curve = MDMFortyOut,
    },
    .horizontalMovement = {
      .delay = 0.000, .duration = 0.150, .curve = MDMEightyForty,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.345, .curve = MDMEightyForty,
    },
    .scrimFade = {
      .delay = 0.075, .duration = 0.150, .curve = MDMEightyForty,
    }
  },
  .collapse = {
    .iconFade = {
      .delay = 0.150, .duration = 0.150, .curve = MDMEightyForty,
    },
    .contentFade = {
      .delay = 0.000, .duration = 0.075, .curve = MDMFortyOut,
    },
    .floodBackgroundColor = {
      .delay = 0.060, .duration = 0.150, .curve = MDMEightyForty,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.180, .curve = MDMEightyIn,
    },
    .horizontalMovement = {
      .delay = 0.045, .duration = 0.255, .curve = MDMEightyForty,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.255, .curve = MDMEightyForty,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = MDMEightyForty,
    }
  },
  .shouldSlideWhenCollapsed = false,
  .isCentered = true
};

struct MDCMaskedTransitionMotionSpec toolbar = {
  .expansion = {
    .iconFade = {
      .delay = 0.000, .duration = 0.120, .curve = MDMEightyForty,
    },
    .contentFade = {
      .delay = 0.150, .duration = 0.150, .curve = MDMEightyForty,
    },
    .floodBackgroundColor = {
      .delay = 0.075, .duration = 0.075, .curve = MDMEightyForty,
    },
    .maskTransformation = {
      .delay = 0.045, .duration = 0.225, .curve = MDMFortyOut,
    },
    .horizontalMovement = {
      .delay = 0.000, .duration = 0.300, .curve = MDMEightyForty,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.120, .curve = MDMEightyForty,
    },
    .scrimFade = {
      .delay = 0.075, .duration = 0.150, .curve = MDMEightyForty,
    }
  },
  .collapse = {
    .iconFade = {
      .delay = 0.150, .duration = 0.150, .curve = MDMEightyForty,
    },
    .contentFade = {
      .delay = 0.000, .duration = 0.075, .curve = MDMFortyOut,
    },
    .floodBackgroundColor = {
      .delay = 0.060, .duration = 0.150, .curve = MDMEightyForty,
    },
    .maskTransformation = {
      .delay = 0.000, .duration = 0.180, .curve = MDMEightyIn,
    },
    .horizontalMovement = {
      .delay = 0.105, .duration = 0.195, .curve = MDMEightyForty,
    },
    .verticalMovement = {
      .delay = 0.000, .duration = 0.255, .curve = MDMEightyForty,
    },
    .scrimFade = {
      .delay = 0.000, .duration = 0.150, .curve = MDMEightyForty,
    }
  },
  .shouldSlideWhenCollapsed = false,
  .isCentered = true
};
