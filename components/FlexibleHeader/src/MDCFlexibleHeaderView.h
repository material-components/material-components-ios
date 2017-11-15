/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

typedef void (^MDCFlexibleHeaderChangeContentInsetsBlock)(void);
typedef void (^MDCFlexibleHeaderShadowIntensityChangeBlock)(CALayer *_Nonnull shadowLayer,
                                                            CGFloat intensity);

/**
 The possible translation (shift) behaviors of a flexible header view.

 Enabling shifting allows the header to enter the
 @c MDCFlexibleHeaderScrollPhaseShifting scroll phase.
 */
typedef NS_ENUM(NSInteger, MDCFlexibleHeaderShiftBehavior) {

  /** Header's y position never changes in reaction to scroll events. */
  MDCFlexibleHeaderShiftBehaviorDisabled,

  /** When fully-collapsed, the header translates vertically in reaction to scroll events. */
  MDCFlexibleHeaderShiftBehaviorEnabled,

  /**
   When fully-collapsed, the header translates vertically in reaction to scroll events along with
   the status bar.

   If used with a vertically-paging scroll view, this behavior acts like
   MDCFlexibleHeaderShiftBehaviorEnabled.
   */
  MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar,
};

/** The importance of content contained within the flexible header view. */
typedef NS_ENUM(NSInteger, MDCFlexibleHeaderContentImportance) {

  /**
   Default behavior requires at most approximately a single swipe before the header re-appears.
   */
  MDCFlexibleHeaderContentImportanceDefault,

  /**
   Highly-important header content will re-appear faster than default importance.

   Examples of important content:

   - Search bar.
   - Non-navigational actions.
   */
  MDCFlexibleHeaderContentImportanceHigh,
};

/** Mutually exclusive phases that the flexible header view can be in. */
typedef NS_ENUM(NSInteger, MDCFlexibleHeaderScrollPhase) {

  /**
   The header is at its min height and shifting off/on screen.

   frame.origin.y is changing.
   */
  MDCFlexibleHeaderScrollPhaseShifting,

  /**
   The header is changing its height within the min-max range.

   frame.size.height is changing.
   */
  MDCFlexibleHeaderScrollPhaseCollapsing,

  /**
   The header is changing its height and is taller than its maximum height.

   frame.size.height is changing.
   */
  MDCFlexibleHeaderScrollPhaseOverExtending,
};

@protocol MDCFlexibleHeaderViewDelegate;

/**
 MDCFlexibleHeaderView tracks the content offset of a scroll view and adjusts its size and
 position according to a configurable set of behaviors.

 ### UIScrollViewDelegate forwarding

 This view relies on you informing it of certain UIScrollViewDelegate events as they happen. These
 events are listed in the UIScrollViewDelegate events section.
 */
IB_DESIGNABLE
@interface MDCFlexibleHeaderView : UIView

#pragma mark Custom shadow

/**
 Custom shadow shown under flexible header content.
 */
@property(nonatomic, strong, nullable) CALayer *shadowLayer;

/**
 Sets a custom shadow layer and a block that should be executed when shadow intensity changes.
 */
- (void)setShadowLayer:(nonnull CALayer *)shadowLayer
    intensityDidChangeBlock:(nonnull MDCFlexibleHeaderShadowIntensityChangeBlock)block;

#pragma mark UIScrollViewDelegate events

/**
 Informs the receiver that the tracking scroll view's contentOffset has changed.

 Must be called from the trackingScrollView delegate's UIScrollViewDelegate::scrollViewDidScroll:
 implementor.
 */
- (void)trackingScrollViewDidScroll;

/**
 Informs the receiver that the tracking scroll view has finished dragging.

 Must be called from the trackingScrollView delegate's
 UIScrollViewDelegate::scrollViewDidEndDragging:willDecelerate: implementor.
 */
- (void)trackingScrollViewDidEndDraggingWillDecelerate:(BOOL)willDecelerate;

/**
 Informs the receiver that the tracking scroll view has finished decelerating.

 Must be called from the trackingScrollView delegate's
 UIScrollViewDelegate::scrollViewDidEndDecelerating: implementor.
 */
