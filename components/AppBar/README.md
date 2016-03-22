---
title:  "App Bar"
layout: detail
section: documentation
---
# App Bar

The App Bar is a flexible navigation bar-like component designed to provide a typical Material
navigation experience.

Learn more at the
[Material spec](https://www.google.com/design/spec/patterns/scrolling-techniques.html).
<!--{: .intro :}-->

### Design Specifications

- [App Bar Structure](https://www.google.com/design/spec/layout/structure.html#structure-app-bar)
- [Scrolling Techniques](https://www.google.com/design/spec/patterns/scrolling-techniques.html)
<!--{: .icon-list }-->

### API Documentation

- [MDCAppBarContainerViewController](/apidocs/AppBar/Classes/MDCAppBarContainerViewController.html)
- [MDCAppBarParenting](/apidocs/AppBar/Protocols/MDCAppBarParenting.html)
<!--{: .icon-list }-->



- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/AppBar'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~



- - -

## Integration

### Add the App Bar to a view controller

The result of following these steps is that the App Bar will be added as a child view controller on
your app's view controller.

Step 1: Make your view controller conform to MDCAppBarParenting.

> You'll typically add the App Bar to the same view controller that you'd push onto a
> UINavigationController.

Conforming to this protocol allows your view controller to hold a strong reference to the App Bar
properties. As we'll see in a moment, this allows the App Bar to configure your view controller with
helper methods.

~~~ objc
@interface MyViewController () <MDCAppBarParenting>
@end
~~~

Step 2: Synthesize the required properties of the MDCAppBarParenting protocol.

~~~ objc
@implementation MyViewController

@synthesize navigationBar;
@synthesize headerStackView;
@synthesize headerViewController;
~~~

Step 3: At the earliest possible moment — usually an init method - initialize your view
controller's App Bar.

~~~ objc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    MDCAppBarPrepareParent(self);
  }
  return self;
}
~~~

Step 4: Inform the App Bar that your view controller's view has loaded. Ideally you will do this
last in order to ensure that the App Bar's view is above all of your other views.

~~~ objc
- (void)viewDidLoad {
  [super viewDidLoad];

  ...

  MDCAppBarAddViews(self);
}
~~~

### App Bar + UINavigationController

If you present a view controller with an App Bar as part of a UINavigationController you'll notice
that two "bars" are now appearing: the stock UINavigationBar and the App Bar's bars. To avoid this,
we recommend hiding the UINavigationController's navigationBar whenever you're presenting a view
controller with an App Bar.

One way to do this is to add the following to the `viewWillAppear:` of any view controller that
has an App Bar:

~~~ objc
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}
~~~

And to add the following to view controllers that don't have an app bar:

~~~ objc
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:NO animated:animated];
}
~~~

If all of your view controllers use the App Bar in a given UINavigationController then you can
simply hide the navigationBar when you create the navigation controller:

~~~ objc
UINavigationController *navigationController = ...;
[navigationController setNavigationBarHidden:NO animated:NO];
~~~

## Usage

TODO: Discuss navigationItem integration.
TODO: Discuss adding background images.
TODO: Discuss touch event forwarding.
