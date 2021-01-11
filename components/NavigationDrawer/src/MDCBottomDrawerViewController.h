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
#import "MaterialElevation.h"
#import "MDCBottomDrawerPresentationController.h"
#import "MDCBottomDrawerState.h"
// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MDCBottomDrawerViewControllerDelegate.h"
#import "MaterialShadowElevations.h"

@protocol MDCBottomDrawerHeader;
@protocol MDCBottomDrawerViewControllerDelegate;

/**
 View controller for containing a Material bottom drawer.
 */
@interface MDCBottomDrawerViewController
    : UIViewController <MDCBottomDrawerPresentationControllerDelegate,
                        MDCElevatable,
                        MDCElevationOverriding>

/**
 The main content displayed by the drawer.
 Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController *contentViewController;

/**
 A header to display above the drawer's main content.
 Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController<MDCBottomDrawerHeader> *headerViewController;

/**
 A scroll view contained within the contentViewController.

 If the contentViewController contains a UIScrollView or UIScrollView subclass it is recommended to
 set that scroll view as the tracking scroll view.

 Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 the drawer movement. This allows the provided scroll view to load the visible
 content as the drawer moves, and therefore not load all the content at once
 and allow to reuse the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 The current state of the bottom drawer.
 */
@property(nonatomic, readonly) MDCBottomDrawerState drawerState;

/**
 The color applied to the background scrim.
 */
@property(nonatomic, strong, nullable) UIColor *scrimColor;

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
 The absolute height in points to which the drawer may expand when a user scrolls.

 Defaults to 0, indicating no value has been set and it should use the default behavior of 100% of
 the screen's height.

 Once the maximumDrawerHeight is reached the drawer state will return @c
 MDCBottomDrawerStateExpanded.

 If the value is larger than the container's height, this will allow the drawer to be scrolled to
 the full height of the container.
 */
@property(nonatomic, assign) CGFloat maximumDrawerHeight;

/**
 A flag allowing clients to opt-out of the drawer closing when the user taps outside the content.

 @default YES The drawer should dismiss on tap.
 */
@property(nonatomic, assign) BOOL dismissOnBackgroundTap;

/**
 A flag allowing clients to opt-out of the drawer closing when user uses accessibility escape
 gesture. If set to NO, you can alternatively set an accessibility escape action by implementing the
 @c accessibilityPerformEscape method in your provided contentViewController.

 @default YES The drawer dismisses on z-gesture.
 */
@property(nonatomic, assign) BOOL shouldDismissOnAccessibilityPerformEscape;

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
 The drawer's top shadow color. Defaults to black with 20% opacity.
 */
@property(nonatomic, strong, nonnull) UIColor *drawerShadowColor;

/**
 The drawer's elevation. Defaults to MDCShadowElevationNavDrawer.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 The bottom drawer delegate.
 */
@property(nonatomic, weak, nullable) id<MDCBottomDrawerViewControllerDelegate> delegate;

/**
 Determines if the header should always expand as it approaches the top of the screen.
 If the content height is smaller than the screen height then the header will not expand unless this
 flag is enabled.
 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldAlwaysExpandHeader;

/**
 Determines the behavior of the drawer when the content size changes.
 If enabled, the drawer will automatically adjust the visible height as needed, otherwise the
 visible height will not be changed to reflect the updated content height.
 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldAdjustOnContentSizeChange;

/**
 Whether layout adjustments should be made to support iPad Slide Over.

 Defaults to NO to maintain the same behavior that existed before this property
 was added and to allow apps to migrate on their own schedule.
 */
@property(nonatomic) BOOL adjustLayoutForIPadSlideOver;

/**
 Whether to display mobile landscape view as fullscreen.

 When enabled, the drawer will fill the screen in landscape on mobile devices.

 Defaults to YES.
*/
@property(nonatomic) BOOL shouldDisplayMobileLandscapeFullscreen;

/** Whether the drawer allows the user to drag it or not. */
@property(nonatomic) BOOL userDraggingEnabled;

/**
 Sets the top corners radius for an MDCBottomDrawerState drawerState

 @param radius The corner radius to set the top corners.
 @param drawerState MDCBottomDrawerState the drawer state.
 */
- (void)setTopCornersRadius:(CGFloat)radius forDrawerState:(MDCBottomDrawerState)drawerState;

/**
 Returns the top corners radius for an MDCBottomDrawerState drawerState.

 If no radius has been set for a state, the value 0 is returned.

 @param drawerState MDCBottomDrawerState the drawer state.
 @return The corner radius to set the top corners.
 */
- (CGFloat)topCornersRadiusForDrawerState:(MDCBottomDrawerState)drawerState;

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
 A block that is invoked when the @c MDCBottomDrawerViewController receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCBottomDrawerViewController *_Nonnull bottomDrawer,
     UITraitCollection *_Nullable previousTraitCollection);

@end
