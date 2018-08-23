# Flexible header

<!-- badges -->

A flexible header is a container view whose height and vertical offset react to
UIScrollViewDelegate events.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/flexible-header.gif" alt="An animation showing a flexible header appearing and disappearing." width="320">
</div>

<!-- design-and-api -->

## Related components

* [AppBar](../../AppBar)

<!-- toc -->

- - -

## Overview

A flexible header is a simple container view designed to live at the top of a view controller and
react to scroll view events. Flexible headers are intended to be created and owned by each view
controller that requires one. This is an intentional deviation from the one-UINavigationBar design
of UINavigationController, and we discuss the merits and drawbacks of this approach below.

The heart of flexible header is MDCFlexibleHeaderView. MDCFlexibleHeaderView is a container view,
meaning you are expected to register your own subviews to it. MDCFlexibleHeaderView simply manages
its "frame", you are responsible for everything within the bounds.

MDCFlexibleHeaderViewController is the ideal way to create and manage the lifetime of a
MDCFlexibleHeaderView instance. Adding this view controller as a child of your view controller
ensures that the flexible header is able to react to device orientation and view appearance events.
This document generally assumes that you are familiar with
[UIViewController containment](https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html).

### Considerations

Requiring each view controller to own a flexible header instance has several technical advantages:

- Transitions between two view controllers can include the header in their motion considerations.
- Flexible header customizations are scoped to the owner view controller.

It also has some technical disadvantages:

- There is a cost to registering and owning a flexible header instance when compared to
  UINavigationController and the free availability of UINavigationBar. Improvements to this
  are being discussed on [issue #268](https://github.com/material-components/material-components-ios/issues/268).

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: Add the flexible header to a view controller](typical-use.md)
- [Typical use: Tracking a scroll view](typical-use-tracking-a-scroll-view.md)
- [Typical use: Enabling observation of the tracking scroll view](typical-use-scroll-view-observation.md)
- [Shifting a flexible header off-screen](shift-behavior.md)
- [Reacting to frame changes](reacting-to-frame-changes.md)
- [Subclassing considerations](subclassing-considerations.md)
- [Interacting with UINavigationController](interacting-with-uinavigationcontroller.md)
- [Enabling Swipe to Dismiss](enabling-swipe-to-dismiss.md)
- [Status bar style](status-bar-style.md)
- [Background images](background-images.md)
- [Touch forwarding](touch-forwarding.md)
- [Tracking a parent view](tracking-a-parent-view.md)
- [WKWebView considerations](wkwebview-considerations.md)

## Behavioral flags

A behavioral flag is a temporary API that is introduced to allow client teams to migrate from an old
behavior to a new one in a graceful fashion. Behavioral flags all go through the following life
cycle:

1. The flag is introduced. The default is chosen such that clients must opt in to the new behavior.
2. After some time, the default changes to the new behavior and the flag is marked as deprecated.
3. After some time, the flag is removed.

- [Recommended behavioral flags](recommended-behavioral-flags.md)
- [Removing safe area insets from the min/max heights](behavior-minmax-safearea.md)
- [Enabling top layout guide adjustment](behavior-top-layout-adjustment.md)
- [Enabling inferred top safe area insets](behavior-inferred-top-safe-area-inset.md)

## Extensions

- [Color Theming](color-theming.md)

## Migration guides

- [Migration guide: minMaxHeightIncludesSafeArea](migration-guide-minMaxHeightIncludesSafeArea.md)
