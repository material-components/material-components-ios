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

/**
 These variables are intentionally static (even though this is a header file). We don't want
 various MDC components to have to link in the overlay manager just to post overlay change
 notifications. Any implementors who import this file will get copies of the constants which can
 be used without linking the overlay component.
 */

/**
 Overlay implementors should post this notification when a change in overlay frame occurs.

 Use the keys below to define the features of the overlay transition.
 */
static NSString *const MDCOverlayDidChangeNotification = @"MDCOverlayDidChangeNotification";

/**
 The user info key indicating the identifier of the overlay.

 Should be an NSString unique to the component in question. Required.
 */
static NSString *const MDCOverlayIdentifierKey = @"identifier";

/**
 The user info key indicating the frame of the overlay.

 Should only be present if the overlay is onscreen, otherwise omit this key. The value of the key is
 an NSValue containing a CGRect, in absolute screen coordinates (that is, in iOS 8's fixed
 coordinate space).
 */
static NSString *const MDCOverlayFrameKey = @"frame";

/**
 The user info key indicating the duration of the overlay transition animation.

 Should be an NSNumber containing a NSTimeInterval.
 */
static NSString *const MDCOverlayTransitionDurationKey = @"duration";

/**
 The user info key indicating the curve of the transition animation.

 Should be an NSNumber containing an NSInteger (UIViewAnimationCurve). If the duration is non-zero,
 either this key or the curve key should be present in the dictionary.
 */
static NSString *const MDCOverlayTransitionCurveKey = @"curve";

/**
 The user info key indicating the timing function of the transition animation.
 Should be a CAMediaTimingFunction. If the duration is non-zero, either this key or the curve key
 should be present in the dictionary.
 */
static NSString *const MDCOverlayTransitionTimingFunctionKey = @"timingFunction";

/**
 This key indicates that the given overlay change needs to animate immediately.

 Some animations, such as the iOS keyboard animation, need to run immediately (and cannot be
 coalesced). Should be an NSNumber containing a BOOL.
 */
static NSString *const MDCOverlayTransitionImmediacyKey = @"runImmediately";
