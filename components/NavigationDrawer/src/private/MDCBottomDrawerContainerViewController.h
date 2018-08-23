#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MDCBottomDrawerHeader;

/**
 * View controller for containing a Google Material bottom drawer. Used internally only.
 */
@interface MDCBottomDrawerContainerViewController : UIViewController <UIGestureRecognizerDelegate>

/**
 * Designated initializer.
 *
 * @param originalPresentingViewController The original presenting view controller.
 */
- (instancetype)initWithOriginalPresentingViewController:
                    (UIViewController *)originalPresentingViewController
                                      trackingScrollView:(UIScrollView *)trackingScrollView
    NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

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

/** The original presenting view controller. */
@property(nonatomic, readonly) UIViewController *originalPresentingViewController;

/**
 * Setting the tracking scroll view allows the drawer scroll the content seamlessly as part of
 * the drawer movement. This allows the provided scroll view to load the visible
 * content as the drawer moves, and therefore not load all the content at once and allow to reuse
 * the cells when using a UICollectionView or UITableView.
 */
@property(nonatomic, weak, nullable) UIScrollView *trackingScrollView;

/** Whether the drawer is currently animating its presentation. */
@property(nonatomic) BOOL animatingPresentation;

@end

NS_ASSUME_NONNULL_END
