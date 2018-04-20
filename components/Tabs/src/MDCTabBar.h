/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTabBarAlignment.h"
#import "MDCTabBarItemAppearance.h"
#import "MDCTabBarTextTransform.h"

@class MDCTabBarItem;
@protocol MDCTabBarDelegate;
@protocol MDCTabBarIndicatorTemplate;

typedef NS_ENUM(NSInteger, MDCTabBarItemState) {
  /** State for unselected tab bar item. */
  MDCTabBarItemStateNormal,
  /** State for selected tab bar item. */
  MDCTabBarItemStateSelected,
};

/**
 A material tab bar for switching between views of grouped content.

 Clients are responsible for responding to changes to the selected tab and updating the selected
 tab as necessary.

 Note: This class is not intended to be subclassed.

 @see https://material.io/guidelines/components/tabs.html
 */
IB_DESIGNABLE
@interface MDCTabBar : UIView <UIBarPositioning>

/** The default height for the tab bar with a given position and item appearance. */
+ (CGFloat)defaultHeightForBarPosition:(UIBarPosition)position
                        itemAppearance:(MDCTabBarItemAppearance)appearance;

/** The default height for the tab bar in the top position, given an item appearance. */
+ (CGFloat)defaultHeightForItemAppearance:(MDCTabBarItemAppearance)appearance;

/**
 Items displayed in the tab bar.

 The bar determines the newly-selected item using the following logic:
 * Reselect the previously-selected item if it's still present in `items` after the update.
 * If there was no selection previously or if the old selected item is gone, select the first item.
   Clients that need empty selection to be preserved across updates to `items` must manually reset
   selectedItem to nil after the update.

 Changes to this property are not animated.
 */
@property(nonatomic, copy, nonnull) NSArray<UITabBarItem *> *items;

/**
 The currently selected item. Setting to nil will clear the selection.

 Changes to `selectedItem` are not animated.
 */
@property(nonatomic, strong, nullable) UITabBarItem *selectedItem;

/** The tab bar's delegate. */
@property(nonatomic, weak, nullable) IBOutlet id<MDCTabBarDelegate> delegate;

/**
 Tint color for the tab bar, which determines the color of the tab indicator bar. If
 selectedItemTintColor is nil, tintColor also affects tinting of selected item titles and images.
 */
@property(nonatomic, strong, null_resettable) UIColor *tintColor;

/**
 Tint color for selected items. If set overrides titleColorForState: and imageTintColorForState:
 for MDCTabBarItemStateSelected. Returns imageTintColorForState: for MDCTabBarItemStateSelected.
 */
@property(nonatomic, nullable) UIColor *selectedItemTintColor UI_APPEARANCE_SELECTOR;

/**
 Tint color for unselected items. If set overrides titleColorForState: and imageTintColorForState:
 for MDCTabBarItemStateNormal. Returns imageTintColorForState: for MDCTabBarItemStateNormal.
 */
@property(nonatomic, nonnull) UIColor *unselectedItemTintColor UI_APPEARANCE_SELECTOR;

/** Ink color for taps on tab bar items. Default: Semi-transparent white. */
@property(nonatomic, nonnull) UIColor *inkColor UI_APPEARANCE_SELECTOR;

/** Color for the bottom divider. Default: Clear. */
@property(nonatomic, nonnull) UIColor *bottomDividerColor;

/**
 Font used for selected item titles.
 By default this uses +[MDCTypography buttonFont]. Ignored for bottom-position tab bars.

 Note: Tab sizes are determined based on their unselected state and do not vary based on selection.
 To avoid clipped layouts and other layout issues, the font provided here should have similar
 metrics to `unselectedItemTitleFont`.
 */
@property(nonatomic, strong, nonnull) UIFont *selectedItemTitleFont UI_APPEARANCE_SELECTOR;

/**
 Font used for unselected item titles.
 By default this uses the MDCTypography button font. Ignored for bottom-position tab bars.

 Note: Tab sizes are determined based on their unselected state and do not vary based on selection.
 To avoid clipped layouts and other layout issues, the font provided here should have similar
 metrics to `selectedItemTitleFont`.
 */
@property(nonatomic, strong, nonnull) UIFont *unselectedItemTitleFont UI_APPEARANCE_SELECTOR;

/**
 Tint color to apply to the tab bar background.

 If nil, the receiver uses the default background appearance. Default: nil.
 */
