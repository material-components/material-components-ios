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

@class MDCBottomDrawerContainerViewController;
@protocol MDCBottomDrawerHeader;
@protocol MDCBottomDrawerContainerViewControllerDelegate;

/**
 Delegate for MDCBottomDrawerContainerViewController.
 */
@protocol MDCBottomDrawerContainerViewControllerDelegate <NSObject>
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

/**
 View controller for containing a Google Material bottom drawer. Used internally only.
 */
@interface MDCBottomDrawerContainerViewController : UIViewController <UIGestureRecognizerDelegate>

/**
 Designated initializer.

 @param originalPresentingViewController The original presenting view controller.
 */
- (nonnull instancetype)initWithOriginalPresentingViewController:
                            (nonnull UIViewController *)originalPresentingViewController
                                              trackingScrollView:
                                                  (nullable UIScrollView *)trackingScrollView
    NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;
- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                                 bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/**
 The content displayed by the drawer.
 Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController *contentViewController;

/**
 A header to display above the drawer's main content.
 Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController<MDCBottomDrawerHeader> *headerViewController;

// The original presenting view controller.
@property(nonatomic, readonly, nonnull) UIViewController *originalPresentingViewController;

/**
 Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 the drawer movement. This allows the provided scroll view to load the visible
 content as the drawer moves, and therefore not load all the content at once
 and allow to reuse the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

// Whether the drawer is currently animating its presentation.
@property(nonatomic) BOOL animatingPresentation;

/**
 Delegate to tell the presentation controller when the drawer will change state.
 */
@property(nonatomic, weak, nullable) id<MDCBottomDrawerContainerViewControllerDelegate> delegate;

/**
 The current state of the bottom drawer.
 */
@property(nonatomic, readonly) MDCBottomDrawerState drawerState;

/**
 A boolean value that indicates whether the drawer is currently the full height of the window.
 */
@property(nonatomic, readonly) BOOL contentReachesFullscreen;

/**
 The height added to the bottom of the navigation drawer to hide the scrim.
 Defaults to 0.
 */
@property(nonatomic, assign) CGFloat addedHeight;

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
