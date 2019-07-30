# Navigation bar

<!-- badges -->

A navigation bar is a view composed of leading and trailing buttons and either a title label or a
custom title view.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/navigation_bar.png" alt="Navigation bar" width="320">
</div>

<!-- design-and-api -->

## Related components

* [App bars: top](../../AppBar)
* [App bars: bottom](../../BottomAppBar)

<!-- toc -->

- - -

## Overview

Navigation bar is a drop-in replacement for UINavigationBar with a few notable exceptions:

- No navigationItem stack. Instances of MDCNavigationBar must be explicitly provided with a back
  button. TODO(featherless): Explain how to create a back button with navigation bar once
  https://github.com/material-components/material-components-ios/issues/340 lands.

The MDCNavigationBar class is a composition of two button bars and a title label or
title view. The left and right Button Bars are provided with the navigation item's corresponding bar
button items.

Read the button bar section on
[UIBarButtonItem properties](../../ButtonBar/#uibarbuttonitem-properties) to learn more about
supported UIBarButtonItem properties.

Note: The UIBarButtonItem instances set on MDCNavigationBar cannot be used to specify the popover's
anchor point on UIPopoverPresentationController. The sourceView and sourceRect on
UIPopoverPresentationController should be used instead.
```objc
// Set a view controller to be popped over at the center of a target view.
aViewContoller.popoverPresentationController.sourceView = targetView;
aViewContoller.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(targetView.bounds)),CGRectGetMidY(targetView.bounds), 0, 0);
```

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Observing UINavigationItem instances](observing-navigationitem-instances.md)

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)
