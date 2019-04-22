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
make use of it in some manner. Unlike UIKit, which shares a single `UINavigationBar` instance across
many view controllers in a stack, app bar relies on each view controller creating and managing its
own `MDCAppBarViewController` instance.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: View controller containment, as a navigation controller](typical-use-navigation-controller.md)
- [Typical use: View controller containment, as a child](typical-use-child.md)
- [Typical use: View controller containment, as a container](typical-use-container.md)
- [Typical use: Tracking a scroll view](../../FlexibleHeader/docs/typical-use-tracking-a-scroll-view.md)
- [Typical use: Enabling observation of the tracking scroll view](../../FlexibleHeader/docs/typical-use-scroll-view-observation.md)
- [UINavigationItem support](uinavigationitem-support.md)
- [Interactive background views](interactive-background-views.md)
- [Adjusting the top layout guide of a view controller](../../FlexibleHeader/docs/top-layout-guide-adjustment.md)

## Behavioral flags

A behavioral flag is a temporary API that is introduced to allow client teams to migrate from an old
behavior to a new one in a graceful fashion. Behavioral flags all go through the following life
cycle:

1. The flag is introduced. The default is chosen such that clients must opt in to the new behavior.
2. After some time, the default changes to the new behavior and the flag is marked as deprecated.
3. After some time, the flag is removed.

- [Recommended behavioral flags](recommended-behavioral-flags.md)
- [Removing safe area insets from the min/max heights](../../FlexibleHeader/docs/behavior-minmax-safearea.md)
- [Enabling top layout guide adjustment](../../FlexibleHeader/docs/behavior-top-layout-adjustment.md)
- [Enabling inferred top safe area insets](../../FlexibleHeader/docs/behavior-inferred-top-safe-area-inset.md)

See the [FlexibleHeader](../../FlexibleHeader) documentation for additional usage guides.

## Extensions

- [Theming](theming.md)

## Accessibility

- [Accessibility](accessibility.md)

## Migration guides

- [Migration guide: MDCAppBar to MDCAppBarViewController](migration-guide-appbar-appbarviewcontroller.md)

## Unsupported

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)
