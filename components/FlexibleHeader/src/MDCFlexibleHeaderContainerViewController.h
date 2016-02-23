#import <UIKit/UIKit.h>

@class MDCFlexibleHeaderViewController;

/**
 The MDCFlexibleHeaderContainerViewController controller is a straightforward container of a
 content view controller and a MDCFlexibleHeaderViewController.

 This view controller may be used in situations where the content view controller can't have a
 header injected into its view hierarchy. UIPageViewController is one such view controller.
 */
@interface MDCFlexibleHeaderContainerViewController : UIViewController

- (nonnull instancetype)initWithContentViewController:(nullable UIViewController *)contentViewController
    NS_DESIGNATED_INITIALIZER;

/**
 The header view controller owned by this container view controller.

 Created during initialization.
 */
@property(nonatomic, strong, nonnull, readonly) MDCFlexibleHeaderViewController *headerViewController;

/** The content view controller to be displayed behind the header. */
@property(nonatomic, strong, nullable) UIViewController *contentViewController;

/**
 Returns a Boolean indicating whether the status bar should be hidden or not.

 Must be called by the parent view controller's -prefersStatusBarHidden implementation.
 */
- (BOOL)prefersStatusBarHidden;

/** Calculates the status bar style based on the header view's background color. */
- (UIStatusBarStyle)preferredStatusBarStyle;

@end
