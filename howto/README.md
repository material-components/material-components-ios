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


## Creating a simple Material Design iOS app

This guide will take you through the steps of creating your first Material design iOS app
and give you a starting point for using our flexible headers and collection views.

In this tutorial, we'll create an example app called Abstract which brings together the main components available in the Material Components collection such as the App Bar, Flexible Header, Collection View and Buttons.

### Setting up

To get started, download this skeleton new project which we will set up with Material Components.

```
git clone ...
```

This project is similar to a new project create using Xcode's new project template except with a small number of changes:

1. Removes the Main.storyboard and references to it in favor of programmatically creating the UI.
2. Adds a bridging header (BridgingHeader.h) and the Xcode configuration for it.
3. Adds a simple String class extension for creating sample text.
4. Adds two icons (search and add) from [Material Icons](https://github.io/google/material-icons)
5. Creates a new MainViewController.swift.

#### 1. Add Material Components through CocoaPods

The first step is to add Material Components through CocoaPods. The [Material Components quickstart](https://materialcomponents.org/) has detailed instructions, but in short, create a Podfile in the root of the example with the following contents:

```
target 'Abstract' do
  pod 'MaterialComponents'
end
```

Run `pod install` in that directory and open up `Abstract.xcworkspace`.

#### 2. Bridging for Swift

Material Components is written in Objective-C and is completely usable from Swift. In order to make the classes visible to Swift, the headers need to be added to the `BridgingHeaders.h`. Open up `BridgingHeaders.h` and add the following lines.


```
#import "MaterialAppBar.h"
#import "MaterialButtons.h"
#import "MaterialCollections.h"
#import "MaterialFlexibleHeader.h"
```

Now the project is ready for adding in the first Material component.

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
  headerViewController.headerView.behavior = .Enabled
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

#### Using the MDCCollectionViewController

MDCCollectionViewController is a subclass of the UICollectionViewController and can be used in place
of a UIViewController base class. Using this is the easiest way to get started with Material collection views.

```
class ViewControllerWithAppBar : MDCCollectionViewController, MDCAppBarParenting {

}
```

The collection view will replace the scroll view that was in the App Bar example earlier. In place of
the scroll view, a model is initialized:

```
override func viewDidLoad() {
  super.viewDidLoad()

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
```

Unlike with the simple example with the App Bar above, the UICollectionViewController is the
delegate for the UICollectionView, we cannot just do a simple delegate assignment like we did
with the App Bar to forward scroll view events.

Instead, we need to manually forward four additional UIScrollViewDelegate methods to
the MDCFlexibleHeaderView to preserve our collapsing header functionality.

```

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
```

If these are omitted, the header will continue to work, but there will not be any collapsing and expanding behavior.

If you prefer to use not use the model, see the Material Collection View component documentation for
more detail. This component also handles editing and moving of rows, which is also covered in the component documentation.

#### Handling taps on a row

The final step is to handle taps on a row. It is very similar to the normal UICollectionViewDelegate
way of doing things

```
override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
  super.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
  let vc = ViewControllerWithCollections(nibName: nil, bundle: nil)
  self.navigationController?.pushViewController(vc, animated: true)
}
```

#### Bonus: Custom cells

[TODO]


### Material Buttons

Material Components has several styled buttons depending on where they are placed. For Floating Action Buttons (spec),
the Material Buttons component has a class called MDCShapedButton that allows for creating a simple
rounded button that contains an icon.

To add this to the Abstract app, the button should be initialized at viewDidLoad and then
added to the view controller's root view so it stays floated in the corner.

```
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

```

When the floating action button is tapped on, the `add:` selector is called and it will add a
row to the collection view. Collection views can animate any changes using MDCCollectionViewModel.performBatchOperations

```
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
```

#### Bonus : Proper view controller transitions

One odd artifact with this app is the floating action button animates with the rest of the view
controller. The intention of the design is it floats on top of all the views, but for convenience
we've added it to the view controller.

Rather, when a view controller transition happens, the floating action button should be removed
from the view hierarchy and animated in when the view controller appears.

Fading in to the view controller:

```
 override func viewDidAppear(animated: Bool) {
   weak var weakButton = button
   UIView.animateWithDuration(0.2, animations: {
     weakButton!.alpha = 1
   })
 }
```

Fading out when the view controller changes, replace the `collectionView:didSelectItemAtIndexPath`
to pushViewController with an animation to FAB.

```
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

```

#### Next steps

This tutorial has taken you through implementing a basic Material Design style app with some of our
components. There are a lot more components that are not covered which are covered in our component
documentation.

Also see our examples and catalog apps that are in the project to show how to use some of the more
advanced features.














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
