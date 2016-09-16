#import <UIKit/UIKit.h>

#import "MDCItemBarAlignment.h"

@class MDCItemBarStyle;
@protocol MDCItemBarDelegate;

/**
 A horizontally-scrollable list of tab-like items.

 This is the private shared implementation of MDCTabBar and MDCBottomNavigationBar. It should not
 be used directly and is not guaranteed to have a stable API.
 */
@interface MDCItemBar : UIView

/** Return the default height for the item bar given a style. */
+ (CGFloat)defaultHeightForStyle:(nonnull MDCItemBarStyle *)style;

/**
 Items displayed in bar.

 If the new items do not contain the currently selected item, the selection will be reset to the
 first item. Changes to this property are not animated. May not be nil.
 */
@property(nonatomic, copy, nonnull) NSArray<UITabBarItem *> *items;

/**
 The currently selected item. May be nil if `items` is empty.

 Changes to `selectedItem` are not animated.
 */
@property(nonatomic, strong, nullable) UITabBarItem *selectedItem;

/** The item bar's delegate. */
@property(nonatomic, weak, nullable) id<MDCItemBarDelegate> delegate;

/**
 Select an item with optional animation. Raises an NSInvalidArgumentException if selectedItem is
 not in `items`.
 */
- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated;

/**
 Horizontal alignment of items. Changes are not animated. Default alignment is
 MDCItemBarAlignmentLeading.
 */
@property(nonatomic) MDCItemBarAlignment alignment;

/** Updates the alignment with optional animation. */
- (void)setAlignment:(MDCItemBarAlignment)alignment animated:(BOOL)animated;

#pragma mark - Styling

/** Updates the bar to use the given style properties. */
- (void)applyStyle:(nonnull MDCItemBarStyle *)itemStyle;

@end

/**
 Delegate protocol for MDCItemBar. Clients may implement this protocol to receive notifications of
 selection changes.
 */
@protocol MDCItemBarDelegate <NSObject>

/**
 Called before the selected item changes by user action. This method is not called for programmatic
 changes to the bar's selected item.
 */
- (void)itemBar:(nonnull MDCItemBar *)itemBar willSelectItem:(nonnull UITabBarItem *)item;

/**
 Called when the selected item changes by user action. This method is not called for programmatic
 changes to the bar's selected item.
 */
- (void)itemBar:(nonnull MDCItemBar *)itemBar didSelectItem:(nonnull UITabBarItem *)item;

@end

#pragma mark -

/** Accessibility-related methods on MDCItemBar. */
@interface MDCItemBar (MDCItemBarAccessibility)

/**
 * Get the accessibility element representing the given item. Returns nil if item is not in `items`
 * or if the item is not on screen.
 *
 * The accessibility element returned from this method may be used as the focused element after a
 * run loop iteration.
 */
- (nullable id)accessibilityElementForItem:(nonnull UITabBarItem *)item;

@end