@property(nonatomic, nullable) UIColor *barTintColor UI_APPEARANCE_SELECTOR;

/**
 Horizontal alignment of tabs within the tab bar. Changes are not animated. Default alignment is
 MDCTabBarAlignmentLeading.

 The default value is based on the position and is recommended for most applications.
 */
@property(nonatomic) MDCTabBarAlignment alignment;

/**
 Appearance of tabs within the tab bar. Changes are not animated.

 The default value is based on the position and is recommended for most applications.
 */
@property(nonatomic) MDCTabBarItemAppearance itemAppearance;

/**
 Indicates if all tab titles should be uppercased for display. If NO, item titles will be displayed
 verbatim.

 The default value is based on the position and is recommended for most applications.

 NOTE: This property will be deprecated in a future release. Use `titleTextTransform` instead.
 https://github.com/material-components/material-components-ios/issues/2552
 */
@property(nonatomic) IBInspectable BOOL displaysUppercaseTitles;

/**
 Defines how tab bar item titles are transformed for display.

 The default value is MDCTabBarTextTransformAutomatic.
 */
@property(nonatomic) MDCTabBarTextTransform titleTextTransform UI_APPEARANCE_SELECTOR;

/**
 Template that defines the appearance of the selection indicator.

 The default indicator template is a fixed-height rectangular bar under the selected tab.
 */
@property(nonatomic, null_resettable) id<MDCTabBarIndicatorTemplate> selectionIndicatorTemplate
    UI_APPEARANCE_SELECTOR;

/**
 Select an item with optional animation. Setting to nil will clear the selection.

 `selectedItem` must be nil or in `items`.
 */
- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated;

/** Updates the alignment with optional animation. */
- (void)setAlignment:(MDCTabBarAlignment)alignment animated:(BOOL)animated;

/**
 Sets the color of the title for the specified state.
 
 If the @c MDCTabBarItemState value is not set, then defaults to a default value. Therefore,
 at a minimum, you should set the value for MDCTabBarItemStateNormal.
 */
- (void)setTitleColor:(nullable UIColor *)color forState:(MDCTabBarItemState)state;

/** Returns the title color associated with the specified state. */
- (nullable UIColor *)titleColorForState:(MDCTabBarItemState)state;

/**
 Sets the tint color of the image for the specified state.

 If the @c MDCTabBarItemState value is not set, then defaults to a default value. Therefore,
 at a minimum, you should set the value for MDCTabBarItemStateNormal.
 */
- (void)setImageTintColor:(nullable UIColor *)color forState:(MDCTabBarItemState)state;

/** Returns the image tint color associated with the specified state. */
- (nullable UIColor *)imageTintColorForState:(MDCTabBarItemState)state;

@end

#pragma mark -

/** Accessibility-related methods on MDCTabBar. */
@interface MDCTabBar (MDCAccessibility)

/**
 Get the accessibility element representing the given item. Returns nil if item is not in `items`
 or if the item is not on screen.

 The accessibility element returned from this method may be used as the focused element after a
 run loop iteration.
 */
- (nullable id)accessibilityElementForItem:(nonnull UITabBarItem *)item;

@end

#pragma mark -

/**
 Delegate protocol for MDCTabBar. Clients may implement this protocol to receive notifications of
 selection changes in the tab bar or to determine the bar's position.
 */
@protocol MDCTabBarDelegate <UIBarPositioningDelegate>

@optional

/**
 Called before the selected item changes by user action. This method is not called for programmatic
 changes to the tab bar's selected item. Return YES to allow the selection.
 If you don't implement all items changes are allowed.
 */
- (BOOL)tabBar:(nonnull MDCTabBar *)tabBar shouldSelectItem:(nonnull UITabBarItem *)item;

/**
 Called before the selected item changes by user action. This method is not called for programmatic
 changes to the tab bar's selected item.  NOTE: Will be deprecated. Use tabBar:shouldSelectItem:.
 */
- (void)tabBar:(nonnull MDCTabBar *)tabBar willSelectItem:(nonnull UITabBarItem *)item;

/**
 Called when the selected item changes by user action. This method is not called for programmatic
 changes to the tab bar's selected item.
 */
- (void)tabBar:(nonnull MDCTabBar *)tabBar didSelectItem:(nonnull UITabBarItem *)item;

@end
