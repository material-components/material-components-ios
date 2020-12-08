<!--docs:
title: "App bars: top"
layout: detail
section: components
excerpt: "The Material Design top app bar displays information and actions relating to the current view."
iconId: toolbar
path: /catalog/top-app-bars/
api_doc_root: true
-->

# App bars: top

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BAppBar%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BAppBar%5D)

[Top app bars](https://material.io/components/app-bars-top/#) display
information and actions relating to the current screen.

![Image showing a typical top app bar](docs/assets/appbar-hero.png)

**Contents**

* [Using top app bars](#using-top-app-bars)
* [Regular top app bar](#regular-top-app-bar)
* [Contextual action bar](#contextual-action-bar)
* [Theming](#theming)
* [Migration guides](#migration-guides)
* [Unsupported](#unsupported)

- - -

## Using top app bars

### Installing

In order to use top app bars, first add the `AppBar` subspec to your `Podfile`:

```bash
pod 'MaterialComponents/AppBar'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the installer:

```bash
pod install
```

After that, import the relevant target or file.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialAppBar
```

#### Objective-C
```objc
#import "MaterialAppBar.h"
```
<!--</div>-->

### Top app bar classes

Top app bars are composed of the following components:

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../FlexibleHeader">FlexibleHeader</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="../HeaderStackView">HeaderStackView</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="../NavigationBar">NavigationBar</a></li>
</ul>

A top app bar is essentially a FlexibleHeader with a HeaderStackView and NavigationBar added as subviews.

`MDCAppBarViewController` is the primary API for the component. All integration strategies will
make use of it in some manner. Top app bars rely on each view controller creating and managing their
own `MDCAppBarViewController` instances. This differs from UIKit, where many view controllers in a stack share a single `UINavigationBar` instance.

### Making top app bars accessible

Because the app bar mirrors the state of your view controller's `navigationItem`, making it accessible often does not require any extra work.

See the following examples:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
self.navigationItem.rightBarButtonItem =
    UIBarButtonItem(title: "Right", style: .done, target: nil, action: nil)

print("accessibilityLabel: \(self.navigationItem.rightBarButtonItem.accessibilityLabel)")
// Prints out "accessibilityLabel: Right"
```

#### Objective-C
```objc
self.navigationItem.rightBarButtonItem =
   [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                    style:UIBarButtonItemStyleDone
                                   target:nil
                                   action:nil];

NSLog(@"accessibilityLabel: %@",self.navigationItem.rightBarButtonItem.accessibilityLabel);
// Prints out "accessibilityLabel: Right"
```
<!--</div>-->

## Types

There are two types of top app bar:
1. [Regular top app bar](#regular-top-app-bar)
1. [Contextual action bar](#contextual-action-bar)

![Regular top app bar and contextual action bars](docs/assets/appbar-types.png)

## Regular top app bar

Regular top app bars are the only top app bars supported on iOS.

### Top app bar examples

#### Example with view controller containment, as a navigation controller

The easiest integration path for using the app bar is through the `MDCAppBarNavigationController`.
This API is a subclass of `UINavigationController` that automatically adds an
`MDCAppBarViewController` instance to each view controller that is pushed onto it, unless an app bar
or flexible header already exists.

When using the `MDCAppBarNavigationController` you will, at a minimum, need to configure the added
app bar's background color using the delegate.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let navigationController = MDCAppBarNavigationController()
navigationController.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)

// MARK: MDCAppBarNavigationControllerDelegate

func appBarNavigationController(_ navigationController: MDCAppBarNavigationController,
                                willAdd appBarViewController: MDCAppBarViewController,
                                asChildOf viewController: UIViewController) {
  appBarViewController.headerView.backgroundColor = <#(UIColor)#>
}
```

#### Objective-C
```objc
MDCAppBarNavigationController *navigationController =
    [[MDCAppBarNavigationController alloc] init];
[navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>];

#pragma mark - MDCAppBarNavigationControllerDelegate

- (void)appBarNavigationController:(MDCAppBarNavigationController *)navigationController
       willAddAppBarViewController:(MDCAppBarViewController *)appBarViewController
           asChildOfViewController:(UIViewController *)viewController {
  appBarViewController.headerView.backgroundColor = <#(nonnull UIColor *)#>;
}
```
<!--</div>-->

#### Example with view controller containment, as a child

`MDCAppBarViewController` instances can be added as children to other view controllers. In this
scenario, the parent view controller is often the object that creates and manages the
`MDCAppBarViewController` instance. This allows the parent view controller to configure the app bar
directly.

You'll typically push the parent onto a navigation controller, in which case you will also hide the
navigation controller's navigation bar using the `UINavigationController` method `-setNavigationBarHidden:animated:`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let appBarViewController = MDCAppBarViewController()

override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
  super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

  self.addChildViewController(appBarViewController)
}

override func viewDidLoad() {
  super.viewDidLoad()

  view.addSubview(appBarViewController.view)
  appBarViewController.didMove(toParentViewController: self)
}
```

#### Objective-C
```objc
@interface MyViewController ()
@property(nonatomic, strong, nonnull) MDCAppBarViewController *appBarViewController;
@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _appBarViewController = [[MDCAppBarViewController alloc] init];

    [self addChildViewController:_appBarViewController];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];
}

@end
```
<!--</div>-->

#### Example with view controller containment, as a container

There are cases where adding an `MDCAppBarViewController` as a child is not possible, most notably:

* When using `UIPageViewController`. `UIPageViewController`'s view is a horizontally paging scroll view, meaning there is no fixed view to which an app bar could be added.
* When using any other view controller that animates its content horizontally without providing a fixed, non-horizontally-moving parent view.

In such cases, using `MDCAppBarContainerViewController` is preferred.
`MDCAppBarContainerViewController` is a simple container view controller that places a content view
controller as a sibling to an `MDCAppBarViewController`.

**Note:** the trade off to using this API is that it will affect your view controller hierarchy. If
the view controller makes any assumptions about its parent view controller or its
navigationController properties then these assumptions may break once the view controller is
wrapped.

You'll typically push the container view controller onto a navigation controller, in which case you
will also hide the navigation controller's navigation bar using UINavigationController's
`-setNavigationBarHidden:animated:`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let container = MDCAppBarContainerViewController(contentViewController: <#T##UIViewController#>)
```

#### Objective-C

```objc
MDCAppBarContainerViewController *container =
    [[MDCAppBarContainerViewController alloc] initWithContentViewController:<#(nonnull UIViewController *)#>];
```
<!--</div>-->

#### Example tracking a scroll view

The flexible header can be provided with a tracking scroll view. This allows the flexible header to
expand, collapse, and shift off-screen in reaction to the tracking scroll view's delegate events.

> Important: When using a tracking scroll view you must forward the relevant UIScrollViewDelegate
> events to the flexible header.

Follow these steps to hook up a tracking scroll view:

Step 1: **Set the tracking scroll view**.

In your `-viewDidLoad`, set the `trackingScrollView` property on the header view:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
headerViewController.headerView.trackingScrollView = scrollView
```

#### Objective-C

```objc
self.headerViewController.headerView.trackingScrollView = scrollView;
```
<!--</div>-->

`scrollView` might be a table view, collection view, or a plain UIScrollView.

#### iOS 13 Collection Considerations

iOS 13 changed the behavior of the `contentInset` of a collection view by triggering a layout.
This may affect your app if you have not yet registered cells for reuse yet. Our recomendation is
to use view controller composition by making your collection view controller a child view
controller. If this is not possible then ensure the correct order of operations by registering cell
reuse identifiers before setting the Flexible Header's `trackingScrollView`.

Step 2: **Forward `UIScrollViewDelegate` events to the Header View**.

There are two ways to forward scroll events.

Option 1: if your controller does not need to respond to `UIScrollViewDelegate` events and you're
using either a plain `UIScrollView` or a `UITableView` you can set your `MDCFlexibleHeaderViewController`
instance as the scroll view's delegate.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
scrollView.delegate = headerViewController
```

#### Objective-C

```objc
scrollView.delegate = self.headerViewController;
```
<!--</div>-->

Option 2: implement the required `UIScrollViewDelegate` methods and forward them to the
`MDCFlexibleHeaderView` instance. This is the most flexible approach and will work with any
`UIScrollView` subclass.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// MARK: UIScrollViewDelegate

override func scrollViewDidScroll(scrollView: UIScrollView) {
  if scrollView == headerViewController.headerView.trackingScrollView {
    headerViewController.headerView.trackingScrollViewDidScroll()
  }
}

override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
  if scrollView == headerViewController.headerView.trackingScrollView {
    headerViewController.headerView.trackingScrollViewDidEndDecelerating()
  }
}

override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
  let headerView = headerViewController.headerView
  if scrollView == headerView.trackingScrollView {
    headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
  }
}

override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
  let headerView = headerViewController.headerView
  if scrollView == headerView.trackingScrollView {
    headerView.trackingScrollViewWillEndDraggingWithVelocity(velocity, targetContentOffset: targetContentOffset)
  }
}
```

#### Objective-C

```objc
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
```
<!--</div>-->

#### Enabling observation of the tracking scroll view

If you do not require the flexible header's shift behavior, then you can avoid having to manually
forward `UIScrollViewDelegate` events to the flexible header by enabling
`observesTrackingScrollViewScrollEvents` on the flexible header view. Observing the tracking
scroll view allows the flexible header to over-extend, if enabled, and allows the header's shadow to
show and hide itself as the content is scrolled.

**Note:** if you support pre-iOS 11 then you will also need to explicitly clear your tracking scroll
view in your deinit/dealloc method.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.headerView.observesTrackingScrollViewScrollEvents = true

deinit {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  appBarViewController.headerView.trackingScrollView = nil
}
```

#### Objective-C

```objc
flexibleHeaderViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}
```
<!--</div>-->

**Note:** if `observesTrackingScrollViewScrollEvents` is enabled then you can neither enable shift
behavior nor manually forward scroll view delegate events to the flexible header.

#### `UINavigationItem` support

The app bar begins mirroring the state of your view controller's `navigationItem` in the provided
`navigationBar` once you call `addSubviewsToParent`.

Learn more by reading the Navigation Bar section on
[Observing UINavigationItem instances](../NavigationBar/#observing-uinavigationitem-instances).
Notably: read the section on "Exceptions" to understand which UINavigationItem are **not**
supported.

#### Interactive background views

Scenario: you've added a background image to your app bar and you'd now like to be able to tap the
background image.

This is not trivial to do with the app bar APIs due to considerations being discussed in
[Issue #184](https://github.com/material-components/material-components-ios/issues/184).

The heart of the limitation is that we're using a view (`headerStackView`) to lay out the Navigation
Bar. If you add a background view behind the `headerStackView` instance then `headerStackView` will
end up eating all of your touch events.

Until [Issue #184](https://github.com/material-components/material-components-ios/issues/184) is resolved, our recommendation for building interactive background views is the following:

1. Do not use the component.
2. Create your own Flexible Header. Learn more by reading the Flexible Header
   [Usage](../FlexibleHeader/#usage) docs.
3. Add your views to this flexible header instance.
4. Create a Navigation Bar if you need one. Treat it like any other custom view.

#### Adjusting the top layout guide of a view controller

If your content view controller depends on the top layout guide being adjusted — e.g. if the
content does not have a tracking scroll view and therefore relies on the top layout guide to perform
layout calculations — then you should consider setting `topLayoutGuideViewController` to the
content view controller.

Setting this property does two things:

1. Adjusts the view controller's `topLayoutGuide` property to take the flexible header into account
   (most useful pre-iOS 11).
2. On iOS 11 and up — if there is no tracking scroll view — also adjusts the
   `additionalSafeAreaInsets` property to take the flexible header into account.

**Note:** `topLayoutGuideAdjustmentEnabled` is automatically enabled if this property is set.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.topLayoutGuideViewController = contentViewController
```

#### Objective-C

```objc
flexibleHeaderViewController.topLayoutGuideViewController = contentViewController;
```
<!--</div>-->

#### Behavioral flags

A behavioral flag is a temporary API that is introduced to allow client teams to migrate from an old
behavior to a new one in a graceful fashion. Behavioral flags all go through the following life
cycle:

1. The flag is introduced. The default is chosen such that clients must opt in to the new behavior.
2. After some time, the default changes to the new behavior and the flag is marked as deprecated.
3. After some time, the flag is removed.

#### Recommended behavioral flags

The app bar component and its dependencies include a variety of flags that affect the behavior of
the `MDCAppBarViewController`. Many of these flags represent feature flags that we are using
to allow client teams to migrate from an old behavior to a new, usually less-buggy one.

You are encouraged to set all of the behavioral flags immediately after creating an instance of the
app bar.

The minimal set of recommended flag values are:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Enables support for iPad popovers and extensions.
// Automatically enables topLayoutGuideAdjustmentEnabled as well, but does not set a
// topLayoutGuideViewController.
appBarViewController.inferTopSafeAreaInsetFromViewController = true

// Enables support for iPhone X safe area insets.
appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
```

#### Objective-C

```objc
// Enables support for iPad popovers and extensions.
// Automatically enables topLayoutGuideAdjustmentEnabled as well, but does not set a
// topLayoutGuideViewController.
appBarViewController.inferTopSafeAreaInsetFromViewController = YES;

// Enables support for iPhone X safe area insets.
appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;
```
<!--</div>-->

#### Removing safe area insets from the min/max heights

The minimum and maximum height values of the flexible header view assume by default that the values
include the top safe area insets value. This assumption no longer holds true on devices with a
physical safe area inset and it never held true when flexible headers were shown in non full screen
settings (such as popovers on iPad).

This behavioral flag is enabled by default, but will eventually be disabled by default and the flag
will eventually be removed.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.headerView.minMaxHeightIncludesSafeArea = false
```

#### Objective-C

```objc
flexibleHeaderViewController.headerView.minMaxHeightIncludesSafeArea = NO;
```
<!--</div>-->

#### Enabling top layout guide adjustment

The `topLayoutGuideAdjustmentEnabled` behavior flag affects `topLayoutGuideViewController`.
Setting `topLayoutGuideAdjustmentEnabled` to `YES` enables the new behavior.

`topLayoutGuideAdjustmentEnabled` is disabled by default, but will eventually be enabled by default
and the flag will eventually be removed.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.topLayoutGuideAdjustmentEnabled = true
```

#### Objective-C

```objc
flexibleHeaderViewController.topLayoutGuideAdjustmentEnabled = YES;
```
<!--</div>-->

#### Enabling inferred top safe area insets

Prior to this behavioral flag, the flexible header always assumed that it was presented in a
full-screen capacity, meaning it would be placed directly behind the status bar or device bezel
(such as the iPhone X's notch). This assumption does not support extensions and iPad popovers.

Enabling the `inferTopSafeAreaInsetFromViewController` flag tells the flexible header to use its
view controller ancestry to extract a safe area inset from its context, instead of relying on
assumptions about placement of the header.

This behavioral flag is disabled by default, but will eventually be enabled by default and the flag
will eventually be removed.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.inferTopSafeAreaInsetFromViewController = true
```

#### Objective-C

```objc
flexibleHeaderViewController.inferTopSafeAreaInsetFromViewController = YES;
```
<!--</div>-->

**Note:** if this flag is enabled and you've also provided a `topLayoutGuideViewController`, take
care that the `topLayoutGuideViewController` is not a direct ancestor of the flexible header or your
app **will** enter an infinite loop. As a general rule, your `topLayoutGuideViewController` should
be a sibling to the flexible header.

See the [FlexibleHeader](../FlexibleHeader) documentation for additional usage guides.

### Anatomy and Key properties

![Regular app bar anatomy diagram](docs/assets/top-app-bar-anatomy.png)

1.  Container
2.  Navigation icon (optional)
3.  Title (optional)
4.  Action items (optional)
5.  Overflow menu (optional)

#### Container attributes

&nbsp;                          | Attribute                   | Related method(s)                                | Default value
------------------------------- | --------------------------- | ------------------------------------------------ | -------------
**Color**                       | `headerView.backgroundColor` | `-setBackgroundColor:`<br>`-backgroundColor` | Primary color
**Elevation**                   | `headerView.elevation`       | `-setElevation:`<br>`-elevation`              | 4

#### Navigation icon attributes

&nbsp;                           | Attribute            | Related method(s)                          | Default value
-------------------------------- | -------------------- | ------------------------------------------ | -------------
**Icons**                        | `-[UIViewController navigationItem]` | `-setLeftBarButtonItems:`<br>`-leftBarButtonItems`<br>`-setRightBarButtonItems:`<br>`-rightBarButtonItems` | `nil`

#### Title attributes

&nbsp;                                                   | Attribute                                                   | Related method(s)                 | Default value
-------------------------------------------------------- | ----------------------------------------------------------- | --------------------------------- | -------------
**Title text**                                           | `-[UIViewController navigationItem]`                        | `-setTitle:`<br>`-title`          | `nil` |
**Title color**                                           | `navigationBar.titleTextColor`                             | `-setTitleTextColor:`<br> `-titleTextColor`  | On primary color
**Title font**                                           | `navigationBar.titleFont`                                   | `-setTitleFont:`<br>`-titleFont`   | Headline 6

#### Action items attributes

&nbsp;                           | Attribute            | Related method(s)                          | Default value
-------------------------------- | -------------------- | ------------------------------------------ | -------------
**Icons**                        | `-[UIViewController navigationItem]` | `-setLeftBarButtonItems:`<br>`-leftBarButtonItems`<br>`-setRightBarButtonItems:`<br>`-rightBarButtonItems` | `nil`

#### Overflow menu attributes

&nbsp;                           | Attribute            | Related method(s)                          | Default value
-------------------------------- | -------------------- | ------------------------------------------ | -------------
**Icons**                        | `-[UIViewController navigationItem]` | `-setLeftBarButtonItems:`<br>`-leftBarButtonItems`<br>`-setRightBarButtonItems:`<br>`-rightBarButtonItems` | `nil`

## Contextual action bar

Contextual action bars are not implemented on iOS.

## Theming

`MDCAppBarViewController` supports Material Theming using a Container Scheme. To theme your app bar, add the `AppBar+Theming` subspec to your `Podfile`:

```bash
pod 'MaterialComponents/AppBar+Theming'
```
<!--{: .code-renderer.code-renderer--install }-->

Then run the installer:

```bash
pod install
```

There are two variants for Material Theming of an app bar. The Surface Variant colors the app bar
background to be `surfaceColor` and the Primary Variant colors the app bar background to be
`primaryColor`.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

```swift
// Import the AppBar Theming Extensions module
import MaterialComponents.MaterialAppBar_Theming

...

// Apply your app's Container Scheme to the App Bar controller
let containerScheme = MDCContainerScheme()

// Either Primary Theme
appBarViewController.applyPrimaryTheme(withScheme: containerScheme)

// Or Surface Theme
appBarViewController.applySurfaceTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Import the AppBar Theming Extensions header
#import "MaterialAppBar+Theming.h"

...

// Apply your app's Container Scheme to the App Bar controller
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Either Primary Theme
[self.appBarController applyPrimaryThemeWithScheme:containerScheme];

// Or Surface Theme
[self.appBarController applySurfaceThemeWithScheme:containerScheme];
```

<!--</div>-->

## Migration guides

### Migration guide: MDCAppBar to MDCAppBarViewController

`MDCAppBarViewController` is a direct replacement for `MDCAppBar`. The migration essentially looks
like so:

```swift
// Step 1
-  let appBar = MDCAppBar()
+  let appBarViewController = MDCAppBarViewController()

// Step 2
-  self.addChildViewController(appBar.headerViewController)
+  self.addChildViewController(appBarViewController)

// Step 3
-  appBar.addSubviewsToParent()
+  // Match the width of the parent view.
+  CGRect frame = appBarViewController.view.frame;
+  frame.origin.x = 0;
+  frame.size.width = appBarViewController.parentViewController.view.bounds.size.width;
+  appBarViewController.view.frame = frame;
+
+  view.addSubview(appBarViewController.view)
+  appBarViewController.didMove(toParentViewController: self)
```

`MDCAppBarViewController` is a subclass of `MDCFlexibleHeaderViewController`, meaning you configure
an `MDCAppBarViewController` instance exactly the same way you'd configure an
`MDCFlexibleHeaderViewController` instance.

`MDCAppBar` also already uses `MDCAppBarViewController` under the hood so you can directly replace
any references of `appBar.headerViewController` with `appBarViewController`.

#### Swift find and replace recommendations

| Find | Replace |
|:-----|:-------------|
| `let appBar = MDCAppBar()` | `let appBarViewController = MDCAppBarViewController()` |
| `self.addChildViewController(appBar.headerViewController)` | `self.addChildViewController(appBarViewController)` |
| `appBar.addSubviewsToParent()` | `view.addSubview(appBarViewController.view)`<br/>`appBarViewController.didMove(toParentViewController: self)` |
| `self.appBar.headerViewController` | `self.appBarViewController` |

#### Objective-C find and replace recommendations

| Find | Replace |
|:-----|:-------------|
| `MDCAppBar *appBar;` | `MDCAppBarViewController *appBarViewController;` |
| `appBar = [[MDCAppBar alloc] init]` | `appBarViewController = [[MDCAppBarViewController alloc] init]` |
| `addChildViewController:appBar.headerViewController` | `addChildViewController:appBarViewController` |
| `[self.appBar addSubviewsToParent];` | `[self.view addSubview:self.appBarViewController.view];`<br/>`[self.appBarViewController didMoveToParentViewController:self];` |

#### Example migrations

- [MDCCatalog examples](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c)

## Unsupported

### Color Theming

You can theme an app bar with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/AppBar+ColorThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialAppBar_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialAppBar+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

// Step 3: Apply the color scheme to your component
[MDCAppBarColorThemer applySemanticColorScheme:colorScheme
                                      toAppBar:component];
```
<!--</div>-->

### Typography Theming

You can theme an app bar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/AppBar+TypographyThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialAppBar_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCAppBarTypographyThemer.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialAppBar+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCAppBarTypographyThemer applyTypographyScheme:colorScheme
                                        toAppBar:component];
```
<!--</div>-->
