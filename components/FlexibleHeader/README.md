# Flexible header

The flexible header component is a container view whose height and vertical offset react to
UIScrollViewDelegate events.

## Installation with CocoaPods

To add the Flexible Header to your Xcode project using CocoaPods, add the following to your
`Podfile`:

    pod 'material-components-ios/FlexibleHeader'

Then, run the following command:

    $ pod install

## Design considerations

Most view controllers own their own header in a material app. These headers are flexible, provide
navigation information and actions, and often display high quality photography that complements the
underlying content. Flexible Header was designed with these expectations in mind.

This deviates from the typical UIKit convention of having a UINavigationController that owns and
manages a single UINavigationBar. The benefits of this deviation are:

- It is easier to build custom transitions from one view controller.
- Questions such as "what happens whe the header is 50pt tall and we push a view controller wanting
  a 20pt tall header?" are no longer part of the discussion. With UINavigationBar — or any shared
  navigation bar for that matter — resolving this leads to difficult architectural trade offs.

### What's inside

TODO(featherless): Discuss the three classes in this component, their relationship to one another,
and lead from this to the "Integration" section.

## Integration

TODO(featherless): Go over this section with an editing comb.

TODO(featherless): Discuss injection. Compare this to UITableViewController and how it federates
access to UITableView.

    @interface MyViewController () <MDCFlexibleHeaderParentViewController>

This protocol defines a flexible header view property which you will need to synthesize.

    @implementation MyViewController

    @synthesize headerViewController;

In order to populate the property, call the `addToParent:` method.

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
      self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
      if (self) {
        [MDCFlexibleHeaderViewController addToParent:self];
        ...

Within your viewDidLoad you can now create and initialize any subviews that you'd like to add to
your header view.

    - (void)viewDidLoad {
      [super viewDidLoad];
      ...

      // Create custom views here.
      UIView *myCustomView = [UIView new];
      myCustomView.frame = self.headerViewController.headerView.bounds;
      myCustomView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                       | UIViewAutoresizingFlexibleHeight);
      [self.headerViewController.headerView addSubview:myCustomView];

      [self.headerViewController addFlexibleHeaderViewToParentViewControllerView];
    }

Note that any views added to the flexible header view should set their autoresizing masks to
flexible width and height so that they expand/contract along with the header view.

TODO(featherless): Include "manual" example of using the standard UIKit APIs to add the
view/controller.

### A note on subclasses

A subclass of your view controller may add additional views in their viewDidLoad, potentially
resulting in the header being covered by the new views. It is the responsibility of the subclass to
take the z-index into account:

[self.view insertSubview:myCustomView belowSubview:self.headerViewController.headerView];

### Usage with UINavigationController**

You may use an instance of UINavigationController to push and pop view controllers that are managing
their own header view controller. UINavigationController does have its own navigation bar, so be
sure to set `navigationBarHidden` to YES either all the time (if all of your view controllers have
headers, or on the `viewWillAppear:` method).

Do **not** forget to do this if you support app state restoration, or your app will launch with
double navigation bars.

## Tracking a scroll view

In most situations you will want the header to track a UIScrollView's scrolling behavior. This
allows the header to expand, collapse, and shift off-screen.

To track a scroll view please follow these steps:

### Step 1: Set the tracking scroll view

In your viewDidLoad, set the `trackingScrollView` property on the header view:

    self.headerViewController.headerView.trackingScrollView = scrollView;

`scrollView` might be a table view, collection view, or a plain UIScrollView.

### Step 2: Forward scroll view delegate events to the header view

There are two ways to forward scroll events.

**Set headerViewController as the delegate**

You may use this approach if you do not need to implement any of the delegate's methods yourself
**and your scroll view is not a collection view**.

    scrollView.delegate = self.headerViewController;

**Forward the UIScrollViewDelegate methods to the header view**

If you need to implement any of the UIScrollViewDelegate methods yourself then you will need to
manually forward the following methods to the flexible header view.

    #pragma mark - UIScrollViewDelegate

    - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
      if (scrollView == self.headerViewController.headerView.trackingScrollView) {
        [self.headerViewController.headerView trackingScrollViewDidScroll];
      }
    }

    - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
      if (scrollView == self.headerViewController.headerView.trackingScrollView) {
        [self.headerViewController.headerView trackingScrollViewDidEndDecelerating];
      }
    }

    - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
      if (scrollView == self.headerViewController.headerView.trackingScrollView) {
        [self.headerViewController.headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
      }
    }

    - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                         withVelocity:(CGPoint)velocity
                  targetContentOffset:(inout CGPoint *)targetContentOffset {
      if (scrollView == self.headerViewController.headerView.trackingScrollView) {
        [self.headerViewController.headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                                                        targetContentOffset:targetContentOffset];
      }
    }

### Step 3: Implement prefersStatusBarHidden and query the flexible header view controller

In order to affect the status bar's visiblity you must query the header view controller.

    - (BOOL)prefersStatusBarHidden {
      return self.headerViewController.prefersStatusBarHidden;
    }
