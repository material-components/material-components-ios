---
title:  "How To Use Material Components"
layout: landing
section: howto
---

# Using Material Components

Lorem. Introduction to our howtos, guides, and samples. Need to pick the right links to go below here.

TODO: Copy for above paragraph.

TODO: Choose links below.

- [Development Guide](http://www.google.com)
  {: .icon-guide }

- [API Documentation](http://www.google.com)
  {: .icon-api }

- [Code Samples](http://www.google.com)
  {: .icon-sample }

- [Stack Overflow](http://www.google.com)
  {: .icon-stackoverflow }
{: .icon-list }

- - -


## Creating a Material design iOS app

This guide will take you through the steps of creating your first Material design iOS app
and give you a starting point for using our flexible headers and collection views.

In this tutorial, we'll create a fake app called Abstract which brings together the main
components available in the material design components such as the app bar, flexible header,
buttons and collection view.

### Setting up a new project

#### Create a new project

Create a new Xcode project and initialize CocoaPods for this project. For more information, see Quickstart on details.

(Maybe we can let them clone an existing set up project?)

#### Swift initialization

For Swift based projects, because Material Components is in Objective-C, a bridging header needs
to be created and referenced.

Create a file called "BridgingHeaders.h" and reference this in the Xcode project configuration.

[TODO: Add image of where this is in the Xcode project configuration]

In the file, add the following lines.

```
#import "MaterialFlexibleHeader.h"
#import "MaterialAppBar.h"
```

#### Creating the UI programmatically.

The easiest way to use Material Components is to create the UI programmatically rather than
using Storyboards. This gives us full flexibility in how to put together the components.

To modify the new project to simply:

1. Remove the Main.storyboard.
2. In the Xcode Project settings, delete the "Main" value in the Storyboard setting.
3. Removing ViewController.swift
4. Implement creating a UIWindow in AppDelegate.swift.

#### Add some Material Icons

Our following examples will have some icons we would like to use. So simply download
the list of imagesets of Material icons [TODO] and drag them in to the Asset.xcassets.

#### Setting up CocoaPods

Refer to the quickstart for more details.


### Using the header component

Material components has two ways that allow you to integrate a header bar that behaves in a similar fashion to UINavigationController's UINavigationBar that allows deep customization and behaviors that implement the Material design guidance on scrolling.

The App Bar is the easiest way to add such a header. It uses the primitives UIViewController's navigationItem property
to handle the contents and placement of title's and buttons. Underneath the hood, the App Bar component uses the more powerful
Flexible Header component which allows complete customization of all the views inside the header.

Flexible Header is the more powerful way to add a header, but relies on the developer to provide the
contents. This allows the developer to more create a more sophisticated and rich header.

One key difference between the Flexible Header and UINavigationController's UINavigationBar is a separate view controller exposed
to your code that gives access and control to all the contents inside the header bar. This gives powerful access to

#### Integrating an App Bar

##### Create a new view controller

Create a new view controller called ViewControllerWithAppBar and give it a scroll view
that we will use as the main content.

```
import UIKit
class ViewControllerWithAppBar : UIViewController {
  var scrollView = UIScrollView()

  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.frame = view.bounds
    scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1024)
    view.addSubview(scrollView)
  }
}
```

This will create a scroll view that has some scrollable content and simply adds it to the view hierarchy.

##### Add UINavigationItem to the view controller

Next, we add support for defining the image and title of the header.

```
  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.frame = view.bounds
    scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1024)
    view.addSubview(scrollView)

    self.title = "Abstract"
    self.navigationItem.rightBarButtonItem =
        UIBarButtonItem(image: UIImage(named: "ic_search"),
                        style: .Plain,
                        target: self,
                        action: #selector(ViewControllerWithAppBar.search(_:)))  
  }
```

#### Add App Bar to the view controller

Finally, we can add support for the AppBar. To do this, there are three main steps.

First, the view controller needs to conform to the MDCAppBarParenting protocol:

```
class ViewControllerWithAppBar : UIViewController, MDCAppBarParenting {

  // Implement MDCAppBarParenting
  var headerStackView: MDCHeaderStackView?
  var navigationBar: MDCNavigationBar?
  var headerViewController: MDCFlexibleHeaderViewController?

}
```

Second, the view controller needs to override the initializers to add a convenience called
to set up the properties defined.

```
class ViewControllerWithAppBar : UIViewController, MDCAppBarParenting {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    MDCAppBarPrepareParent(self)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    MDCAppBarPrepareParent(self)
  }
}
```

Thirdly, the view controller's viewDidLoad needs to set up the appropriate views in the view
controller's view hierarchy so the header will show.

```
override func viewDidLoad() {
  super.viewDidLoad()
  // ...

  MDCAppBarAddViews(self)
}  
```

#### Initialize the view controller from AppDelegate

Initialize this new view controller in the AppDelegate.swift. You can initialize the
view controller as itself and add it straight to the UIWindow. In this example, we
would like to put this in a UINavigationController with the navigationBarHidden. By doing this
we can push other view controllers in to the stack and have the regular iOS navigation
stack like you are used to.

```
func application(application: UIApplication, didFinishLaunchingWithOptions
                 launchOptions: [NSObject: AnyObject]?) -> Bool {

  window = UIWindow()

  let navController = UINavigationController()
  navController.navigationBarHidden = true  // Flexible header draws our header.
  navController.pushViewController(ViewControllerWithAppBar(), animated: false)

  window?.rootViewController = navController
  window?.makeKeyAndVisible()
  return true
}
```

#### Integrating a Flexible Header

The layout of the App Bar is fairly prescriptive, so the UI desired has a more custom layout of
elements, or it has much more sophisticated dynamic layout that responds to the size of the
header, Flexible Header is the component to use. App Bar in fact uses Flexible Header under the hood.

##### Create a new view controllers

Create a new view controller called ViewControllerWithFlexibleHeader.


```
import UIKit
class ViewControllerWithFlexibleHeader : UIViewController {
  var scrollView = UIScrollView()

  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.frame = view.bounds
    scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1024)
    view.addSubview(scrollView)
  }
}
```

Again, like the App Bar example, there is a scroll view that is added to the content view.

#### Create a custom header view

Before integrating with Flexible Header, we should define a custom view that contains all the logic needed to
render the header. The view can just be a plain old view with some layout logic.

```
class CustomHeaderView : UIView {
  var titleLabel = UILabel()
  var iconView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let icon = UIImage(named: "ic_search")!.imageWithRenderingMode(.AlwaysTemplate)
    iconView.image = icon
    iconView.tintColor = UIColor.blackColor().colorWithAlphaComponent(0.7)

    titleLabel.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
    titleLabel.textColor = UIColor.clearColor()

    self.addSubview(iconView)
    self.addSubview(titleLabel)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    // not implementated
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    titleLabel.frame = CGRect(x: 16, y: self.bounds.size.height - 40, width: 128, height: 24)
    iconView.frame = CGRect(x: self.bounds.size.width - 24 - 16, y: 20 + 16, width: 24, height: 24)
  }
}
```

This header view creates a similar view as the one in the App Bar, for simplicity, but the layoutSubviews
logic locks the titleLabel to the bottom of the header while the iconView stays locks to the top right.

##### Adding Flexible Header

Integrating the Flexible Header is about the same amount of work as App Bar:

```
class ViewControllerWithFlexibleHeader : UIViewController, MDCFlexibleHeaderViewLayoutDelegate {
  var headerViewController = MDCFlexibleHeaderViewController()
  var customHeaderView = CustomHeaderView()

  //...
}
```

Override the initialize to add the MDCFlexibleHeaderViewController to the view controller
as a childViewController.

```
override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
   super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
   self.addChildViewController(headerViewController)
 }

 required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
   self.addChildViewController(headerViewController)
 }
```

Add the flexible header view to the actual view controller in viewDidLoad

```
override func viewDidLoad() {
  super.viewDidLoad()
  // ...

  headerViewController.view.frame = self.view.bounds
  self.view.addSubview(headerViewController.view)
  headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.562, blue: 0, alpha: 1.0)
  headerViewController.didMoveToParentViewController(self)

  // Setup the FlexibleHeader as a delegate
  headerViewController.headerView.trackingScrollView = scrollView
  scrollView.delegate = headerViewController
}
```

Now finally, add the CustomHeaderView in to the headerViewController's contentView so it
will show up.
```
override func viewDidLoad() {
  // ...
  var headerViewInitialFrame = headerViewController.headerView.contentView!.bounds
  headerViewInitialFrame.size.height = 56
  customHeaderView.frame = headerViewInitialFrame
  headerViewController.headerView.contentView!.addSubview(customHeaderView)
  headerViewController.didMoveToParentViewController(self)
  headerViewController.layoutDelegate = self
}


```

One extra thing that is added is to add this viewController as the layoutDelegate. This allows
us to listen for events when the header is resized. And we can implement a very simple way to
update the header view contents when the layout is changed.

```
// MDCFlexibleHeaderViewLayoutDelegate
 func flexibleHeaderViewController(flexibleHeaderViewController: MDCFlexibleHeaderViewController,
                                   flexibleHeaderViewFrameDidChange headerView: MDCFlexibleHeaderView) {
   customHeaderView.frame = headerView.contentView!.bounds
 }
```

One optional, but useful piece to add is to forward all status bar showing and hiding calls
to the headerViewController. This allows the flexibleHeader to do more sophisticated things
with hiding and showing the status bar when we want to maximize the content area.

```
  // MDCFlexibleHeaderViewController
  override func childViewControllerForStatusBarHidden() -> UIViewController {
    return headerViewController
  }
```

Once we have this, update the AppDelegate to use the ViewControllerWithFlexibleHeader instead
of ViewControllerWithAppBar to see the new FlexibleHeader driven AppBar in action.

```
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow()

    let navController = UINavigationController()
    navController.navigationBarHidden = true  // Flexible header draws our header.
    //navController.pushViewController(ViewControllerWithAppBar(), animated: false)
    navController.pushViewController(ViewControllerWithFlexibleHeader(), animated: false)

    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    return true
  }
}
```


### Material Collection Views

In previous examples, we used a scroll view rather than any content. In Material Components, there
is a sophisticated collection view addition that we've added which implements many of the Material design styled layout and animations.

Using this is very similar to using a regular UICollectionView.


### Material buttons

If there's an action that











- - -

## Detailed Guides

- [**Lorem Hello World**
  Learn how to create your first app using Material Components for iOS.
  ](/howto/lorem-hello-word/)

- [**Lorem Navigation Basics**
  A brief introduction to structuring your app and navigating between views.
  ](/howto/lorem-navigation-basics/)
{: .icon-list .large-format }




- - -

## Sample Code

- [**Pesto**
  A simple recipe app, which incorporates a flexible header, a grid list, cards, and a detail view.
  ](https://www.google.com/)
{: .icon-list .large-format }
