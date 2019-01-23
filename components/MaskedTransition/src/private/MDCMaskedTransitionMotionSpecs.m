// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCMaskedTransitionMotionSpecs.h"

@implementation MDCMaskedTransitionMotionSpecs

+ (MDMMotionCurve)easeInEaseOut {
  return MDMMotionCurveMakeBezier((CGFloat)0.4, 0, (CGFloat)0.2, 1);
}

+ (MDMMotionCurve)easeIn {
  return MDMMotionCurveMakeBezier((CGFloat)0.4, 0, 1, 1);
}

+ (MDMMotionCurve)easeOut {
  return MDMMotionCurveMakeBezier(0, 0, (CGFloat)0.2, 1);
}

+ (MDCMaskedTransitionMotionSpec)fullscreen {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  return (MDCMaskedTransitionMotionSpec){
      .expansion = {.iconFade =
                        {
                            .delay = 0.000,
                            .duration = 0.075,
                            .curve = easeInEaseOut,
                        },
                    .contentFade =
                        {
                            .delay = 0.150,
                            .duration = 0.225,
                            .curve = easeInEaseOut,
                        },
                    .floodBackgroundColor =
                        {
                            .delay = 0.000,
                            .duration = 0.075,
                            .curve = easeInEaseOut,
                        },
                    .maskTransformation =
                        {
                            .delay = 0.000,
                            .duration = 0.105,
                            .curve = easeIn,
                        },
                    .horizontalMovement = {.curve = {.type = MDMMotionCurveTypeInstant}},
                    .verticalMovement =
                        {
                            .delay = 0.045,
                            .duration = 0.330,
                            .curve = easeInEaseOut,
                        },
                    .scrimFade =
                        {
                            .delay = 0.000,
                            .duration = 0.150,
                            .curve = easeInEaseOut,
                        },
                    .overallDuration = 0.375},
      .shouldSlideWhenCollapsed = true,
      .isCentered = false};
}

+ (MDCMaskedTransitionMotionSpec)bottomSheet {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  return (MDCMaskedTransitionMotionSpec){
      .expansion = {.iconFade =
                        {
                            .delay = 0.000, .duration = 0.075, .curve = easeInEaseOut,  // No spec
                        },
                    .contentFade =
                        {
                            // No spec for this
                            .delay = 0.100,
                            .duration = 0.200,
                            .curve = easeInEaseOut,
                        },
                    .floodBackgroundColor =
                        {
                            .delay = 0.000,
                            .duration = 0.075,
                            .curve = easeInEaseOut,
                        },
                    .maskTransformation =
                        {
                            .delay = 0.000,
                            .duration = 0.105,
                            .curve = easeIn,
                        },
                    .horizontalMovement = {.curve = {.type = MDMMotionCurveTypeInstant}},
                    .verticalMovement =
                        {
                            .delay = 0.045,
                            .duration = 0.330,
                            .curve = easeInEaseOut,
                        },
                    .scrimFade =
                        {
                            .delay = 0.000,
                            .duration = 0.150,
                            .curve = easeInEaseOut,
                        },
                    .overallDuration = 0.375},
      .shouldSlideWhenCollapsed = true,
      .isCentered = false};
}

+ (MDCMaskedTransitionMotionSpec)bottomCard {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  MDMMotionCurve easeOut = [self easeOut];
  return (MDCMaskedTransitionMotionSpec){.expansion = {.iconFade =
                                                           {
                                                               .delay = 0.000,
                                                               .duration = 0.120,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .contentFade =
                                                           {
                                                               .delay = 0.150,
                                                               .duration = 0.150,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .floodBackgroundColor =
                                                           {
                                                               .delay = 0.075,
                                                               .duration = 0.075,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .maskTransformation =
                                                           {
                                                               .delay = 0.045,
                                                               .duration = 0.225,
                                                               .curve = easeIn,
                                                           },
                                                       .horizontalMovement =
                                                           {
                                                               .delay = 0.000,
                                                               .duration = 0.150,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .verticalMovement =
                                                           {
                                                               .delay = 0.000,
                                                               .duration = 0.345,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .scrimFade =
                                                           {
                                                               .delay = 0.075,
                                                               .duration = 0.150,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .overallDuration = 0.345},
                                         .collapse = {.iconFade =
                                                          {
                                                              .delay = 0.150,
                                                              .duration = 0.150,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .contentFade =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.075,
                                                              .curve = easeIn,
                                                          },
                                                      .floodBackgroundColor =
                                                          {
                                                              .delay = 0.060,
                                                              .duration = 0.150,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .maskTransformation =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.180,
                                                              .curve = easeOut,
                                                          },
                                                      .horizontalMovement =
                                                          {
                                                              .delay = 0.045,
                                                              .duration = 0.255,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .verticalMovement =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.255,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .scrimFade =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.150,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .overallDuration = 0.300},
                                         .shouldSlideWhenCollapsed = false,
                                         .isCentered = true};
}

+ (MDCMaskedTransitionMotionSpec)toolbar {
  MDMMotionCurve easeInEaseOut = [self easeInEaseOut];
  MDMMotionCurve easeIn = [self easeIn];
  MDMMotionCurve easeOut = [self easeOut];
  return (MDCMaskedTransitionMotionSpec){.expansion = {.iconFade =
                                                           {
                                                               .delay = 0.000,
                                                               .duration = 0.120,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .contentFade =
                                                           {
                                                               .delay = 0.150,
                                                               .duration = 0.150,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .floodBackgroundColor =
                                                           {
                                                               .delay = 0.075,
                                                               .duration = 0.075,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .maskTransformation =
                                                           {
                                                               .delay = 0.045,
                                                               .duration = 0.225,
                                                               .curve = easeIn,
                                                           },
                                                       .horizontalMovement =
                                                           {
                                                               .delay = 0.000,
                                                               .duration = 0.300,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .verticalMovement =
                                                           {
                                                               .delay = 0.000,
                                                               .duration = 0.120,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .scrimFade =
                                                           {
                                                               .delay = 0.075,
                                                               .duration = 0.150,
                                                               .curve = easeInEaseOut,
                                                           },
                                                       .overallDuration = 0.300},
                                         .collapse = {.iconFade =
                                                          {
                                                              .delay = 0.150,
                                                              .duration = 0.150,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .contentFade =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.075,
                                                              .curve = easeIn,
                                                          },
                                                      .floodBackgroundColor =
                                                          {
                                                              .delay = 0.060,
                                                              .duration = 0.150,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .maskTransformation =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.180,
                                                              .curve = easeOut,
                                                          },
                                                      .horizontalMovement =
                                                          {
                                                              .delay = 0.105,
                                                              .duration = 0.195,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .verticalMovement =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.255,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .scrimFade =
                                                          {
                                                              .delay = 0.000,
                                                              .duration = 0.150,
                                                              .curve = easeInEaseOut,
                                                          },
                                                      .overallDuration = 0.300},
                                         .shouldSlideWhenCollapsed = false,
                                         .isCentered = true};
}

@end
