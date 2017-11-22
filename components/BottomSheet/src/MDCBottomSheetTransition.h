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

#import <Foundation/Foundation.h>
#import <MotionTransitioning/MotionTransitioning.h>

/**
 Presents the associated view controller as a draggable bottom view.

 The associated view controller can configure the behavior of the transition by setting a
 preferredContentSize and providing a tracking scroll view.

 The associated view controller will initially be presented anchored to the bottom middle of the
 device, with its size matching the view controller's preferredContentSize.

 If the trackingScrollView is set, or one was inferred, then the scroll view's content size will
 determine the maximum height of the sheet.

 If the tracked scroll view's content size is bigger than the transition's container area, then the
 content will be scrollable once the view controller's view has been fully expanded. The user can
 dismiss the sheet by scrolling to the top of the tracked scroll view's contents and then dragging
 the sheet down.

 It is recommended that the associated view controller implements accessibilityPerformEscape in
 order to dismiss itself when the user performs an accessibility escape gesture (two finger z
 gesture).
 */
@interface MDCBottomSheetTransition : NSObject <MDMTransition>

/**
 Interactions with the tracking scroll view will affect the bottom sheet's drag behavior.

 If no trackingScrollView is provided, then one will be inferred from the associated view
 controller.

 Changes to this value will be ignored after the bottom sheet controller has been presented.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

@end