- (void)trackingScrollViewDidEndDecelerating;

/**
 Potentially modifies the target content offset in order to ensure that the header view is either
 visible or hidden depending on its current position.

 Must be called from the trackingScrollView delegate's
 -scrollViewWillEndDragging:withVelocity:targetContentOffset: implementor.

 If your scroll view is vertically paging then this method will do nothing. You should also
 disable hidesStatusBarWhenCollapsed.

 @return A Boolean value indicating whether the target content offset was modified.
 */
- (BOOL)trackingScrollViewWillEndDraggingWithVelocity:(CGPoint)velocity
                                  targetContentOffset:(inout nonnull CGPoint *)targetContentOffset;

#pragma mark Changing the tracking scroll view

/**
 Informs the receiver that the tracking scroll view might be about to change to a new tracking
 scroll view.
 */
- (void)trackingScrollWillChangeToScrollView:(nullable UIScrollView *)scrollView;

#pragma mark Shifting the tracking scroll view on-screen

/** Asks the receiver to bring the header on-screen if it's currently off-screen. */
- (void)shiftHeaderOnScreenAnimated:(BOOL)animated;

/** Asks the receiver to take the header off-screen if it's currently on-screen. */
- (void)shiftHeaderOffScreenAnimated:(BOOL)animated;

#pragma mark UIKit Hooks

// All of these UIKit hooks must be called from the view controller that owns this header view.
// Failure to do so will result in undefined behavior of the flexible header view.

/**
 Returns a Boolean value indicating whether the status bar should be visible.

 Must be called by the owning UIViewController's -prefersStatusBarHidden.
 */
@property(nonatomic, readonly) BOOL prefersStatusBarHidden;

// Pre-iOS 8 Interface Orientation APIs

/**
 Informs the receiver that the interface orientation is about to change.

 Must be called from UIViewController::willRotateToInterfaceOrientation:duration:.
 */
- (void)interfaceOrientationWillChange;

/**
 Informs the receiver that the interface orientation is in the process of changing.

 Must be called from UIViewController::willAnimateRotationToInterfaceOrientation:duration:.
 */
- (void)interfaceOrientationIsChanging;

/**
 Informs the receiver that the interface orientation has changed.

 Must be called from UIViewController::didRotateFromInterfaceOrientation:.
 */
- (void)interfaceOrientationDidChange;

// iOS 8 Interface Orientation APIs

/**
 Informs the receiver that the owning view controller's size will change.

 Must be called from UIViewController::viewWillTransitionToSize:withTransitionCoordinator: on apps
 targeting iOS 8 and onward.
 */
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator;

#pragma mark Changing Content Insets

/**
 Must be called by a client that wishes to update the content insets of the tracking scroll view.

 Not using this method can lead to undefined behavior due to the flexible header view assuming
 that a certain amount of additional content insets have been provided to the tracking scroll
 view.

 The provided block will be executed after the flexible header has removed its modifications to
 the tracking scroll view. Upon completion of the block, the flexible header will re-inject these
 modifications into the new content insets and ensure that the content offset doesn't change due
 to the new content insets.
 */
- (void)changeContentInsets:(nonnull MDCFlexibleHeaderChangeContentInsetsBlock)block;

#pragma mark Forwarding Touch Events

/**
 Forwards any tap events made to the provided view on to the tracking scroll view.

 Views will only forward their taps if they are a subview of this header view and are interactive.

 Touch forwarding does not apply to subviews of the provided view.
 */
- (void)forwardTouchEventsForView:(nonnull UIView *)view;

/** Stops forwarding tap events on the given view to the tracking scroll view. */
- (void)stopForwardingTouchEventsForView:(nonnull UIView *)view;

#pragma mark Scroll Phase

/**
 Returns the current scroll phase of the flexible header.

 There are three mutually-exclusive scroll phases: shifting, collapsing, and over-extending.
 Whichever phase the header view is in governs what scrollPhaseValue and scrollPhasePercentage
 represent.

 This and the related scrollPhase properties are only valid immediately after a call to
 -trackingScrollViewDidScroll.
 */
