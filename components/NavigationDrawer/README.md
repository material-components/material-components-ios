<!--docs:
title: "NavigationDrawer"
layout: detail
section: components
excerpt: "Navigation drawers provide access to destinations and app functionality, such as switching accounts."
iconId: list
path: /catalog/navigation-drawer/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme NavigationDrawer -->

# Navigation Drawer

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BNavigationDrawer%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BNavigationDrawer%5D)

Navigation drawers provide access to destinations and app functionality, such as switching accounts. They can either be permanently on-screen or controlled by a navigation menu icon.

Navigation drawers are recommended for:
  <li class="icon-list-item icon-list-item">Apps with five or more top-level destinations.</li>
  <li class="icon-list-item icon-list-item">Apps with two or more levels of navigation hierarchy.</li>
  <li class="icon-list-item icon-list-item">Quick navigation between unrelated destinations.</li>
</ul>

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-navigation-drawer">Material Design guidelines: Navigation Drawer</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Classes/MDCBottomDrawerPresentationController.html">MDCBottomDrawerPresentationController</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Classes/MDCBottomDrawerTransitionController.html">MDCBottomDrawerTransitionController</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Classes/MDCBottomDrawerViewController.html">MDCBottomDrawerViewController</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Protocols/MDCBottomDrawerHeader.html">MDCBottomDrawerHeader</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Protocols/MDCBottomDrawerPresentationControllerDelegate.html">MDCBottomDrawerPresentationControllerDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Protocols/MDCBottomDrawerViewControllerDelegate.html">MDCBottomDrawerViewControllerDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Enums.html">Enumerations</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/navigation-drawer/api-docs/Enums/MDCBottomDrawerState.html">MDCBottomDrawerState</a></li>
</ul>

## Table of contents

- [Overview](#overview)
  - [Navigation Drawer Classes](#navigation-drawer-classes)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use: using the `MDCBottomDrawerViewController` with/without a header.](#typical-use-using-the-`mdcbottomdrawerviewcontroller`-withwithout-a-header.)
  - [Typical use: presenting in a drawer without a header.](#typical-use-presenting-in-a-drawer-without-a-header.)
  - [Typical use: using the `MDCBottomDrawerViewController` with a need for performant scrolling.](#typical-use-using-the-`mdcbottomdrawerviewcontroller`-with-a-need-for-performant-scrolling.)

- - -

## Overview

Navigation Drawer currently provides the [Bottom Drawer](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) presentation style.

The Navigation Drawer is architected by implementing a custom `UIPresentationController` and a `UIViewControllerTransitioningDelegate` named `MDCBottomDrawerPresentationController` and `MDCBottomDrawerTransitionController` respectively.
This allows us to use the default API Apple provides for `UIViewController` presentation (more on usage [below](#usage)).

Through the `MDCBottomDrawerViewController` class, the Navigation Drawer allows you to pass a `contentViewController` to act as the content of the drawer, and also a `headerViewController` which will stick to the top once the drawer is in full screen.

`MDCBottomDrawerViewController` also provides a settable `trackingScrollView` property that should be set to the `UITableView` or `UICollectionView` inside your content, if and only if that view fills the entire bounds, and if you are seeking for a more performant solution of having the algorithm only load your view as you scroll and not all at once.

Lastly, your headerViewController conforms to the `MDCBottomDrawerHeader` protocol, which implements the method `updateDrawerHeaderTransitionRatio:(CGFloat)transitionToTopRatio`. This method provides `transitionToTopRatio`, which moves between 0 to 1 as the transition of the header view
 transforms from being above the content to becoming sticky on the top. It is 0 when the drawer is above the content and starts changing as the header view expands to cover the status bar and safe area based on the completion rate. It is 1 once the header finishes its transition to become sticky on the top and it's height is at the size of its preferredContentSize + the safe area.

### Navigation Drawer Classes

#### MDCBottomDrawerViewController

`MDCBottomDrawerViewController` is a `UIViewController` that allows you to provide your drawer content via the `contentViewController` and your desired header (optional) through the `headerViewController` property.

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/NavigationDrawer'
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
import MaterialComponents.MaterialNavigationDrawer
```

#### Objective-C

```objc
#import "MaterialNavigationDrawer.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/typical-use-drawer.md -->

### Typical use: using the `MDCBottomDrawerViewController` with/without a header.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = UIViewController()
bottomDrawerViewController.headerViewController = UIViewController() # this is optional
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = [UIViewController new];
bottomDrawerViewController.headerViewController = [UIViewController new];
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->

<!-- Extracted from docs/typical-use-drawer-no-header.md -->

### Typical use: presenting in a drawer without a header.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let contentViewController = UIViewController()
contentViewController.transitioningDelegate = MDCBottomDrawerTransitionController()
contentViewController.modalPresentationStyle = .custom
present(contentViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
UIViewController *contentViewController = [UIViewController new];
contentViewController.transitioningDelegate = [MDCBottomDrawerTransitionController new];
contentViewController.modalPresentationStyle = UIModalPresentationCustom;
[self presentViewController:contentViewController animated:YES completion:nil];
```
<!--</div>-->

<!-- Extracted from docs/typical-use-performant-drawer.md -->

### Typical use: using the `MDCBottomDrawerViewController` with a need for performant scrolling.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let contentViewController = UITableViewController()
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = contentViewController
bottomDrawerViewController.headerViewController = UIViewController() # this is optional
bottomDrawerViewController.trackingScrollView = contentViewController.view
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
UITableViewController *contentViewController = [UITableViewController new];
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = contentViewController;
bottomDrawerViewController.headerViewController = [UIViewController new];
bottomDrawerViewController.trackingScrollView = contentViewController.view;
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->


