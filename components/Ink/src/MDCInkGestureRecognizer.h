// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

API_DEPRECATED_BEGIN(
    "🕘 Schedule time to migrate. "
    "Use default system highlight behavior instead: go/material-ios-touch-response. "
    "This is go/material-ios-migrations#not-scriptable 🕘",
    ios(12, 12))

/**
 Custom gesture recognizer to observe the various ink response states.

 MDCInkGestureRecognizer is a continuous recognizer that tracks single touches and optionally
 fails if the touch moves outside the recongizer's view. Multiple touches will cause the
 recognizer to transition to the UIGestureRecognizerStateCancelled state.
 */
__deprecated_msg("Please use MDCRippleTouchController instead.") @interface MDCInkGestureRecognizer
    : UIGestureRecognizer

/**
 Set the distance that causes the recognizer to cancel.
 */
@property(nonatomic, assign) CGFloat dragCancelDistance;

/**
 Set when dragging outside of the view causes the gesture recognizer to cancel.

 Defaults to YES.
 */
@property(nonatomic, assign) BOOL cancelOnDragOut;

/**
 Bounds inside of which the recognizer will recognize ink gestures, relative to self.view.frame.

 If set to CGRectNull (the default), then the recognizer will use self.view.bounds as the target
 bounds.

 If cancelOnDragOut is YES and the user's touch moves beyond the target bounds inflated by
 dragCancelDistance then the gesture is cancelled.
 */
@property(nonatomic) CGRect targetBounds;

/**
 Returns the point where the ink starts spreading from.

 @param view View which the point is relative to.
 */
- (CGPoint)touchStartLocationInView:(UIView *)view;

/** Returns YES if the touch's current location is still within the target bounds. */
- (BOOL)isTouchWithinTargetBounds;

@end

API_DEPRECATED_END
