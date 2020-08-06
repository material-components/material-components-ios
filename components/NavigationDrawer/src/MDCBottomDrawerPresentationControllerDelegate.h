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

#import "MDCBottomDrawerState.h"

@class MDCBottomDrawerPresentationController;

/**
 Delegate for MDCBottomSheetPresentationController.
 */
@protocol MDCBottomDrawerPresentationControllerDelegate <UIAdaptivePresentationControllerDelegate>
/**
 This method is called when the bottom drawer will change its presented state to one of the
 MDCBottomDrawerState states.

 @param presentationController presentation controller of the bottom drawer
 @param drawerState the drawer's state
 */
- (void)bottomDrawerWillChangeState:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                        drawerState:(MDCBottomDrawerState)drawerState;

/**
 This method is called when the drawer is scrolled/dragged and provides a transition ratio value
 between 0-100% (0-1) that indicates the percentage in which the drawer is close to reaching the end
 of its scrolling. If the drawer is about to reach fullscreen, its percentage moves between 0-100%
 as it starts covering the safe area and status bar. If the drawer doesn't reach full screen, it
 moves between 0-100% as it reaches 20 points away from being fully expanded.
 - 1 or 100% indicates the drawer has reached the end of its scrolling upwards to reveal content.
 - 0 or 0% indicates that there is more scrolling to be done for the drawer to either present
 more content or to transition to full screen.

 @param presentationController the bottom drawer presentation controller.
 @param transitionRatio The transition ratio betwen 0-100% (0-1).
 */
- (void)bottomDrawerTopTransitionRatio:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                       transitionRatio:(CGFloat)transitionRatio;

/**
 This method is called when the y-offset of the visible contents of the drawer have changed. This
 is triggered when the drawer is presented and dismissed as well as when the content is being
 dragged interactively.

 @param presentationController presentation controller of the bottom drawer
 @param yOffset yOffset of the top of the drawer
 */
- (void)bottomDrawerTopDidChangeYOffset:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                                yOffset:(CGFloat)yOffset;

/**
 This method is called when the bottom drawer will begin animating to an open state. This is
 triggered when the VC is being presented.

 @param presentationController presentation controller of the bottom drawer
 @param transitionCoordinator coordinator being used to animate the transition
 @param targetYOffset y-Offset that the drawer will animate to

 @discussion The target y-offset is calculated based upon the @c maximumInitialDrawerHeight and
 @c preferredContentSize of the @c contentViewController. This value may not be the final offset
 since that may change once the initial layout pass has completed. If the offset changes again then
 @c bottomDrawerTopDidChangeYOffset:yOffset will be called with the updated value.
 */
- (void)bottomDrawerPresentTransitionWillBegin:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                               withCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)
                                                   transitionCoordinator
                                 targetYOffset:(CGFloat)targetYOffset;

/**
 This method is called when the bottom drawer has completed animating to an open state. This is
 triggered when the VC is being presented.

 @param presentationController presentation controller of the bottom drawer
 */
- (void)bottomDrawerPresentTransitionDidEnd:
    (nonnull MDCBottomDrawerPresentationController *)presentationController;

/**
 This method is called when the bottom drawer will begin animating to a closed state. This is
 triggered when the VC is being dismissed.

 @param presentationController presentation controller of the bottom drawer
 @param transitionCoordinator coordinator being used to animate the transition
 @param targetYOffset y-Offset that the drawer will animate to

 */
- (void)bottomDrawerDismissTransitionWillBegin:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                               withCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)
                                                   transitionCoordinator
                                 targetYOffset:(CGFloat)targetYOffset;

/**
 This method is called when the bottom drawer has completed animating to a closed state. This is
 triggered when the VC is being dismissed.

 @param presentationController presentation controller of the bottom drawer
 */
- (void)bottomDrawerDismissTransitionDidEnd:
    (nonnull MDCBottomDrawerPresentationController *)presentationController;

/**
 This method is called when the bottom drawer's scrim was tapped.

 @param presentationController presentation controller of the bottom drawer
 */
- (void)bottomDrawerDidTapScrim:
    (nonnull MDCBottomDrawerPresentationController *)presentationController;

@end
