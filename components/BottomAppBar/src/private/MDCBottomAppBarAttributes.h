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

#import <UIKit/UIKit.h>

// The height of the bottom app bar navigation area in collapsed state.
static const CGFloat kMDCBottomAppBarHeight = 96.f;

// The offset of the top of the containing view of the bottom app bar and the visible layer of the
// bottom app bar.
static const CGFloat kMDCBottomAppBarYOffset = 38.f;

// The horizontal position of the center of the floating button when in leading or trailing state.
static const CGFloat kMDCBottomAppBarFloatingButtonPositionX = 64.f;

// The vertical position of the center of the floating button.
static const CGFloat kMDCBottomAppBarFloatingButtonPositionY = 10.f;

// The starting angle of the path cut for the floating button.
static const CGFloat kMDCBottomAppBarFloatingButtonStartAngle = 161.f;

// Then ending angle of the path cut for the floating button.
static const CGFloat kMDCBottomAppBarFloatingButtonEndAngle = 19.f;

// The radius of the path cut for the floating button.
static const CGFloat kMDCBottomAppBarFloatingButtonRadius = 32.f;

// The duration of the enter animation of the path cut, same as floating button enter animation.
static const NSTimeInterval kMDCFloatingButtonEnterDuration = 0.270f;

// The duration of the exit animation of the path cut, same as floating button exit animation.
static const NSTimeInterval kMDCFloatingButtonExitDuration = 0.180f;