@property(nonatomic, readonly) MDCFlexibleHeaderScrollPhase scrollPhase;

/**
 A value in screen points denoting the absolute position within the current scroll phase.

 The range for each phase follows:

 - Shifting:       [0, minimumHeight)
 - Collapsing:     [minimumHeight, maximumHeight)
 - Over-extending: [maximumHeight, +inf)
 */
@property(nonatomic, readonly) CGFloat scrollPhaseValue;

/**
 A normalized value denoting the position within the current scroll phase.

 The meaning of the percentage for each phase follows:

 - Shifting:       0 is unshifted, 1.0 is fully shifted off-screen
 - Collapsing:     0 == minimumHeight, 1.0 == maximumHeight
 - Over-extending: 1.0 height == maximumHeight, every additional 1.0 is one maximumHeight unit

 Note that a single percentage does not necessarily have equal weight between the three phases, so
 you should not use this value for any behavior that is active across any two phases; use
 scrollPhaseValue instead.
 */
@property(nonatomic, readonly) CGFloat scrollPhasePercentage;

#pragma mark Bounding Dimensions

/**
 The minimum height that this header can shrink to.

 See minMaxHeightIncludesSafeArea to learn how this number is used when the Safe Area changes.

 If you change the value of this property and the maximumHeight of the receiver is below the new
 minimumHeight, maximumHeight will be adjusted to match the new minimum value.
 */
@property(nonatomic) CGFloat minimumHeight;

/**
 The maximum height that this header can expand to.

 See minMaxHeightIncludesSafeArea to learn how this number is used when the Safe Area changes.

 If you change the value of this property and the minimumHeight of the receiver is above the new
 maximumHeight, minimumHeight will be adjusted to match the new maximumHeight.
 */
@property(nonatomic) CGFloat maximumHeight;

/**
 When this is enabled, the flexible header will assume that minimumHeight and maximumHeight both
 include the Safe Area top inset. For example, a header whose maximum content height should be 200
 might set 220 (200 + 20) as the maximumHeight. Notice that if this is enabled and you're setting
 minimumHeight and or maximumHeight, the flexible header won't automatically adjust its size to
 account for changes to the Safe Area, as the values provided already include a hardcoded inset.

 When this is disabled, the flexible header will assume that the provided minimumHeight and
 maximumHeight do not include the Safe Area top inset. For example, a header whose maximum content
 height should be 200 would set 200 as the maximumHeight, and the flexible header will take care
 of adjusting itself to account for Safe Area changes internally.

 Clients are recommended to set this to NO, and set the min and max heights to values that don't
 include the status bar or Safe Area insets.

 Default is YES.
 */
@property(nonatomic) BOOL minMaxHeightIncludesSafeArea;

#pragma mark Behaviors

/** The behavior of the header in response to the user interacting with the tracking scroll view. */
@property(nonatomic) MDCFlexibleHeaderShiftBehavior shiftBehavior;

/**
 Hides the view by changing its alpha when the header shifts. Note that this only happens when the
 header shifting behavior is set to MDCFlexibleHeaderShiftBehaviorEnabled.
 */
- (void)hideViewWhenShifted:(nonnull UIView *)view;

/** Stops hiding the view when the header shifts. */
- (void)stopHidingViewWhenShifted:(nonnull UIView *)view;

/**
 If shiftBehavior is enabled, this property affects the manner in which the Header reappears when
 pulling content down in the tracking scroll view.

 Ignored if shiftBehavior == MDCFlexibleHeaderShiftBehaviorDisabled.

 Default: MDCFlexibleHeaderContentImportanceDefault
 */
@property(nonatomic) MDCFlexibleHeaderContentImportance headerContentImportance;

/**
 Whether or not the header view is allowed to expand past its maximum height when the tracking
 scroll view has been dragged past its top edge.

 Default: YES
 */
@property(nonatomic) BOOL canOverExtend;

