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
#import "MaterialShadowElevations.h"

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
 The absolute height in points to which the drawer may expand initially.

 Defaults to 0, indicating no value has been set and it should use the default behavior of 50%
 of the screen's height.

 If the value is larger than the container's height, this will result the drawer being presented
 at fullscreen.

 Note: When TraitCollection is UIUserInterfaceSizeClassCompact or when using
 VoiceOver or SwitchControl, the drawer will always present at full screen.
 */
@property(nonatomic, assign) CGFloat maximumInitialDrawerHeight;

/**
 A flag allowing clients to opt-out of the drawer closing when the user taps outside the content.

 @default YES The drawer should dismiss on tap.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 A flag allowing clients to opt-in to handling background touch events.

 @default NO The drawer will not forward touch events.

 @discussion If set to YES and the delegate is an instance of @UIResponder, then the touch events
 that are not handled by the drawer content (aka touches on the background view) will be forwarded
 along to the delegate.

 Note: @dismissOnBackgroundTap should also be set to NO so that the events will propagate properly
 from the background tap through to the delegate. Setting @shouldForwardBackgroundTouchEvents to YES
 will also set @dismissOnBackgroundTap to NO.
 */
@property(nonatomic, assign) BOOL shouldForwardBackgroundTouchEvents;

/**
 A flag allowing clients to opt-in to the drawer adding additional height to the content to include
 the bottom safe area inset. This will remove the need for clients to calculate their content size
 with the bottom safe area when setting the preferredContentSize of the contentViewController.
 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldIncludeSafeAreaInContentHeight;

/**
 A flag allowing clients to opt-in to adding additional height to the initial presentation of the
 drawer to include the bottom safe area inset. This will remove the need for clients to calculate
 their desired maximum height with the bottom safe area when setting the maximumInitialDrawerHeight.
 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldIncludeSafeAreaInInitialDrawerHeight;

/**
 This flag allows clients to have the drawer content scroll below the status bar when no header is
 provided.

 Note: This flag is only applicable when @c headerViewController is nil. If @c headerViewController
 is non-nil, setting this flag to YES will have no effect.

 Defaults to NO.
*/
@property(nonatomic, assign) BOOL shouldUseStickyStatusBar;

/**
 Determines the behavior of the drawer when the content size changes.
 If enabled, the drawer will automatically adjust the visible height as needed, otherwise the
 visible height will not be changed to reflect the updated content height.
 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldAdjustOnContentSizeChange;

/**
 A boolean value that indicates whether the drawer is currently the full height of the window.
 */
@property(nonatomic, readonly) BOOL contentReachesFullscreen;

/**
 The drawer's top shadow color. Defaults to black with 20% opacity.
 */
@property(nonatomic, strong, nonnull) UIColor *drawerShadowColor;

/**
 The drawer's elevation. Defaults to MDCShadowElevationNavDrawer.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 Determines if the header should always expand as it approaches the top of the screen.
 If the content height is smaller than the screen height then the header will not expand unless this
 flag is enabled.
 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldAlwaysExpandHeader;

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

/**
 A block that is invoked when the @c MDCBottomDrawerPresentationController  receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCBottomDrawerPresentationController *_Nullable presentationController,
     UITraitCollection *_Nullable previousTraitCollection);
@end
