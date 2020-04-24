// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

@protocol MDCTabBarViewDelegate;
@protocol MDCTabBarViewIndicatorTemplate;

/** The different layout options for the tabs within an @c MDCTabBarView. */
typedef NS_ENUM(NSUInteger, MDCTabBarViewLayoutStyle) {

  /**
   Each item's width is calculated as the width of the bar divided by the number of items.
   */
  MDCTabBarViewLayoutStyleFixed = 0,

  /**
   Each item's width is based on its content and the items are arranged horizontally starting from
   the leading edge of the bar. */
  MDCTabBarViewLayoutStyleScrollable = 1,

  /**
   Each item's width is as wide as the widest item. The items are arranged in the horizontal center
   of the bar.
   */
  MDCTabBarViewLayoutStyleFixedClusteredCentered = 2,

  /**
   Each item's width is as wide as the widest item. The items are arranged horizontally on the
   leading edge of the bar.
   */
  MDCTabBarViewLayoutStyleFixedClusteredLeading = 3,

  /**
   Each item's width is as wide as the widest item. The items are arranged horizontally on the
   trailing edge of the bar.
   */
  MDCTabBarViewLayoutStyleFixedClusteredTrailing = 4,

  /**
   The same as MDCTabBarViewLayoutStyleScrollable, but the selected tab is centered within the bar
   if its position in the scrollview's content area permits it.*/
  MDCTabBarViewLayoutStyleScrollableCentered = 5,

  /**
   Each item's width is based on its content. The items are arranged in the horizontal center of the
   bar.
   */
  MDCTabBarViewLayoutStyleNonFixedClusteredCentered = 6,
};

/**
 An implementation of Material Tabs (https://material.io/design/components/tabs.html).
 */
__attribute__((objc_subclassing_restricted)) @interface MDCTabBarView : UIScrollView

/** The set of items displayed in the Tab bar. */
@property(nonnull, nonatomic, copy) NSArray<UITabBarItem *> *items;

/** The currently-selected item in the Tab bar. */
@property(nullable, nonatomic, strong) UITabBarItem *selectedItem;

/** Set the selected item with or without animation. */
- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated;

/** The color of the Tab bar's background. */
@property(nullable, nonatomic, copy) UIColor *barTintColor;

/** The color of the bottom divider. Default is clear. */
@property(nonnull, nonatomic, copy) UIColor *bottomDividerColor;

/**
 The color for the Ripple effect for touch feedback.
 */
@property(nonnull, nonatomic, copy) UIColor *rippleColor;

/** The tab bar view delegate. */
@property(nullable, nonatomic, weak) id<MDCTabBarViewDelegate> tabBarDelegate;

/**
 The template for the selection indicator. Provides rendering information for the selection
 indicator in this tab bar.
 */
@property(nonnull, nonatomic, strong) id<MDCTabBarViewIndicatorTemplate> selectionIndicatorTemplate;

/**
 The stroke color for the selection indicator. If no value is set, then a default value is used.
 */
@property(nullable, nonatomic, copy) UIColor *selectionIndicatorStrokeColor;

/**
 The preferred layout style of the bar.  If possible, this layout style will be used. If not,
 another style will be used. For example, if the bar is too narrow for a Fixed layout style, then a
 Scrollable layout style may be used instead. Defaults to @c MDCTabBarViewLayoutStyleFixed.
 */
@property(nonatomic, assign) MDCTabBarViewLayoutStyle preferredLayoutStyle;

/**
 The current layout style of the Tab Bar. Although the user sets a preferred layout style, not all
 combinations of items, bounds, and style can be rendered correctly.
 */
@property(nonatomic, readonly) MDCTabBarViewLayoutStyle effectiveLayoutStyle;

/**
 Whether or not the tab bar should adjust for safe area insets when calculating content size.
 Default is YES.
 */
@property(nonatomic, assign) BOOL shouldAdjustForSafeAreaInsets;

