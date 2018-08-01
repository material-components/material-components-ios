# App bars: top

<!-- badges -->

The Material Design top app bar displays information and actions relating to the current view.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/top-app-bar.gif" alt="An animation showing a top app bar appearing and disappearing." width="320">
</div>

<!-- design-and-api -->

## Related components

* [FlexibleHeader](../../FlexibleHeader)
* [HeaderStackView](../../HeaderStackView)
* [NavigationBar](../../NavigationBar)

<!-- toc -->

- - -

## Overview

App bar is composed of the following components:

* [FlexibleHeader](../../FlexibleHeader)
* [HeaderStackView](../../HeaderStackView)
* [NavigationBar](../../NavigationBar)

It is essentially a FlexibleHeader with a HeaderStackView and NavigationBar added as subviews.

`MDCAppBarViewController` is the primary API for the component. All integration strategies will
make use of it in some manner. Unlike UIKit, which shares a single UINavigationBar instance across
many view controllers in a stack, app bar relies on each view controller creating and managing its
own MDCAppBarViewController instance.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: View controller containment, as a navigation controller](typical-use-navigation-controller.md)
- [Typical use: View controller containment, as a child](typical-use-child.md)
- [Typical use: View controller containment, as a container](typical-use-container.md)
- [UINavigationItem support](uinavigationitem-support.md)
- [Interactive background views](interactive-background-views.md)

See the [FlexibleHeader](../../FlexibleHeader) documentation for additional usage guides.

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)

## Accessibility

- [Accessibility](accessibility.md)
