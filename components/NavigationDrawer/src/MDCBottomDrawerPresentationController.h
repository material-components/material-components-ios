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

@end

/**
 The presentation controller to use for presenting an MDC bottom drawer.
 */
@interface MDCBottomDrawerPresentationController : UIPresentationController

/**
 Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 the drawer movement. This allows the provided scroll view to load the visible
 content as the drawer moves, and therefore not load all the content at once
 and allow to reuse the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 The color applied to the background scrim.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

/**
 Delegate to tell the presenter when the drawer will change state.
 */
@property(nonatomic, weak, nullable) id<MDCBottomDrawerPresentationControllerDelegate> delegate;

/**
 A Boolean value that determines whether the top handle of the drawer is hidden.
 Default is YES.
 */
@property(nonatomic, assign, getter=isTopHandleHidden) BOOL topHandleHidden;

/**
 The color applied to the top handle.
 Note: Make sure that topHandleHidden is set to NO to have the top handle be visible.
 Default is set to 0xE0E0E0.
 */
@property(nonatomic, strong, nullable) UIColor *topHandleColor;

/**
 A boolean value that indicates whether the drawer is currently the full height of the window.
 */
@property(nonatomic, readonly) BOOL contentReachesFullscreen;

/**
 Sets the content offset Y of the drawer's content. If contentOffsetY is set to 0, the
 drawer will scroll to the start of its content.

 @param contentOffsetY the content offset Y of the scroll view.
 @param animated a bool if to animate the scrolling.
 */
- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated;

/**
 Expands the drawer to fullscreen with animation.

 note: If the drawer has less content than the full screen,
 this method will still expand the drawer to fullscreen.

 @param duration The total duration of the animations, measured in seconds. If you specify a
 negative value or 0, the changes are made without animating them.

 @param completion A block object to be executed when the animation sequence ends. This block has
 no return value and takes a single Boolean argument that indicates whether or not the animations
 actually finished before the completion handler was called. If the duration of the animation is 0,
 this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.
 */
- (void)expandToFullscreenWithDuration:(CGFloat)duration
                            completion:(void (^__nullable)(BOOL finished))completion;
@end
