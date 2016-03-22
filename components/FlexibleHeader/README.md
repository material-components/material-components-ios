---
title:  "Flexible Header"
layout: detail
section: documentation
---
# Flexible Header

The Flexible Header is a container view whose height and vertical offset react to
UIScrollViewDelegate events.
<!--{: .intro }-->

### Material Design Specifications

- [Scrolling Techniques](https://www.google.com/design/spec/patterns/scrolling-techniques.html)<!--{:target="_blank"}-->
<!--{: .icon-list }-->


### API Documentation

- [MDCFlexibleHeaderContainerViewController](/apidocs/FlexibleHeader/Classes/MDCFlexibleHeaderContainerViewController.html)<!--{:target="_blank"}-->
- [MDCFlexibleHeaderView](/apidocs/FlexibleHeader/Classes/MDCFlexibleHeaderView.html)<!--{:target="_blank"}-->
- [MDCFlexibleHeaderViewController](/apidocs/FlexibleHeader/Classes/MDCFlexibleHeaderViewController.html)<!--{:target="_blank"}-->
- [MDCFlexibleHeaderViewDelegate](/apidocs/FlexibleHeader/Protocols/MDCFlexibleHeaderViewDelegate.html)<!--{:target="_blank"}-->
- [MDCFlexibleHeaderViewLayoutDelegate](/apidocs/FlexibleHeader/Protocols/MDCFlexibleHeaderViewLayoutDelegate.html)<!--{:target="_blank"}-->
<!--{: .icon-list }-->


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/FlexibleHeader'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~

- - -

## Usage

Classic UIKit applications use the UINavigationBar provided by a UINavigationController to display
navigation stack-related information, such as a title, left and right bar button items, and
optionally a custom title view. In this case there is a single UINavigationBar shared amongst all of
the UINavigationController's children.

The Flexible Header component deviates from this pattern: UIViewControllers arre expected to own
their own Flexible Header view instance.

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



- - -

## Integration

### Step 1: Create an instance of a header view controller


~~~ objc
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
~~~


### Step 2: Add the header view to your view controller's view

~~~ objc
- (void)viewDidLoad {
  [super viewDidLoad];

  _fhvc.view.frame = self.view.bounds;
  [self.view addSubview:_fhvc.view];
  [_fhvc didMoveToParentViewController:self];
}
~~~


#### A note on subclasses

A subclass of your view controller may add additional views in their viewDidLoad, potentially
resulting in the header being covered by the new views. It is the responsibility of the subclass to
take the z-index into account:

~~~ objc
[self.view insertSubview:myCustomView belowSubview:self.headerViewController.headerView];
~~~

### Step 3: Forward relevant UIViewController APIs

Setting childViewControllerForStatusBarHidden allows the Flexible Header to control the status bar
visibility in reaction to scroll events.


~~~ objc
- (UIViewController *)childViewControllerForStatusBarHidden {
  return _fhvc;
}
~~~



- - -

## Usage with UINavigationController**

You may use an instance of UINavigationController to push and pop view controllers that are managing
their own header view controller. UINavigationController does have its own navigation bar, so be
sure to set `navigationBarHidden` to YES either all the time (if all of your view controllers have
headers, or on the `viewWillAppear:` method).

Do **not** forget to do this if you support app state restoration, or your app will launch with
double navigation bars.


- - -

## Tracking a scroll view

In most situations you will want the header to track a UIScrollView's scrolling behavior. This
allows the header to expand, collapse, and shift off-screen.

To track a scroll view please follow these steps:

### Step 1: Set the tracking scroll view

In your viewDidLoad, set the `trackingScrollView` property on the header view:


~~~ objc
self.headerViewController.headerView.trackingScrollView = scrollView;
~~~


`scrollView` might be a table view, collection view, or a plain UIScrollView.

### Step 2: Forward scroll view delegate events to the header view

There are two ways to forward scroll events.

**Set headerViewController as the delegate**

You may use this approach if you do not need to implement any of the delegate's methods yourself
**and your scroll view is not a collection view**.


~~~ objc
scrollView.delegate = self.headerViewController;
~~~


**Forward the UIScrollViewDelegate methods to the header view**

If you need to implement any of the UIScrollViewDelegate methods yourself then you will need to
manually forward the following methods to the flexible header view.


~~~ objc
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
~~~


### Step 3: Implement childViewControllerForStatusBarHidden

In order to affect the status bar's visibility you must query the header view controller.


~~~ objc
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.headerViewController;
}
~~~



