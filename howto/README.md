---
title:  "Material Components Development Guide"
layout: landing
section: howto
---

# Material Components Development Guide

Material Components for iOS is a set of components that help iOS app developers build Material Design apps. These are the same components Google uses to build apps like Google Maps, Calendar, Chrome and many more.

Individually, the components bring Material Design principles to common UI elements and behaviors, but tailored for iOS. Our team has taken care to design the APIs to feel natural on iOS.

Our goal is to make implementing Material Design as easy as possible. The components are easy to assemble and be used piecemeal.

This tutorial will take you through building an example app called Abstractor and show some of the neat features and benefits of using our components to build your app. In order to get through this tutorial, Swift and iOS development knowledge is required.


- - -

## Getting Started

### Tutorial Setup

Material Components for iOS can be integrated like any other shared code library on iOS. The preferred method of integration is through CocoaPods.

To help get started quickly, `git clone` this skeleton new project which the rest of the tutorial will use.

~~~ bash
git clone https://github.com/google/material-components-ios-example/
~~~

This project is similar to a new project created using Xcode's new project template except with a small number of changes:

1. Removes the Main.storyboard and references to it in favor of programmatically creating the UI.
2. Adds a bridging header (BridgingHeader.h) and the Xcode configuration for it.
3. Adds a simple String class extension for creating sample text.
4. Adds two icons (search and add) from [Material Icons](https://github.io/google/material-icons)
5. Creates a new MainViewController.swift.

#### CocoaPods

The first step is to add Material Components through CocoaPods. The [Material Components quickstart](https://materialcomponents.org/) has detailed instructions, but in short, create a Podfile in the root of the example with the following contents:

~~~ ruby
target 'Abstractor' do
  pod 'MaterialComponents'
end
~~~

Run `pod install` in that directory and open up `Abstractor.xcworkspace`.

#### Bridging for Swift

Material Components is written in Objective-C and is completely usable from Swift. In order to make the classes visible to Swift, the headers need to be added to the `BridgingHeaders.h`. Open up `BridgingHeaders.h` and add the following lines.


~~~ objc
#import "MaterialAppBar.h"
#import "MaterialButtons.h"
#import "MaterialCollections.h"
#import "MaterialFlexibleHeader.h"
~~~

#### Building and running the app

The Abstractor project should be now set up and ready to run. Building and running the project should show you a fairly boring app with a yellow background with no contents. That is our skeleton project the rest of the tutorial will use.

**TODO: Insert image of the app.**


- - -

## Material Headers

Headers exist in nearly all apps we see to provide framing and navigation. The header and scrolling behavior is well defined in the [Material Design Guidelines](https://www.google.com/design/spec/TODO) but it is tricky to get right.

Material Components for iOS provides both a higher level and lower level implementation that allow developers to easily customize the right behavior for the view controller they are building. Both implementations provide a responsive header that can expand and contract in response to scrolling behaviors to maximize the content area or show high level information to the user.

The [App Bar](https://materialcomponents.org/components/appbar/) is the first way to implement a response header. It uses the familiar UINavigationItem properties of a UIViewController to derive the contents of the header view.

The [Flexible Header](https://materialcomponents.org/components/flexible-header/) is the second way to implement the responsive header. This component is what the App Bar is built on and is perfect if the developer would like fine grained control over it's contents and behavior. For example, the flexible header can contain a fully custom view that would respond to size changes as the user scrolled.

If you are used to UINavigationController's UINavigationBar, the fundamental different in design is that your UIViewController has the actual header bar in it's view hierarchy. This contrasts with UINavigationBar being part of UINavigationController's view hierarchy. The different view hierarchy allows gives developers more flexibility when animating between view controllers or customizing unique behaviors when the size of the header changes.

- - -

## Starting with App Bar

In the Abstractor project, there is a view controller already created called MainViewController. To start, we will add a scroll view to the MainViewController since the AppBar works best with a scroll view.

Modify the MainViewController.swift by adding a UIScrollView. Make the following changes to the MainViewController:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController {
  var scrollView: UIScrollView?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Create and initialize a blank scroll view.
    scrollView = UIScrollView(frame: view.bounds)
    scrollView!.contentSize = CGSize(width: view.bounds.size.width, height: 1000)
    scrollView!.backgroundColor = UIColor.whiteColor()
    view.addSubview(scrollView!)
  }
}
~~~
<!--</div>-->

This snippet is basic UIKit code to create a scroll view, setting the size of the scroll view to be at least 1000 points tall so it will scroll further off screen.

To actually add the App Bar, we need to give the view controller a protocol to conform to, and override the initializers:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController, MDCAppBarParenting {
  var scrollView: UIScrollView?

  // -- start MDCAppBarParenting
  var headerStackView: MDCHeaderStackView?
  var navigationBar: MDCNavigationBar?
  var headerViewController: MDCFlexibleHeaderViewController?

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    MDCAppBarPrepareParent(self)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    MDCAppBarPrepareParent(self)
  }
  // -- end MDCAppBarParenting

  override func viewDidLoad() {
    super.viewDidLoad()

    // Create and initialize a blank scroll view.
    scrollView = UIScrollView(frame: view.bounds)
    scrollView!.contentSize = CGSize(width: view.bounds.size.width, height: 1000)
    scrollView!.backgroundColor = UIColor.whiteColor()
    view.addSubview(scrollView!)

    // -- start MDCAppBarParenting
    MDCAppBarAddViews(self)
    // -- end MDCAppBarParenting
  }
}

~~~
<!--</div>-->


At this point, the app will add a grey header bar at the top of the view, but the scroll view will live under the header bar. You can observe this by scrolling the the view and seeing the scroll indicator go below the grey header bar.

**TODO: Add image of the grey header**

The MDCFlexibleHeaderViewController that was now exposed as a property of our view controller doesn't know about the scroll view and therefore it cannot adjust any scroll view insets the scroll view needs to render below the bar. To rectify this, simply tell the headerView in the MDCFlexibleHeaderViewController about the scroll view in viewDidLoad():

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController, MDCAppBarParenting {
  // ...
  override func viewDidLoad() {
    // ...

    // Connect scroll view with the header view controller.
    headerViewController?.headerView.trackingScrollView = contentScrollView
    headerViewController?.headerView.behavior = .EnabledWithStatusBar
    scrollView.delegate = headerViewController

  }
~~~
<!--</div>-->


Now the scroll view correctly aligns to the bottom of the header bar. Notice that `headerView` had a property called `behavior` which is set to EnabledWithStatusBar. This behavior controls how the header view reacts to scrolling. When `Enabled`, the header will collapse to maximize the content area. Developers can choose whether the status bar should also be hidden.

**TODO: Add animation of the grey header collapsing.**

The status bar is not hiding yet, and the reason is by default UIViewController does not hide the status bar. In order for  `headerViewController` to assume control of the status bar, override the method `childViewControllerForStatusBarHidden` to use the headerViewController as the childViewController (see the FlexibleHeader component documentation for more details):

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController, MDCAppBarParenting {
  // ...
  override func childViewControllerForStatusBarHidden() -> UIViewController {
    return headerViewController!
  }
}
~~~
<!--</div>-->


**TODO: Add animation of the status bar correctly collapsing.**

To complete the integration, let's set a proper color and some items on to the header bar.

To set the color of the header, we can directly manipulate the headerView in viewDidLoad:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController, MDCAppBarParenting {
  // ...
  override func viewDidLoad() {
    // ...

    // Set color using UIColor extension in UIColorAbstractor.swift
    headerViewController!.headerView.backgroundColor = UIColor.materialOrange700()
    headerViewController!.headerView.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.87)
  }

  // Set the status bar to white.
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}
~~~
<!--</div>-->


And finally put some buttons in to the header bar.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController, MDCAppBarParenting {
  override func viewDidLoad() {
    // ...

    // Set up UINavigationItems
    navigationItem.title = "Abstractor".blackout()
       navigationItem.rightBarButtonItem = UIBarButtonItem(
         image: UIImage(named: "ic_search")?.imageWithRenderingMode(.AlwaysTemplate),
         style: .Plain,
         target: self,
         action: #selector(MainViewController.search(_:)))

     // Last step in viewDidLoad
     MDCAppBarAddViews(self)
  }

  // Implement the callback method for the search button.
  func search(target: AnyObject) {
  }
}
~~~
<!--</div>-->


And there you have a responsive header that reacts to the scroll view and collapses to maximize
the content.

- - -

## Flexible Header

One advantage of the App Bar component is it's compatibility with UINavigationItem. If developers would like to customize the actual contents inside the header, they need to look at  the powerful Flexible Header component.

Observant developers would already have noticed that App Bar uses Flexible Header to create the behavior. Imagine instead that we would like to lock the title to the bottom of the header but keep search button attached to the top.



### Create a custom header view

The first thing to do is to create a custom view that will be placed inside the FlexibleHeader. This can be in conjunction with the App Bar or completed without. Notice in the previous steps, another property we added is the `MDCNavigationBar` that provides the logic to layout the single line button bar.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class CustomHeaderView : UIView {
  var titleLabel = UILabel()
  var iconView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let icon = UIImage(named: "ic_search")!.imageWithRenderingMode(.AlwaysTemplate)
    iconView.image = icon
    iconView.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
    titleLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)

    self.addSubview(iconView)
    self.addSubview(titleLabel)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    // not implementated
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    // Some fancying arithmetic : TODO replace with autolayout
    titleLabel.frame = CGRect(x: 16, y: self.bounds.size.height - 40, width: 128, height: 24)
    iconView.frame = CGRect(x: self.bounds.size.width - 24 - 16, y: 20 + 16, width: 24, height: 24)
  }
}
~~~
<!--</div>-->


This header view creates a similar view as the one in the App Bar, for simplicity, but the layoutSubviews
logic locks the titleLabel to the bottom of the header while the iconView stays locks to the top right.

### Adding Flexible Header

Integrating the Flexible Header is about the same amount of work as App Bar:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : UIViewController, MDCFlexibleHeaderViewLayoutDelegate {
  var headerViewController: MDCFlexibleHeaderViewController
  var customHeaderView = CustomHeaderView()

  //...
}
~~~
<!--</div>-->


Override the initialize to add the MDCFlexibleHeaderViewController to the view controller
as a childViewController replacing the previous `MDCAppBArPrepareParent`:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
   headerViewController = MDCFlexibleHeaderViewController()
   super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
   self.addChildViewController(headerViewController)
 }

 required init?(coder aDecoder: NSCoder) {
   headerViewController = MDCFlexibleHeaderViewController()
   super.init(coder: aDecoder)
   self.addChildViewController(headerViewController)
 }
~~~
<!--</div>-->


Initialize the customHeaderView and connect the headerViewController's headerView to
the UIViewController's hierarchy. This replaces `MDCAppBarAddViews` was doing
except this is not creating any observing of the UINavigationItem.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
override func viewDidLoad() {
  super.viewDidLoad()

  // ...

  // Remove setting up UINavigationItem and MDCAppBarAddViews(self).

  // Initialize the customHeaderView
  var headerViewInitialFrame = headerViewController.headerView.contentView!.bounds
  headerViewInitialFrame.size.height = 56 + 20
  customHeaderView.frame = headerViewInitialFrame
  headerViewController.headerView.contentView?.addSubview(customHeaderView)

  // Connect headerViewController to this viewController's view hierarchy
  view.addSubview(headerViewController!.headerView)
  headerViewController.didMoveToParentViewController(self)
  headerViewController.layoutDelegate = self

}
~~~
<!--</div>-->


One final thing that is added is to add this viewController as the layoutDelegate. This allows
us to listen for events when the header is resized. And we can implement a very simple way to
update the header view contents when the layout is changed.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
// MDCFlexibleHeaderViewLayoutDelegate
 func flexibleHeaderViewController(flexibleHeaderViewController: MDCFlexibleHeaderViewController,
                                   flexibleHeaderViewFrameDidChange headerView: MDCFlexibleHeaderView) {
   customHeaderView.frame = headerView.contentView!.bounds
 }
~~~
<!--</div>-->





- - -

## Material Collection Views

In previous examples, we used a scroll view rather than any content. In Material Components, there
is a sophisticated collection view addition that we've added which implements many of the Material
design styled layout and transitions.

In order for styling to be done in a compartmentalized way, MDCCollectionViewController has an
abstraction called MDCCollectionViewModel. The model is an implementation of the
UICollectionViewDataSource. The model implements storage for a model objects that contain the
data for rendering the cells.


Apps can use the MDCCollectionViewController without the model API and still get the same styling,
but there is more plumbing that needs to be implemented. In some cases, working without the model
API is required if more fine grained control is required.

The following steps will use the MDCCollectionViewModel to build up a simple collection view

### Using the MDCCollectionViewController

MDCCollectionViewController is a subclass of the UICollectionViewController and can be used in place
of a UIViewController base class. Using this is the easiest way to get started with Material collection views.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
class MainViewController : MDCCollectionViewController, MDCAppBarParenting {

}
~~~
<!--</div>-->


The collection view will replace the scroll view that was in the App Bar example earlier. In place of
the scroll view, a model is initialized:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
override func viewDidLoad() {
  super.viewDidLoad()

  // Remove initialization of the scrollView.

  // Initialize the collection view.
  let thisCollectionView = collectionView as UICollectionView!
  thisCollectionView.mdc_styleController.cellStyle = .Grouped
  thisCollectionView.frame = view.bounds
  thisCollectionView.delegate = self
  view.addSubview(collectionView!)

  // Setup the collection view as the scroll view for the App Bar header to track.
  headerViewController?.headerView.trackingScrollView = thisCollectionView

  // Setup the model.
  model = MDCCollectionViewModel(delegate: self)
  model.setHeader(MDCCellModel.objectWithHeader("Inbox".blackout()), forSection: 0)
  // Add 100 rows.
  for 0..100 {
    model.addItem(MDCCellModel.objectWithTitle("Hello there".blackout()), toSection: 0)
  }

  // ...
  MDCAppBarAddViews(self)
}
~~~
<!--</div>-->


Unlike with the simple example with the App Bar above, the UICollectionViewController is the
delegate for the UICollectionView, we cannot just do a simple delegate assignment like we did
with the App Bar to forward scroll view events.

Instead, we need to manually forward four additional UIScrollViewDelegate methods to
the MDCFlexibleHeaderView to preserve our collapsing header functionality.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift

  override func childViewControllerForStatusBarHidden() -> UIViewController {
    return headerViewController!
  }

  // UIScrollViewDelegate
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    headerViewController?.headerView.trackingScrollViewDidScroll()
  }

  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    headerViewController?.headerView.trackingScrollViewDidEndDecelerating()
  }

  override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    headerViewController?.headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
  }

  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    headerViewController?.headerView.trackingScrollViewWillEndDraggingWithVelocity(velocity, targetContentOffset: targetContentOffset)
  }
