---
title:  "App Bar"
layout: detail
section: documentation
---
# App Bar

The App Bar is a flexible navigation bar designed to provide a typical Material navigation
experience.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/layout/structure.html#structure-app-bar">App Bar Structure</a></li>
  <li class="icon-link"><a href="https://www.google.com/design/spec/patterns/scrolling-techniques.html">Scrolling Techniques</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/apidocs/AppBar/Classes/MDCAppBarContainerViewController.html">MDCAppBarContainerViewController</a></li>
  <li class="icon-link"><a href="/apidocs/AppBar/Protocols/MDCAppBarParenting.html">MDCAppBarParenting</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
$ pod 'MaterialComponents/AppBar'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~

- - -

## Overview

The App Bar is a composite component that initializes and provides access to instances of the
following components:

- [Flexible Header](../FlexibleHeader)
- [Header Stack View](../HeaderStackView)
- [Navigation Bar](../NavigationBar)

The provided view hierarchy looks like so:

    <MDCFlexibleHeaderView>
       | <CALayer>
       |    | <MDCShadowLayer>
       | <UIView>
       |    | <MDCHeaderStackView>
       |    |    | <MDCNavigationBar>

This view hierarchy will be added to your view controller hierarchy using the convenience methods
outlined in the Usage docs below.

Note that it is possible to create each of the above components yourself, though we only encourage
doing so if the App Bar is limiting your ability to build something. In such a case we recommend
also [filing an issue](https://github.com/google/material-components-ios/issues/new) so that we can
identify whether your use case is something we can directly support.

## Usage

### Add the App Bar to a view controller

Each view controller in your app that intends to use an App Bar will follow these instructions.
You'll typically add the App Bar to the same view controllers that you'd push onto a
UINavigationController, hiding the UINavigationController's `navigationBar` accordingly.

The result of following these steps will be that:

1. an App Bar is registered as a child view controller of your view controller,
2. you have access to the App Bar's Flexible Header view via the headerViewController property, and
   that
3. you have access to the Navigation Bar and Header Stack View views via the corresponding
   properties.

- - -

Step 1: **Make your view controller conform to MDCAppBarParenting**.

Conforming to this protocol allows your view controller to hold a strong reference to the App Bar
properties. As we'll see in a moment, this allows the App Bar to configure your view controller with
helper methods.

<!--<div class="material-code-render" markdown="1">-->
### Objective-C

~~~ objc
@interface MyViewController () <MDCAppBarParenting>
@end
~~~

### Swift
~~~ swift
class MyViewController: UITableViewController, MDCAppBarParenting
~~~
<!--</div>-->

- - -

Step 2: **Synthesize the required properties of the MDCAppBarParenting protocol**.

<!--<div class="material-code-render" markdown="1">-->
### Objective-C

~~~ objc
@implementation MyViewController

@synthesize navigationBar;
@synthesize headerStackView;
@synthesize headerViewController;
~~~

### Swift
~~~ swift
  var headerStackView: MDCHeaderStackView?
  var navigationBar: MDCNavigationBar?
  var headerViewController: MDCFlexibleHeaderViewController?
~~~
<!--</div>-->

- - -

Step 3: **Initialize your view controller's App Bar**.

<!--<div class="material-code-render" markdown="1">-->
### Objective-C
~~~ objc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    MDCAppBarPrepareParent(self);
  }
  return self;
}
~~~

### Swift
~~~ swift
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    MDCAppBarPrepareParent(self)
~~~
<!--</div>-->

- - -

Step 4: **Inform the App Bar that your view controller's view has loaded**.

Ideally you will do this after all views have been added to your controller's view in order to
ensure that the App Bar's view is above all of your other views.

<!--<div class="material-code-render" markdown="1">-->
### Objective-C
~~~ objc
- (void)viewDidLoad {
  [super viewDidLoad];

  ...

  // After all other views have been registered.
  MDCAppBarAddViews(self);
}
~~~

### Swift
~~~ swift
  override func viewDidLoad() {
    super.viewDidLoad()

    // After all other views have been registered.
    MDCAppBarAddViews(self)
  }
~~~
<!--</div>-->

- - -

### App Bar + UINavigationController

When pushing view controllers that have App Bars onto UINavigationController you may notice that two
navigation bars are visible: the stock UINavigationBar and the App Bar's navigation bar. We
recommend hiding the UINavigationController's `navigationBar` whenever you're presenting a view
controller with an App Bar.

One way to do this is to change the navigation bar visibility during either `viewWillAppear:` or
`viewWillDisappear:`. This allows UINavigationController to animate the UINavigationBar in a
predictable fashion during pushes and pops.

<!--<div class="material-code-render" markdown="1">-->
### Objective-C
~~~ objc
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}
~~~

### Swift
~~~ swift
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
~~~
<!--</div>-->

Add the following to view controllers that don't have an app bar:

<!--<div class="material-code-render" markdown="1">-->
### Objective-C
~~~ objc
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:NO animated:animated];
}
~~~

### Swift
~~~ swift
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
~~~
<!--</div>-->

- - -

If all of your view controllers use the App Bar in a given UINavigationController then you can
simply hide the navigationBar when you create the navigation controller:

<!--<div class="material-code-render" markdown="1">-->
### Objective-C
~~~ objc
UINavigationController *navigationController = ...;
[navigationController setNavigationBarHidden:NO animated:NO];
~~~

### Swift
~~~ swift
self.navigationController?.setNavigationBarHidden(false, animated: false)
~~~
<!--</div>-->

- - -

### Status bar style

The MDCHeaderViewController class is able to recommend a status bar style by inspecting the
background color of the Flexible Header's view. If you'd like to use this logic to automatically
update your status bar style, implement `childViewControllerForStatusBarStyle` in your app's view
controller.

<!--<div class="material-code-render" markdown="1">-->
### Objective-C
~~~ objc
- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.headerViewController;
}
~~~

### Swift
~~~ swift
  override func childViewControllerForStatusBarStyle() -> UIViewController? {
    return self.headerViewController
  }
~~~
<!--</div>-->

- - -

### UINavigationItem and the App Bar

The App Bar's Navigation Bar registers KVO listeners on the parent view controller's
`navigationItem`. All of the typical properties including UIViewController's `title` property will
affect the Navigation Bar as you'd expect, with the following exceptions:

- None of the `animated:` method varients are supported because they do not implement KVO events.
  Use of these methods will result in the Navigation Bar becoming out of sync with the
  navigationItem properties.
- `prompt` is not presently supported. TODO(featherless): File issue.

TODO: Discuss adding background images.
TODO: Discuss touch event forwarding.

TODO: Discuss known limitiations. Discuss interactive background image (behind the stack view).
