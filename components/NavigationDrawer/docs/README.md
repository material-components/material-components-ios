# Navigation Drawer

<!-- badges -->

Navigation drawers provide access to destinations and app functionality, such as switching accounts. They can either be permanently on-screen or controlled by a navigation menu icon.

Navigation drawers are recommended for:
* Apps with five or more top-level destinations.
* Apps with two or more levels of navigation hierarchy.
* Quick navigation between unrelated destinations.

<!-- design-and-api -->

<!-- toc -->

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

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: using the `MDCBottomDrawerViewController` with/without a header.](typical-use-drawer.md)
- [Typical use: presenting in a drawer without a header.](typical-use-drawer-no-header.md)
- [Typical use: using the `MDCBottomDrawerViewController` with a need for performant scrolling.](typical-use-performant-drawer.md)

