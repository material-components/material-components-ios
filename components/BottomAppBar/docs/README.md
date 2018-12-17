# App bars: bottom

<!-- badges -->

A bottom app bar displays navigation and key actions at the bottom of the screen. Bottom app bars
work like [navigation bars](../../NavigationBar), but with the additional option to show a
[floating action button](../../Buttons).

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/bottomappbar.png" alt="A screenshot of a bottom app bar." width="375">
</div>

<!-- design-and-api -->

<!-- toc -->

- - -

## Overview

Bottom app bars follow a recommended Material Design interaction design pattern for providing primary and secondary actions that are easily accessible. With a bottom app bar users are more easily able to use single-handed touch interaction with an application since actions are displayed close to the bottom of the screen within easy reach of a user's thumb.

The bottom app bar includes a <a href="https://material.io/components/ios/catalog/buttons/api-docs/Classes/MDCFloatingButton.html">floating action button</a> that is intended to provide users with a primary action. Secondary actions are available on a <a href="https://material.io/components/ios/catalog/flexible-headers/navigation-bars/">navigation bar</a> that can be customized with several buttons on the left and right sides of the navigation bar. The primary action floating action button is centered on the bottom app bar by default.

MDCBottomAppBarView should be attached to the bottom of the screen or used in conjunction with an expandable bottom drawer. The MDCBottomAppBarView API includes properties that allow changes to the elevation, position and visibility of the embedded floating action button.

UIBarButtonItems can be added to the navigation bar of the MDCBottomAppBarView. Leading and trailing navigation items will be shown and hidden based on the position of the floating action button.

Transitions between floating action button position, elevation and visibility states are animated by default, but can be disabled if desired.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use](typical-use.md)

## Extensions

- [Color Theming](color-theming.md)

## Accessibility

- [Accessibility](accessibility.md)
