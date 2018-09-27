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

#import <UIKit/UIKit.h>

// The height of the bottom app bar navigation area in collapsed state.
static const CGFloat kMDCBottomAppBarHeight = 96.f;

// The offset from the top of the navigation view of the bottom app bar to the
// bottom app bar position
static const CGFloat kMDCBottomAppBarNavigationViewYOffset = 38.f;

// The horizontal position of the center of the floating button when in leading or trailing state.
static const CGFloat kMDCBottomAppBarFloatingButtonPositionX = 64.f;

// The delta radius of the path cut for the floating button to the floating button's radius.
static const CGFloat kMDCBottomAppBarFloatingButtonRadiusOffset = 4.f;

// The duration of the enter animation of the path cut, same as floating button enter animation.
static const NSTimeInterval kMDCFloatingButtonEnterDuration = 0.270f;

// The duration of the exit animation of the path cut, same as floating button exit animation.
static const NSTimeInterval kMDCFloatingButtonExitDuration = 0.180f;