~~~
<!--</div>-->


If these are omitted, the header will continue to work, but there will not be any collapsing and expanding behavior.

If you prefer to use not use the model, see the Material Collection View component documentation for
more detail. This component also handles editing and moving of rows, which is also covered in the component documentation.

### Handling taps on a row

The final step is to handle taps on a row. It is very similar to the normal UICollectionViewDelegate
way of doing things

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
  super.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
  let vc = ViewControllerWithCollections(nibName: nil, bundle: nil)
  self.navigationController?.pushViewController(vc, animated: true)
}
~~~
<!--</div>-->


### Bonus: Custom cells

[TODO]


- - -

## Material Buttons

Material Components has several styled buttons depending on where they are placed. For Floating Action Buttons (spec),
the Material Buttons component has a class called MDCShapedButton that allows for creating a simple
rounded button that contains an icon.

To add this to the Abstract app, the button should be initialized at viewDidLoad and then
added to the view controller's root view so it stays floated in the corner.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
override func viewDidLoad() {

  button = MDCFloatingButton(shape: .Default)
  button!.sizeToFit()
  var buttonFrame = button!.frame
  buttonFrame.origin.x = view.bounds.size.width - buttonFrame.size.width - 24
  buttonFrame.origin.y = view.bounds.size.height - buttonFrame.size.height - 24
  button!.setBackgroundColor(UIColor(red: 1.0, green: 0.562, blue: 0, alpha:1.0), forState: .Normal)
  button!.frame = buttonFrame
  button!.setImage(UIImage(named: "ic_add")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
  button!.tintColor = UIColor.whiteColor()
  button!.alpha = 0
  button!.addTarget(self,
                    action: #selector(ViewControllerWithCollections.add(_:)),
                    forControlEvents: .TouchUpInside)
}

override func viewDidAppear {
  super.viewDidAppear()
  weak var weakButton = button
  UIView.animateWithDuration(0.2, animations: {
    weakButton!.alpha = 1
  })
}

~~~
<!--</div>-->


When the floating action button is tapped on, the `add:` selector is called and it will add a
row to the collection view. Collection views can animate any changes using MDCCollectionViewModel.performBatchOperations

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
func add(target: AnyObject) {
  weak var weakModel = model
  model.performBatchUpdates({
    weakModel?.insertItem(
      MDCCellModel.objectWithTitle("I got added".blackout(),
      subtitle: "More text".blackout()),
      atIndexPath: NSIndexPath(forRow: 0, inSection: 0))
    },
    withCollectionView: collectionView,
    completion: nil)
}
~~~
<!--</div>-->



- - -

## Bonus : Proper view controller transitions

One odd artifact with this app is the floating action button animates with the rest of the view
controller. The intention of the design is it floats on top of all the views, but for convenience
we've added it to the view controller.

Rather, when a view controller transition happens, the floating action button should be removed
from the view hierarchy and animated in when the view controller appears.

Fading in to the view controller:

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
 override func viewDidAppear(animated: Bool) {
   weak var weakButton = button
   UIView.animateWithDuration(0.2, animations: {
     weakButton!.alpha = 1
   })
 }
~~~
<!--</div>-->


Fading out when the view controller changes, replace the `collectionView:didSelectItemAtIndexPath`
to pushViewController with an animation to FAB.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

~~~ swift
override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
  super.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
  let vc = ViewControllerWithCollections(nibName: nil, bundle: nil)

  weak var weakButton = button
  weak var weakSelf = self
  UIView.animateWithDuration(0.2, animations: {
    weakButton!.alpha = 0
    }) { (completed) in
      weakSelf?.navigationController?.pushViewController(vc, animated: true)
  }
}

~~~
<!--</div>-->


- - -

## Next steps

This tutorial has taken you through implementing a basic Material Design style app with some of our
components. There are a lot more components that are not covered which are covered in our component
documentation.

Also see our examples and catalog apps that are in the project to show how to use some of the more
advanced features.


- [Read the Component Documentation](/components/)
  <!--{: .icon-components }-->

- [Stack Overflow "material-components-ios"](http://stackoverflow.com/questions/tagged/material-components-ios)
  <!--{: .icon-stackoverflow }-->
<!--{: .icon-list }-->

- - -

## Sample Code

- [**Pesto**
  A simple recipe app, incorporating a flexible header, floating action button, and collections.
  ](https://github.com/google/material-components-ios/tree/master/demos/Pesto)
  <!--{: .icon-pesto }-->

- [**Shrine**
  A demo shopping app, incorporating a flexible header, custom typography, and collections.
  ](https://github.com/google/material-components-ios/tree/master/demos/Shrine)
  <!--{: .icon-shrine }-->
<!--{: .icon-list .large-format }-->
