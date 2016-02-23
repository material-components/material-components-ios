#import <UIKit/UIKit.h>

@class MDCFlexibleHeaderView;
@protocol MDCFlexibleHeaderViewLayoutDelegate;

/**
 The MDCFlexibleHeaderViewController controller is a simple UIViewController-oriented interface
 for the flexible header view.

 Note that for this view controller, self.view == self.headerView. This is because this view
 controller is not meant to take up the full screen. Rather, it should be added as a child view
 controller within another view controller.

 ### UIScrollViewDelegate

 Instances of this view controller implement the UIScrollViewDelegate methods that must be
 forwarded to the flexible header view, so if you do not need to process the scroll view events
 yourself you can set the header view controller instance as your scroll view delegate.

 scrollView.delegate = headerViewController;
 */
@interface MDCFlexibleHeaderViewController : UIViewController <UIScrollViewDelegate>

/** The flexible header view instance that this controller manages. */
@property(nonatomic, strong, nonnull, readonly) MDCFlexibleHeaderView *headerView;

/** The layout delegate will be notified of any changes to the flexible header view's frame. */
@property(nonatomic, weak, nullable) id<MDCFlexibleHeaderViewLayoutDelegate> layoutDelegate;

#pragma mark UIViewController methods

/**
 Returns a Boolean indicating whether the status bar should be hidden or not.

 Must be called by the parent view controller's -prefersStatusBarHidden implementation.
 */
- (BOOL)prefersStatusBarHidden;

/** Calculates the status bar style based on the header view's background color. */
- (UIStatusBarStyle)preferredStatusBarStyle;

/**
 Informs the flexible header view controller that its parent view controller's view has loaded.

 The flexible header view controller's view will be added as a subview to the associated parent
 view object.
 */
- (void)addFlexibleHeaderViewToParentViewControllerView;

@end

/**
 An object may conform to this protocol in order to receive layout change events caused by a
 MDCFlexibleHeaderView.
 */
@protocol MDCFlexibleHeaderViewLayoutDelegate <NSObject>
@required

/**
 Informs the receiver that the flexible header view's frame has changed.

 The receiver should use the MDCFlexibleHeader scrollPhase APIs in order to react to the frame
 changes.
 */
- (void)flexibleHeaderViewController:(nonnull MDCFlexibleHeaderViewController *)flexibleHeaderViewController
    flexibleHeaderViewFrameDidChange:(nonnull MDCFlexibleHeaderView *)flexibleHeaderView;

@end

#pragma mark Integration convenience

// Use the following process to easily integrate with the header component.
//
// 1. Conform to MDCFlexibleHeaderParentViewController on the view controller that should have a
//    header and synthesize the required property.
//    @synthesize headerViewController;
//
// 2. From your view controller's init- method, create the header view controller by calling:
//    [MDCFlexibleHeaderViewController addToParent:self];
//
// 3. At the end of your view controller's viewDidLoad call:
//    [self.headerViewController addFlexibleHeaderViewToParentViewControllerView];

/**
 A view controller may conform to this protocol in order to utilize the configureParent: helper
 method on MDCFlexibleHeaderViewController.
 */
@protocol MDCFlexibleHeaderParentViewController <NSObject>

/**
 The header view controller instance that was added as a child view controller to the receiver.
 */
@property(nonatomic, strong, nullable) MDCFlexibleHeaderViewController *headerViewController;

@end

@interface MDCFlexibleHeaderViewController (Installation)

/**
 Creates an instance of MDCFlexibleHeaderViewController, adds it as a child to the parent view
 controller, and assigns the instance to the headerViewController property.
 */
+ (void)addToParent:(nonnull id<MDCFlexibleHeaderParentViewController>)parent;

@end
