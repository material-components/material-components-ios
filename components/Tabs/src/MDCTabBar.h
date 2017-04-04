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

@class MDCTabBarConfiguration;

@class MDCTabBarItem;
@protocol MDCTabBarDelegate;

/**
 A material tab bar for switching between views of grouped content.

 Clients are responsible for responding to changes to the selected tab and updating the selected
 tab as necessary.

 Note: This class is not intended to be subclassed.

 @see https://www.google.com/design/spec/components/tabs.html
 */
IB_DESIGNABLE
@interface MDCTabBar : UIView

/** The default height for the tab bar given a configuration and item appearance. */
+ (CGFloat)defaultHeightForConfiguration:(nonnull MDCTabBarConfiguration *)configuration
                          itemAppearance:(MDCTabBarItemAppearance)appearance;

/** The default height for the tab bar given an item appearance and the default configuration. */
+ (CGFloat)defaultHeightForItemAppearance:(MDCTabBarItemAppearance)appearance;

/** Designated initializer. Creates a tab bar given a configuration. */
- (nonnull instancetype)initWithFrame:(CGRect)frame
                        configuration:(nonnull MDCTabBarConfiguration *)configuration
    NS_DESIGNATED_INITIALIZER;

/** Redeclaration of NSCoding designated initializer. */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/** The configuration provided at initialization. */
@property(nonatomic, readonly, copy, nonnull) MDCTabBarConfiguration *configuration;

/**
 Items displayed in the tab bar.

 If the new items do not contain the currently selected item, the selection will be reset to nil.
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
 Tint color for selected items. If nil, selected items will be tinted using the tab bar's
 inherited tintColor instead. Default: Opaque white.
 */
@property(nonatomic, nullable) UIColor *selectedItemTintColor UI_APPEARANCE_SELECTOR;

/** Tint color for unselected items. Default: Semi-transparent white. */
@property(nonatomic, nonnull) UIColor *unselectedItemTintColor UI_APPEARANCE_SELECTOR;

/** Ink color for taps on tab bar items. Default: Semi-transparent white. */
@property(nonatomic, nonnull) UIColor *inkColor UI_APPEARANCE_SELECTOR;

/**
 Tint color to apply to the tab bar background.

 If nil, the receiver uses the default background appearance. Default: nil.
 */
@property(nonatomic, nullable) UIColor *barTintColor UI_APPEARANCE_SELECTOR;

/**
 Horizontal alignment of tabs within the tab bar. Changes are not animated. Default alignment is
 MDCTabBarAlignmentLeading.

 The default value is based on the configuration. It's recommended to use the default if possible.
 */
@property(nonatomic) MDCTabBarAlignment alignment;

/**
 Appearance of tabs within the tab bar. Changes are not animated.

 The default value is based on the configuration. It's recommended to use the default if possible.
 */
@property(nonatomic) MDCTabBarItemAppearance itemAppearance;

/**
 Indicates if all tab titles should be uppercased for display. If NO, item titles will be
 displayed verbatim.

 The default value is based on the configuration. It's recommended to use the default if possible.
 */
@property(nonatomic) BOOL displaysUppercaseTitles;

/**
 Select an item with optional animation. Setting to nil will clear the selection.

 `selectedItem` must be nil or in `items`.
 */
- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated;

/** Updates the alignment with optional animation. */
- (void)setAlignment:(MDCTabBarAlignment)alignment animated:(BOOL)animated;

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
 selection changes in the tab bar.
 */
@protocol MDCTabBarDelegate <NSObject>

@optional

/**
 Called before the selected item changes by user action. This method is not called for programmatic
 changes to the tab bar's selected item.
 */
- (void)tabBar:(nonnull MDCTabBar *)tabBar willSelectItem:(nonnull UITabBarItem *)item;

/**
 Called when the selected item changes by user action. This method is not called for programmatic
 changes to the tab bar's selected item.
 */
- (void)tabBar:(nonnull MDCTabBar *)tabBar didSelectItem:(nonnull UITabBarItem *)item;

@end

/**
 Fixed configuration options for tab bars.

 The tab bar copies the configuration passed at initialization, so all configuration changes must
 be made before creating the tab bar. 
*/
@interface MDCTabBarConfiguration : NSObject <NSCopying>

/** Configuration which produces tabs appropriate for use above content. */
+ (nonnull instancetype)topTabsConfiguration;

/** Configuration which produces tabs appropriate for use as bottom navigation. */
+ (nonnull instancetype)bottomNavigationConfiguration;

/** Indicates if the tab bar shows items with uppercase titles by default. */
@property(nonatomic) BOOL displaysUppercaseTitlesByDefault;

/** Default tab bar alignment. */
@property(nonatomic) MDCTabBarAlignment defaultAlignment;

/** Default item appearance. */
@property(nonatomic) MDCTabBarItemAppearance defaultItemAppearance;

@end
