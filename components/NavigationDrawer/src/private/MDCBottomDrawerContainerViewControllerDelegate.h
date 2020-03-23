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

@class MDCBottomDrawerContainerViewController;

/**
 Delegate for MDCBottomDrawerContainerViewController.
 */
@protocol MDCBottomDrawerContainerViewControllerDelegate <NSObject>

/**
This method is called when the MDCBottomDrawerContainerViewControllerDelegate needs to update the
appearance of the scrim.

@param containerViewController the container view controller of the bottom drawer.
@param scrimShouldAdoptTrackingScrollViewBackgroundColor whether or not the scrim view should adopt
the backgroundColor of the trackingScrollView.
*/
- (void)bottomDrawerContainerViewControllerNeedsScrimAppearanceUpdate:
            (nonnull MDCBottomDrawerContainerViewController *)containerViewController
                    scrimShouldAdoptTrackingScrollViewBackgroundColor:
                        (BOOL)scrimShouldAdoptTrackingScrollViewBackgroundColor;

/**
 This method is called when the bottom drawer will change its presented state to one of the
 MDCBottomDrawerState states.

 @param containerViewController the container view controller of the bottom drawer.
 @param drawerState the drawer's state.
 */
- (void)bottomDrawerContainerViewControllerWillChangeState:
            (nonnull MDCBottomDrawerContainerViewController *)containerViewController
                                               drawerState:(MDCBottomDrawerState)drawerState;

/**
 This method is called when the bottom drawer will change the y-offset of its contents.

 @param containerViewController the container view controller of the bottom drawer.
 @param yOffset current yOffset of the bottom drawer contents
 */
- (void)bottomDrawerContainerViewControllerDidChangeYOffset:
            (nonnull MDCBottomDrawerContainerViewController *)containerViewController
                                                    yOffset:(CGFloat)yOffset;
/**
 This method is called when the drawer is scrolled/dragged and provides a transition ratio value
 between 0-100% (0-1) that indicates the percentage in which the drawer is close to reaching the end
 of its scrolling. If the drawer is about to reach fullscreen, its percentage moves between 0-100%
 as it starts covering the safe area and status bar. If the drawer doesn't reach full screen, it
 moves between 0-100% as it reaches 20 points away from being fully expanded.
 - 1 or 100% indicates the drawer has reached the end of its scrolling upwards to reveal content.
 - 0 or 0% indicates that there is more scrolling to be done for the drawer to either present
 more content or to transition to full screen.

 @param containerViewController the container view controller of the bottom drawer.
 @param transitionRatio The transition ratio betwen 0-100% (0-1).
 */
- (void)bottomDrawerContainerViewControllerTopTransitionRatio:
            (nonnull MDCBottomDrawerContainerViewController *)containerViewController
                                              transitionRatio:(CGFloat)transitionRatio;
@end
