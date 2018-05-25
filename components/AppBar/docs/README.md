# App bars: top

<!-- badges -->

The Material Design top app bar displays information and actions relating to the current view.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/top-app-bar.gif" alt="An animation showing a top app bar appearing and disappearing." width="320">
</div>

<!-- design-and-api -->

## Related components

* [FlexibleHeader](../../FlexibleHeader)

<!-- toc -->

- - -

## Overview

The top app bar is implemented on iOS in the AppBar component. This component's main API is
`MDCAppBar`, a compose API that initializes and provides access to instances of the
following components:

* [Flexible Header](../../FlexibleHeader)
* [Header Stack View](../../HeaderStackView)
* [Navigation Bar](../../NavigationBar)

The provided view hierarchy looks like so:

    <MDCFlexibleHeaderView>
       | <CALayer>
       |    | <MDCShadowLayer>
       | <UIView> <- headerView.contentView
       |    | <MDCHeaderStackView>
       |    |    | <MDCNavigationBar>

This view hierarchy will be added to your view controller hierarchy using the convenience methods
outlined in the Usage docs below.

Note that it is possible to create each of the above components yourself, though we only encourage
doing so if the App Bar is limiting your ability to build something. In such a case we recommend
also [filing an issue](https://github.com/material-components/material-components-ios/issues/new) so that we can
identify whether your use case is something we can directly support.

### UINavigationItem and the App Bar

The App Bar begins mirroring the state of your view controller's `navigationItem` in the provided
`navigationBar` once you call `addSubviewsToParent`.

Learn more by reading the Navigation Bar section on
[Observing UINavigationItem instances](../../NavigationBar/#observing-uinavigationitem-instances).
Notably: read the section on "Exceptions" to understand which UINavigationItem are **not**
supported.

### Interacting with background views

Scenario: you've added a background image to your App Bar and you'd now like to be able to tap the
background image.

This is not trivial to do with the App Bar APIs due to considerations being discussed in
[Issue #184](https://github.com/material-components/material-components-ios/issues/184).

The heart of the limitation is that we're using a view (`headerStackView`) to lay out the Navigation
Bar. If you add a background view behind the `headerStackView` instance then `headerStackView` will
end up eating all of your touch events.

Until [Issue #184](https://github.com/material-components/material-components-ios/issues/184) is resolved, our
recommendation for building interactive background views is the following:

1. Do not use the App Bar component.
2. Create your own Flexible Header. Learn more by reading the Flexible Header
   [Usage](../../FlexibleHeader/#usage) docs.
3. Add your views to this flexible header instance.
4. Create a Navigation Bar if you need one. Treat it like any other custom view.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: Adding an app bar to your app](typical-use-adding-an-app-bar.md)

See the [FlexibleHeader](../../FlexibleHeader) documentation for additional usage guides.

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)