/**
 A block that is invoked when the @c MDCTabBarView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCTabBarView *_Nonnull tabBar, UITraitCollection *_Nullable previousTraitCollection);

/**
 The total duration for all animations that take place during a selection change.

 This is guaranteed to be the total time between the start of the first animation and the end of
 the last animation that takes place for selection changes. There may not be a specific animation
 that has this exact duration.
 */
@property(nonatomic, readonly) CFTimeInterval selectionChangeAnimationDuration;

/**
 The timing function used by the tab bar when selection changes are animated. This should be used
 when performing implicit UIView-based animations to ensure that all animations internal to the
 TabBarView are coordinated using the same parameters.
 */
@property(nonatomic, readonly, nonnull)
    CAMediaTimingFunction *selectionChangeAnimationTimingFunction;

/**
 Sets the color of the bar items' image @c tintColor for the given control state.  Supports
 @c UIControlStateNormal and @c UIControlStateSelected.

 If no value for a control state is set, the value for @c UIControlStateNormal is used. If no value
 for @c UIControlStateNormal is set, then a default value is used.
 */
- (void)setImageTintColor:(nullable UIColor *)imageTintColor forState:(UIControlState)state;

/**
 Returns the color of the bar items' image @c tintColor for the given control state.

 If no value for a control state is set, the value for @c UIControlStateNormal is returned.
 */
- (nullable UIColor *)imageTintColorForState:(UIControlState)state;

/**
 Sets the color of the bar items' title for the given control state.  Supports
 @c UIControlStateNormal and @c UIControlStateSelected.

 If no value for a control state is set, the value for @c UIControlStateNormal is used. If no value
 for @c UIControlStateNormal is set, then a default value is used.
 */
- (void)setTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state;

/**
 Returns the color of the bar items' title for the given control state.

 If no value for a control state is set, the value for @c UIControlStateNormal is returned.
 */
- (nullable UIColor *)titleColorForState:(UIControlState)state;

/**
 Sets the font of the bar items' title for the given control state.  Supports
 @c UIControlStateNormal and @c UIControlStateSelected.

 If no value for a control state is set, the value for @c UIControlStateNormal is used. If no value
 for @c UIControlStateNormal is set, then a default value is used.
 */
- (void)setTitleFont:(nullable UIFont *)titleFont forState:(UIControlState)state;

/**
 Returns the font of the bar items' title for the given control state.

 If no value for a control state is set, the value for @c UIControlStateNormal is returned.
 */
- (nullable UIFont *)titleFontForState:(UIControlState)state;

/**
 Sets the padding around the tabs content used for the specified layout style. For example,
 @c MDCTabBarViewLayoutStyleScrollable has a default left padding of 52 points. The left and right
 values are flipped for right-to-left layouts.

 @note The padding is applied only when the @c layoutStyle is currently in-use, which depends on
 the preferred layout style, the size of the tabs, and the current bounds.

 @param contentPadding Additional space to include around the tab views.
 @param layoutStyle The layout style when the padding is applied.
 */
- (void)setContentPadding:(UIEdgeInsets)contentPadding
           forLayoutStyle:(MDCTabBarViewLayoutStyle)layoutStyle;

/**
 The content padding used for the specified layout style.

 @param layoutStyle The layout style when the padding is applied.
 */
- (UIEdgeInsets)contentPaddingForLayoutStyle:(MDCTabBarViewLayoutStyle)layoutStyle;

/**
 Returns the @c UIAccessibility element associated with the provided item.

 @note The returned object is not guaranteed to be of type @c UIAccessibilityElement. It is
       guaranteed to be the same object UIAccessibility systems identify as representing @c item.

 @param item A tab bar item in the receivers @c items array.
 @return The @c UIAccessibility element associated with @c item if one exists, else @c nil.
 */
- (nullable id)accessibilityElementForItem:(nonnull UITabBarItem *)item;

/**
 Provides the frame of the tab bar subview that visually represents @c item. If @c item is not
 present in the tab bar's list of items, then the null rectangle is returned.

 @param item The tab bar item for computing a frame.
 @param coordinateSpace The space in which to calculate the item's corresponding frame.
 */
- (CGRect)rectForItem:(nonnull UITabBarItem *)item
    inCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace;

@end
