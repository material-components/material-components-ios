# Navigation Bar

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/navigation_bar.png" alt="Navigation Bar" width="320">
</div>

The Navigation Bar component is a view composed of a left and right Button Bar and either a title
label or a custom title view.

Consistent with iOS design guidelines, the title in the navigation bar is centered by default. However, certain use cases may warrant use of a left aligned title such as: when there is a strong relationship between the title and additional content appearing in the navigation bar, or where centering the title causes ambiguity.

<!-- design-and-api -->

## Related components

* [ProgressView](../../ProgressView)

<!-- toc -->

- - -

## Overview

Navigation Bar is a drop-in replacement for UINavigationBar with a few notable exceptions:

- No navigationItem stack. Instances of MDCNavigationBar must be explicitly provided with a back
  button. TODO(featherless): Explain how to create a back button with Navigation Bar once
  https://github.com/material-components/material-components-ios/issues/340 lands.

The MDCNavigationBar class is a composition of two button bars and a title label or
title view. The left and right Button Bars are provided with the navigation item's corresponding bar
button items.

Read the button bar section on
[UIBarButtonItem properties](../../ButtonBar/#uibarbuttonitem-properties) to learn more about
supported UIBarButtonItem properties.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Observing UINavigationItem instances](observing-navigationitem-instances.md)

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)
