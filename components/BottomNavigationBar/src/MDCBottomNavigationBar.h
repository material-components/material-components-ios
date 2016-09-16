#import <UIKit/UIKit.h>

/**
 A material bottom navigation bar, comparable to UITabBar.

 Clients are responsible for responding to changes to the selected tab and updating the selected
 tab as necessary.

 Note: This class is not intended to be subclassed.

 @see https://material.google.com/components/bottom-navigation.html
 */
IB_DESIGNABLE
@interface MDCBottomNavigationBar : UIView

/** Returns the default height in points for bottom navigation bars. */
+ (CGFloat)defaultHeight;

/**
 Items displayed in the bottom navigation bar.

 If the new items do not contain the currently selected item, the selection will be reset to the
 first item. Changes to this property are not animated.
 */
@property(nonatomic, copy, nonnull) NSArray<UITabBarItem *> *items;

/**
 The currently selected item. Setting to nil will clear the selection.

 Changes to `selectedItem` are not animated.
 */
@property(nonatomic, strong, nullable) UITabBarItem *selectedItem;

/**
 Select an item with optional animation. Setting to nil will clear the selection.

 `selectedItem` must be nil or in `items`.
 */
- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated;

/** The bottom navigation bar's delegate. */
@property(nonatomic, weak, nullable) id<MDCBottomNavigationBarDelegate> delegate;

/** Tint color for the navigation bar, which determines the color of the selected item. */
@property(nonatomic, null_resettable) UIColor *tintColor;

/** Tint color for unselected items. Default: light gray. */
@property(nonatomic, nonnull) UIColor *unselectedItemTintColor UI_APPEARANCE_SELECTOR;

/**
 Tint color to apply to the tab bar background.

 If nil, the receiver uses the default background appearance. Default: nil.
 */
@property(nonatomic, nullable) UIColor *barTintColor UI_APPEARANCE_SELECTOR;

@end

/**
 Delegate protocol for MDCBottomNavigationBar. Clients may implement this protocol to receive
 notifications of selection changes in the navigation bar.
 */
@protocol MDCNavigationBarDelegate <NSObject>

/**
 Called when the selected item changes by user action. This method is not called for programmatic
 changes to the bar's selected item.
 */
- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item;

@end
