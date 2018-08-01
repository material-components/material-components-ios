<!--docs:
title: "App bars: top"
layout: detail
section: components
excerpt: "The Material Design top app bar displays information and actions relating to the current view."
iconId: toolbar
path: /catalog/app-bars/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme AppBar -->

# App bars: top

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BAppBar%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BAppBar%5D)

The Material Design top app bar displays information and actions relating to the current view.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/top-app-bar.gif" alt="An animation showing a top app bar appearing and disappearing." width="320">
</div>

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-app-bar-top">Material Design guidelines: App bars: top</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBar.html">MDCAppBar</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarContainerViewController.html">MDCAppBarContainerViewController</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarNavigationController.html">MDCAppBarNavigationController</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarTextColorAccessibilityMutator.html">MDCAppBarTextColorAccessibilityMutator</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarViewController.html">MDCAppBarViewController</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/app-bars/api-docs/Protocols/MDCAppBarNavigationControllerDelegate.html">MDCAppBarNavigationControllerDelegate</a></li>
</ul>

## Related components

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../FlexibleHeader">FlexibleHeader</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="../HeaderStackView">HeaderStackView</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="../NavigationBar">NavigationBar</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use: View controller containment, as a navigation controller](#typical-use-view-controller-containment,-as-a-navigation-controller)
  - [Typical use: View controller containment, as a child](#typical-use-view-controller-containment,-as-a-child)
  - [Typical use: View controller containment, as a container](#typical-use-view-controller-containment,-as-a-container)
  - [UINavigationItem support](#uinavigationitem-support)
  - [Interactive background views](#interactive-background-views)
- [Extensions](#extensions)
  - [Color Theming](#color-theming)
  - [Typography Theming](#typography-theming)
- [Example code](#example-code)
- [Accessibility](#accessibility)
  - [MDCAppBar Accessibility](#mdcappbar-accessibility)

- - -

## Overview

App bar is composed of the following components:

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../FlexibleHeader">FlexibleHeader</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="../HeaderStackView">HeaderStackView</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="../NavigationBar">NavigationBar</a></li>
</ul>

It is essentially a FlexibleHeader with a HeaderStackView and NavigationBar added as subviews.

`MDCAppBarViewController` is the primary API for the component. All integration strategies will
make use of it in some manner. Unlike UIKit, which shares a single UINavigationBar instance across
many view controllers in a stack, app bar relies on each view controller creating and managing its
own MDCAppBarViewController instance.

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/AppBar'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To import the component:

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


## Usage

<!-- Extracted from docs/typical-use-navigation-controller.md -->

### Typical use: View controller containment, as a navigation controller

The easiest integration path for using the app bar is through the `MDCAppBarNavigationController`.
This API is a subclass of UINavigationController that automatically adds an
`MDCAppBarViewController` instance to each view controller that is pushed onto it, unless an app bar
or flexible header already exists.

When using the `MDCAppBarNavigationController` you will, at a minimum, need to configure the added
app bar's background color using the delegate.

#### Example

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

<!-- Extracted from docs/typical-use-child.md -->

### Typical use: View controller containment, as a child

When an `MDCAppBarViewController` instance is added as a child to another view controller. In this
case, the parent view controller is often the object that creates and manages the
`MDCAppBarViewController` instance. This allows the parent view controller to configure the app bar
directly.

You'll typically push the parent onto a navigation controller, in which case you will also hide the
navigation controller's navigation bar using `UINavigationController`'s
`-setNavigationBarHidden:animated:`.

#### Example

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

<!-- Extracted from docs/typical-use-container.md -->

### Typical use: View controller containment, as a container

There are cases where adding an `MDCAppBarViewController` as a child is not possible, most notably:

- UIPageViewController's view is a horizontally-paging scroll view, meaning there is no fixed view
  to which an app bar could be added.
- Any other view controller that animates its content horizontally without providing a fixed,
  non-horizontally-moving parent view.

In such cases, using `MDCAppBarContainerViewController` is preferred.
`MDCAppBarContainerViewController` is a simple container view controller that places a content view
controller as a sibling to an `MDCAppBarViewController`.

**Note:** the trade off to using this API is that it will affect your view controller hierarchy. If
the makes any assumptions about its parent view controller or its navigationController properties
then these assumptions may break once the view controller is wrapped.

You'll typically push the container view controller onto a navigation controller, in which case you
will also hide the navigation controller's navigation bar using UINavigationController's
`-setNavigationBarHidden:animated:`.

#### Example

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

<!-- Extracted from docs/uinavigationitem-support.md -->

### UINavigationItem support

The App Bar begins mirroring the state of your view controller's `navigationItem` in the provided
`navigationBar` once you call `addSubviewsToParent`.

Learn more by reading the Navigation Bar section on
[Observing UINavigationItem instances](../NavigationBar/#observing-uinavigationitem-instances).
Notably: read the section on "Exceptions" to understand which UINavigationItem are **not**
supported.

<!-- Extracted from docs/interactive-background-views.md -->

### Interactive background views

Scenario: you've added a background image to your App Bar and you'd now like to be able to tap the
background image.

This is not trivial to do with the App Bar APIs due to considerations being discussed in
[Issue #184](https://github.com/material-components/material-components-ios/issues/184).

The heart of the limitation is that we're using a view (`headerStackView`) to lay out the Navigation
Bar. If you add a background view behind the `headerStackView` instance then `headerStackView` will
end up eating all of your touch events.

Until [Issue #184](https://github.com/material-components/material-components-ios/issues/184) is resolved, our recommendation for building interactive background views is the following:

1. Do not use the App Bar component.
2. Create your own Flexible Header. Learn more by reading the Flexible Header
   [Usage](../FlexibleHeader/#usage) docs.
3. Add your views to this flexible header instance.
4. Create a Navigation Bar if you need one. Treat it like any other custom view.


See the [FlexibleHeader](../FlexibleHeader) documentation for additional usage guides.

## Extensions

<!-- Extracted from docs/color-theming.md -->

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
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCAppBarColorThemer applySemanticColorScheme:colorScheme
     toAppBar:component];
```
<!--</div>-->

<!-- Extracted from docs/typography-theming.md -->

### Typography Theming

You can theme an app bar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/AppBar+TypographyThemer'
```

## Example code

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


## Accessibility

<!-- Extracted from docs/accessibility.md -->

### MDCAppBar Accessibility

Because the App Bar mirrors the state of your view controller's navigationItem, making an App Bar accessible often
does not require any extra work.

See the following examples:

##### Objective-C
```
self.navigationItem.rightBarButtonItem =
   [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                    style:UIBarButtonItemStyleDone
                                   target:nil
                                   action:nil];

NSLog(@"accessibilityLabel: %@",self.navigationItem.rightBarButtonItem.accessibilityLabel);
// Prints out "accessibilityLabel: Right"
```

##### Swift
```
self.navigationItem.rightBarButtonItem =
    UIBarButtonItem(title: "Right", style: .done, target: nil, action: nil)

print("accessibilityLabel: (self.navigationItem.rightBarButtonItem.accessibilityLabel)")
// Prints out "accessibilityLabel: Right"
```

