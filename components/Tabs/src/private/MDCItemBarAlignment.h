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

/** Alignment styles for items in a tab bar. */
typedef NS_ENUM(NSInteger, MDCItemBarAlignment) {
  /** Items are aligned on the leading edge and sized to fit their content. */
  MDCItemBarAlignmentLeading,

  /** Items are justified to equal size across the width of the screen. */
  MDCItemBarAlignmentJustified,

  /**
   * If the item bar items can be nicely justified, in an equal size across the width of the screen,
   * then they will layout as if `MDCItemBarAlignmentJustified` were set. However if the tabs are
   * too wide to be nicely justified, then the item bar items fall back to using a
   * `MDCItemBarAlignmentLeading` layout.
   */
  MDCItemBarAlignmentBestEffortJustified,

  /**
   * Items are sized to fit their content and center-aligned as a group. If they do not fit in view,
   * they will be leading-aligned instead.
   */
  MDCItemBarAlignmentCenter,

  /** Items are center-aligned on the selected item. */
  MDCItemBarAlignmentCenterSelected,
};
