#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MDCBottomNavigationBar;
@protocol MDCBottomNavigationBarDelegate;
@protocol MDCBottomNavigationBarControllerDelegate;

/**
 * MDCBottomNavigationBarController is a class that manages the navigation bar that allows movement
 * between primary destination in an app.  It ties a list of view controllers to the bottom
 * navigation bar and will display the corresponding view controller in the content view when an
 * in the navigation bar is selected.
 */
@interface MDCBottomNavigationBarController : UIViewController <MDCBottomNavigationBarDelegate>

/**
 * The bottom navigation bar that hosts the tab bar items.
 * @warning This controller sets itself as the navigation bar's delegate.  If you would like to
 * observe changes to the navigation bar, conform to \c MDCBottomNavigationBarControllerDelegate
 * and set the delegate property of this controller.
 */
@property(nonatomic, strong, readonly) MDCBottomNavigationBar *navigationBar;

/**
 * An array of view controllers to display when their corresponding tab bar item is selected in the
 * navigation bar.  When this property is set, the navigation bar's \c items property will be set to
 * an array composed of the \c tabBarItem property of each view controller in this array.
 * @see UIViewController#tabBarItem
 */
@property(nonatomic, copy) NSArray<UIViewController *> *viewControllers;

/**
 * The delegate to observe changes to the navigationBar.
 */
@property(nonatomic, weak, nullable) id<MDCBottomNavigationBarControllerDelegate> delegate;

/**
 * The current selected view controller.  When setting this property, the view controller must
 * be in \c viewControllers .
 */
@property(nonatomic, assign, nullable) UIViewController *selectedViewController;

/**
 * The index of the current selected tab item.  When setting this property the value must be in
 * bounds of \c viewcontrollers .
 * If no tab item is selected it will be set to NSNotFound.
 */
@property(nonatomic) NSUInteger selectedIndex;

- (void)viewDidLoad NS_REQUIRES_SUPER;

# pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(UITabBarItem *)item NS_REQUIRES_SUPER;

@end

/**
 * The protocol for delegates of the BottomNavigationBarController to conform to for updates on the
 * bottom navigation bar.
 */
@protocol VSPBottomNavigationBarViewControllerDelegate <MDCBottomNavigationBarDelegate>

@end

NS_ASSUME_NONNULL_END
