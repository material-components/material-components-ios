// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCBottomDrawerViewController;

/**
 Delegate for MDCBottomDrawerViewController.
 */
@protocol MDCBottomDrawerViewControllerDelegate <NSObject>

@optional
/**
 Called when the top inset of the drawer changes due to size changes when moving into full screen
 to cover the status bar and safe area inset. Also if there is a top handle, the top inset will
 take into regards the handle height. The top inset indicates where the content can be safely
 laid out without it being clipped.

 @param controller The MDCBottomDrawerViewController.
 @param topInset The top inset in which the content should take into regards when being laid out.
 */
- (void)bottomDrawerControllerDidChangeTopInset:(nonnull MDCBottomDrawerViewController *)controller
                                       topInset:(CGFloat)topInset;

/**
 Called when the y-offset of the visible contents of the drawer (excluding shadow & scrim) have
 changed. This is triggered when the drawer is presented and dismissed as well as when the content
 is being dragged interactively.

 @param controller The MDCBottomDrawerViewController.
 @param yOffset The y-Offset of the top of the visible contents of the drawer.
 */
- (void)bottomDrawerControllerDidChangeTopYOffset:
            (nonnull MDCBottomDrawerViewController *)controller
                                          yOffset:(CGFloat)yOffset;

/**
 Called when the bottom drawer will begin animating to an open state. This is triggered when the VC
 is being presented. Add animations and/or completion to the transitionCoordinator to cause them to
 animate/complete alongside the drawer animation.

 @param controller The MDCBottomDrawerViewController.
 @param transitionCoordinator The transitionCoordinator handling the presentation transition.
 @param targetYOffset The target yOffset of the content after the animation completes.
 */
- (void)bottomDrawerControllerWillTransitionOpen:(nonnull MDCBottomDrawerViewController *)controller
                                 withCoordinator:
                                     (nullable id<UIViewControllerTransitionCoordinator>)
                                         transitionCoordinator
                                   targetYOffset:(CGFloat)targetYOffset;

/**
 Called when the bottom drawer has completed animating to the open state.

 @param controller The MDCBottomDrawerViewController.
 */
- (void)bottomDrawerControllerDidEndOpenTransition:
    (nonnull MDCBottomDrawerViewController *)controller;

/**
 Called when the bottom drawer will begin animating to a closed state. This is triggered when the VC
 is being dismissed. Add animations and/or completion to the transitionCoordinator to cause them to
 animate/complete alongside the drawer animation.

 @param controller The MDCBottomDrawerViewController.
 @param transitionCoordinator The transitionCoordinator handling the presentation transition.
 @param targetYOffset The target yOffset of the content after the animation completes.
 */
- (void)
    bottomDrawerControllerWillTransitionClosed:(nonnull MDCBottomDrawerViewController *)controller
                               withCoordinator:(nullable id<UIViewControllerTransitionCoordinator>)
                                                   transitionCoordinator
                                 targetYOffset:(CGFloat)targetYOffset;

/**
 Called when the bottom drawer has completed animating to the closed state.

 @param controller The MDCBottomDrawerViewController.
 */
- (void)bottomDrawerControllerDidEndCloseTransition:
    (nonnull MDCBottomDrawerViewController *)controller;

/**
 Called when the bottom drawer's scrim was tapped.

 @param controller The MDCBottomDrawerViewController.
 */
- (void)bottomDrawerControllerDidTapScrim:(nonnull MDCBottomDrawerViewController *)controller;

@end
