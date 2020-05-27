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

#import "MDCFlexibleHeaderView.h"
#import "MaterialFlexibleHeader+ShiftBehavior.h"

#pragma mark - Shift behavior-specific APIs

/** Header's y position never changes in reaction to scroll events. */
FOUNDATION_EXTERN const MDCFlexibleHeaderShiftBehavior MDCFlexibleHeaderShiftBehaviorDisabled;

/** When fully-collapsed, the header translates vertically in reaction to scroll events. */
FOUNDATION_EXTERN const MDCFlexibleHeaderShiftBehavior MDCFlexibleHeaderShiftBehaviorEnabled;

/**
 Allows the header to be shifted on- and off-screen only via the @c shiftHeaderOnScreenAnimated:
 and @c shiftHeaderOffScreenAnimated APIs. Scroll events will not affect the visibility of the
 header.

 Analogous to UINavigationController's setNavigationBarHidden: behavior, in that the visibility of
 the navigation bar persists regardless of the user's subsequent interactions.
 */
FOUNDATION_EXTERN const MDCFlexibleHeaderShiftBehavior MDCFlexibleHeaderShiftBehaviorHideable;

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

@interface MDCFlexibleHeaderView ()

/**
 The behavior of the header in response to the user interacting with the tracking scroll view.

 @note If self.observesTrackingScrollViewScrollEvents is YES, then this property can not be
 MDCFlexibleHeaderShiftBehaviorEnabled or MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar.
 Attempts to set shiftBehavior to either of these values when
 self.observesTrackingScrollViewScrollEvents is YES will result in an assertion being thrown.

 Default: MDCFlexibleHeaderShiftBehaviorDisabled
 */
@property(nonatomic) MDCFlexibleHeaderShiftBehavior shiftBehavior;

/**
 If shiftBehavior is enabled, this property affects the manner in which the Header reappears when
 pulling content down in the tracking scroll view.

 Ignored if shiftBehavior == MDCFlexibleHeaderShiftBehaviorDisabled.

 Default: MDCFlexibleHeaderContentImportanceDefault
 */
@property(nonatomic) MDCFlexibleHeaderContentImportance headerContentImportance;

/**
 When enabled, the header view will prioritize shifting off-screen and collapsing over shifting
 on-screen and expanding.

 This should only be enabled when the user is scrubbing the tracking scroll view, i.e. they're
 able to jump large distances using a scrubber control.
 */
@property(nonatomic) BOOL trackingScrollViewIsBeingScrubbed;

/**
 Whether this header view's content is translucent/transparent. Provides a hint to status bar
 rendering, to correctly display contents scrolling under the status bar as it shifts on/off screen.

 Default: NO
 */
@property(nonatomic) BOOL contentIsTranslucent;

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

/**
 The minimum amount of header height to remain when `shiftBehavior` is enabled.
 */
@property(nonatomic) CGFloat minimumHeaderViewHeight;

/**
 Hides the view by changing its alpha when the header shifts. Note that this only happens when the
 header shifting behavior is set to MDCFlexibleHeaderShiftBehaviorEnabled.
 */
- (void)hideViewWhenShifted:(nonnull UIView *)view;

/** Stops hiding the view when the header shifts. */
- (void)stopHidingViewWhenShifted:(nonnull UIView *)view;

#pragma mark Shifting the tracking scroll view on-screen

/** Asks the receiver to bring the header on-screen if it's currently off-screen. */
- (void)shiftHeaderOnScreenAnimated:(BOOL)animated;

/** Asks the receiver to take the header off-screen if it's currently on-screen. */
- (void)shiftHeaderOffScreenAnimated:(BOOL)animated;

/**
 Indicates whether the header is or will be shifted offscreen.

 @returns YES if the header has been asked to shift offscreen by @c -shiftHeaderOffScreenAnimated:
 or if the user has fully shifted the header off-screen as a result of scrolling the tracking scroll
 view.
 */
@property(nonatomic, readonly, getter=isShiftedOffscreen) BOOL shiftedOffscreen;

#pragma mark - UIScrollViewDelegate APIs required for shift behavior

/**
 Informs the receiver that the tracking scroll view has finished dragging.

 Must be called from the trackingScrollView delegate's
 UIScrollViewDelegate::scrollViewDidEndDragging:willDecelerate: implementor.

 @note Do not invoke this method if self.observesTrackingScrollViewScrollEvents is YES.
 */
- (void)trackingScrollViewDidEndDraggingWillDecelerate:(BOOL)willDecelerate;

/**
 Informs the receiver that the tracking scroll view has finished decelerating.

 Must be called from the trackingScrollView delegate's
 UIScrollViewDelegate::scrollViewDidEndDecelerating: implementor.

 @note Do not invoke this method if self.observesTrackingScrollViewScrollEvents is YES.
 */
- (void)trackingScrollViewDidEndDecelerating;

/**
 Potentially modifies the target content offset in order to ensure that the header view is either
 visible or hidden depending on its current position.

 Must be called from the trackingScrollView delegate's
 -scrollViewWillEndDragging:withVelocity:targetContentOffset: implementor.

 If your scroll view is vertically paging then this method will do nothing. You should also
 disable hidesStatusBarWhenCollapsed.

 @note Do not invoke this method if self.observesTrackingScrollViewScrollEvents is YES.

 @return A Boolean value indicating whether the target content offset was modified.
 */
- (BOOL)trackingScrollViewWillEndDraggingWithVelocity:(CGPoint)velocity
                                  targetContentOffset:(inout nonnull CGPoint *)targetContentOffset;

@end
