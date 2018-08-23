#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The presentation controller to use for presenting an MDC bottom drawer.
 */
@interface MDCBottomDrawerPresentationController : UIPresentationController

/**
 * Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 * the drawer movement. This allows the provided scroll view to load the visible
 * content as the drawer moves, and therefore not load all the content at once and allow to reuse
 * the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

@end

NS_ASSUME_NONNULL_END
