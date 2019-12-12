// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTabBarAlignment.h"

/**
 Alignment options that are not fully supported in MDC-iOS. These should map exactly back to
 `MDCTabBarAlignment` for values that semantically match.
 */
typedef NS_ENUM(NSInteger, MDCTabBarExtendedAlignment) {

  MDCTabBarExtendedAlignmentLeading = MDCTabBarAlignmentLeading,

  MDCTabBarExtendedAlignmentJustified = MDCTabBarAlignmentJustified,

  MDCTabBarExtendedAlignmentCenter = MDCTabBarAlignmentCenter,

  MDCTabBarExtendedAlignmentCenterSelected = MDCTabBarAlignmentCenterSelected,

  /**
   * If the tabs can be nicely justified, in an equal size across the width of the screen, then they
   * will layout as if `MDCTabBarAlignmentJustified` were set. However if the tabs are too wide to
   * be nicely justified, then the tabs fall back to using a `MDCTabBarAlignmentLeading` layout.
   */
  MDCTabBarExtendedAlignmentBestEffortJustified,
};
