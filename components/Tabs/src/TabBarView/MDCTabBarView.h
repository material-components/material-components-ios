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
 Returns the @c UIAccessibility element associated with the provided item.

 @note The returned object is not guaranteed to be of type @c UIAccessibilityElement. It is
       guaranteed to be the same object UIAccessibility systems identify as representing @c item.

 @param item A tab bar item in the receivers @c items array.
 @return The @c UIAccessibility element associated with @c item if one exists, else @c nil.
 */
- (nullable id)accessibilityElementForItem:(nonnull UITabBarItem *)item;

@end
