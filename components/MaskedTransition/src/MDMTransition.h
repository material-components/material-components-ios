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

// API REVIEWERS NOTE: This is a header from the MaterialMotionTransitions library. It is a small
// library that standardizes the mechanisms by which transitions can be customized.

/**
 A transition coordinates the animated and possibly interactive presentation or dismissal of a view
 controller.
 */
@protocol MDMTransition <NSObject>
@end

/**
 A presentation info instance contains objects related to a transition.
 */
@protocol MDMPresentationInfo <NSObject>

/**
 The container view of the transition.
 */
@property(nonatomic, strong, nonnull) UIView *containerView;

/**
 The presenting view controller.
 */
@property(nonatomic, strong, nonnull) UIViewController *presentingViewController;

/**
 The presented view controller.
 */
@property(nonatomic, strong, nonnull) UIViewController *presentedViewController;

@end

/**
 A block signature for calculating the frame of the presented view in a view controller transition.

 @param info Objects related to the transition.
 @return The desired frame of the presented view controller's view.
 */
typedef CGRect (^MDMCalculateFrameOfPresentedView)(_Nonnull id<MDMPresentationInfo> info);
