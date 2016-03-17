---
layout: post
title:  "Flexible header"
date:   2016-03-01 20:15:01 -0500
categories: documentation
---
# Flexible header

The flexible header component is a container view whose height and vertical offset react to
UIScrollViewDelegate events.

## Installation with CocoaPods

To add the Flexible Header to your Xcode project using CocoaPods, add the following to your
`Podfile`:

    pod 'MaterialComponents/FlexibleHeader'

Then, run the following command:

    $ pod install

## Software design considerations

Classic UIKit applications use the UINavigationBar provided by a UINavigationController to display
navigation stack-related information, such as a title, left and right bar button items, and
optionally a custom title view. There is a singular UINavigationBar shared amongst all of the
UINavigationController's children.

The Flexible Header component deviates from this pattern: each UIViewController is expected to own
its own Flexible Header view instance.

This has several technical advantages:

- Allows transitions between two view controllers to own the navigation bar transition as well.
- Each view controller is distinctly responsible for its customizations of the Flexible Header.

It also has some technical disadvantages:

- View controllers that do not use features of the Flexible Header will find it a burden to
  implement the same scaffolding each time.

### Easing the common case

TODO(featherless): Discuss UINavigationControllerDelegate solution.
TODO(featherless): Discuss subclassing solution.
TODO(featherless): Discuss configurator API solution.

### What's inside

TODO(featherless): Discuss the three classes in this component, their relationship to one another,
and lead from this to the "Integration" section.

## Integration

### Step 1: Create an instance of a header view controller

    @implementation FlexibleHeaderTypicalUseViewController {
      MDCFlexibleHeaderViewController *_fhvc;
    }

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
      self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
      if (self) {
        _fhvc = [MDCFlexibleHeaderViewController new];
        [self addChildViewController:_fhvc];
      }
      return self;
    }

### Step 2: Add the header view to your view controller's view

    - (void)viewDidLoad {
      [super viewDidLoad];

      _fhvc.view.frame = self.view.bounds;
      [self.view addSubview:_fhvc.view];
      [_fhvc didMoveToParentViewController:self];
    }

#### A note on subclasses

A subclass of your view controller may add additional views in their viewDidLoad, potentially
resulting in the header being covered by the new views. It is the responsibility of the subclass to
take the z-index into account:

[self.view insertSubview:myCustomView belowSubview:self.headerViewController.headerView];

### Step 3: Forward relevant UIViewController APIs

Setting childViewControllerForStatusBarHidden allows the Flexible Header to control the status bar
visibility in reaction to scroll events.

    - (UIViewController *)childViewControllerForStatusBarHidden {
      return _fhvc;
    }

## Usage with UINavigationController**

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
