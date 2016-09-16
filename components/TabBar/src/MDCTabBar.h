#import <UIKit/UIKit.h>

#import "MDCTabBarAlignment.h"
#import "MDCTabBarItemAppearance.h"

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

/** Return the desired height for the tab bar given an item appearance. */
+ (CGFloat)defaultHeightForItemAppearance:(MDCTabBarItemAppearance)appearance;

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
@property(nonatomic, weak, nullable) id<MDCTabBarDelegate> delegate;

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
 */
@property(nonatomic) MDCTabBarAlignment alignment;

/**
 Appearance of tabs within the tab bar. Changes are not animated. Default appearance is
 MDCTabBarItemAppearanceTitles.
 */
@property(nonatomic) MDCTabBarItemAppearance itemAppearance;

/**
 Indicates if all tab titles should be uppercased for display. If NO, item titles will be
 displayed verbatim.

 Default is YES and is recommended whenever possible.
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