/**
 A hint stating whether or not the operating system's status bar frame can ever overlap the header's
 frame.

 This property is enabled by default with the expectation that the flexible header will primarily
 be used in full-screen settings on the phone.

 Disabling this property informs the flexible header that it should not concern itself with the
 status bar in any manner. shiftBehavior .EnabledWithStatusBar will be treated simply as .Enabled
 in this case.

 Default: YES
 */
@property(nonatomic) BOOL statusBarHintCanOverlapHeader;

@property(nonatomic) float visibleShadowOpacity;  ///< The visible shadow opacity. Default: 0.4

#pragma mark Scroll View Tracking

/**
 The scroll view whose content offset affects the height/offset of the flexible header view.

 The receiver will inject the maximum height of the header view into the top component of the
 tracking scroll view's content insets. This ensures that there is enough space in the top insets
 to fit the header. This should be taken into account when working with the tracking scroll view's
 content insets.

 Importantly, if you wish to make changes to the tracking scroll view's content insets after it
 has been registered to a flexible header view, you must do so from within a -changeContentInsets:
 invocation on the flexible header view.

 The tracking scroll view is weakly held so that we don't unintentionally keep the scroll view
 around any longer than it needs to be. Doing so could get into tricky situations where the view
 controller didn't nil out the scroll view's delegate in dealloc and UIScrollView's non-weak
 delegate points to a dead object.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/**
 When enabled, the header view will prioritize shifting off-screen and collapsing over shifting
 on-screen and expanding.

 This should only be enabled when the user is scrubbing the tracking scroll view, i.e. they're
 able to jump large distances using a scrubber control.
 */
@property(nonatomic) BOOL trackingScrollViewIsBeingScrubbed;

/**
 Whether or not the header is floating in front of an infinite stream of content.

 Enabling this behavior will cause the header to always appear to be floating "in front of" the
 content in Material space. This behavior should _only_ be enabled for content that has no top
 edge, e.g. an infinite stream of vertical content.

 Default: NO
 */
@property(nonatomic, getter=isInFrontOfInfiniteContent) BOOL inFrontOfInfiniteContent;

/**
 Whether or not the receiver is shared by many scroll views, such as in a tabbed interface with
 many columns of content.

 Default: NO
 */
@property(nonatomic) BOOL sharedWithManyScrollViews;

#pragma mark Configuring Status Bar Behaviors

/**
 Whether this header view's content is translucent/transparent. Provides a hint to status bar
 rendering, to correctly display contents scrolling under the status bar as it shifts on/off screen.

 Default: NO
 */
@property(nonatomic) BOOL contentIsTranslucent;

#pragma mark Header View Delegate

/** The delegate for this header view. */
@property(nonatomic, weak, nullable) id<MDCFlexibleHeaderViewDelegate> delegate;

@end

/**
 The MDCFlexibleHeaderViewDelegate protocol allows a delegate to respond to changes in the header
 view's state.

 The delegate is typically the UIViewController that owns this flexible header view.
 */
@protocol MDCFlexibleHeaderViewDelegate <NSObject>
@required

/**
 Informs the receiver that the flexible header view's preferred status bar visibility has changed.
 */
- (void)flexibleHeaderViewNeedsStatusBarAppearanceUpdate:
        (nonnull MDCFlexibleHeaderView *)headerView;

/**
 Informs the receiver that the flexible header view's frame has changed.

 The frame may change in response to scroll events of the tracking scroll view. The receiver
 should use the MDCFlexibleHeaderView scrollPhase APIs to determine which phase the header's frame
 is in.
 */
- (void)flexibleHeaderViewFrameDidChange:(nonnull MDCFlexibleHeaderView *)headerView;

@end

// clang-format off
@interface MDCFlexibleHeaderView ()

/** @see shiftBehavior */
@property(nonatomic) MDCFlexibleHeaderShiftBehavior behavior
__deprecated_msg("Use shiftBehavior instead.");

#pragma mark Accessing the header's views

/** Deprecated. Please register views directly to the flexible header. */
@property(nonatomic, strong, nonnull) UIView *contentView
__deprecated_msg("Please register views directly to the flexible header.");

@end
// clang-format on
