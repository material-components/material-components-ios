#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MDCBottomDrawerHeader;

/**
 * The transitioning delegate to use for presenting a view controller as a MDC bottom drawer.
 */
@interface MDCBottomDrawerTransitionController
    : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

/**
 * Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 * the drawer movement. This allows the provided scroll view to load the visible
 * content as the drawer moves, and therefore not load all the content at once and allow to reuse
 * the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

@end

NS_ASSUME_NONNULL_END
