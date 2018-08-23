NS_ASSUME_NONNULL_BEGIN

@protocol MDCBottomDrawerHeader;

/**
 * View controller for containing a Google Material bottom drawer.
 */
@interface MDCBottomDrawerViewController : UIViewController

/**
 * The main content displayed by the drawer.
 * Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController *mainContentViewController;

/**
 * A header to display above the drawer's main content.
 * Its height is determined by the returned preferred content size.
 */
@property(nonatomic, nullable) UIViewController<MDCBottomDrawerHeader> *headerViewController;

/**
 * Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 * the drawer movement. This allows the provided scroll view to load the visible
 * content as the drawer moves, and therefore not load all the content at once and allow to reuse
 * the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

@end

NS_ASSUME_NONNULL_END
