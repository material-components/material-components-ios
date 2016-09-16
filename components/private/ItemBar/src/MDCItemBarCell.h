#import <UIKit/UIKit.h>

@class MDCItemBarStyle;

/** View displaying an individual item in an item bar. */
@interface MDCItemBarCell : UICollectionViewCell

/** Updates the cell to use the given style properties. */
- (void)applyStyle:(MDCItemBarStyle *)itemStyle;

/** Updates the cell to display the given item. */
- (void)updateWithItem:(UITabBarItem *)item atIndex:(NSInteger)itemIndex count:(NSInteger)itemCount;

/** Returns the optimal size for the item with the given size class and content view object. */
+ (CGSize)sizeThatFits:(CGSize)size
    horizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass
                   item:(UITabBarItem *)item
                  style:(MDCItemBarStyle *)style;

/** Returns the additional insets applied outside item content for the given size class. */
+ (UIEdgeInsets)edgeInsetsForHorizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass;

@end
