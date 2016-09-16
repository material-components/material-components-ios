#import <UIKit/UIKit.h>

@class MDCItemBarStyle;

/** View displaying an individual item in an item bar. */
@interface MDCItemBarCell : UICollectionViewCell

/** Returns the optimal size for the item with the given size class and content view object. */
+ (CGSize)sizeThatFits:(CGSize)size
   horizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass
                  item:(nonnull UITabBarItem *)item
                 style:(nonnull MDCItemBarStyle *)style;

/** Returns the additional insets applied outside item content for the given size class. */
+ (UIEdgeInsets)edgeInsetsForHorizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass;

/** Title for the tab. Defaults to the empty string. */
@property(nonatomic, copy, nonnull) NSString *title;

/** Image shown on the tab. Defaults to nil. */
@property(nonatomic, strong, nullable) UIImage *image;

/** Text displayed in upper-right corner of the tab. Uses title color. */
@property(nonatomic, copy, nullable) NSString *badgeValue;

/** Updates the cell to use the given style properties. */
- (void)applyStyle:(nonnull MDCItemBarStyle *)itemStyle;

/** Updates the cell to display the given item. */
- (void)updateWithItem:(nonnull UITabBarItem *)item
               atIndex:(NSInteger)itemIndex
                 count:(NSInteger)itemCount;

@end
