// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 The MDCBottomDrawerState enum provides the different possible states the bottom drawer can be in.
 There are 2 different states for the bottom drawer:

 - MDCBottomDrawerStateCollapsed: This state is reached when the bottom drawer is collapsed
 (can be expanded to present more content), but is not taking up the entire screen.
 - MDCBottomDrawerStateExpanded: This state is reached when the bottom drawer is fully expanded
 (displaying the entire content), but is not taking up the entire screen.
 - MDCBottomDrawerStateFullScreen: This state is reached when the bottom drawer
 is in full screen.
 */
typedef NS_ENUM(NSUInteger, MDCBottomDrawerState) {
  MDCBottomDrawerStateCollapsed = 0,
  MDCBottomDrawerStateExpanded = 1,
  MDCBottomDrawerStateFullScreen = 2,
};
