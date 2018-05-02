<!--docs:
title: "Navigation Bar"
layout: detail
section: components
excerpt: "The Navigation Bar component is a view composed of a left and right Button Bar and either a title label or a custom title view."
iconId: toolbar
path: /catalog/flexible-headers/navigation-bars/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme NavigationBar -->

# Navigation Bar

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/navigation_bar.png" alt="Navigation Bar" width="320">
</div>

The Navigation Bar component is a view composed of a left and right Button Bar and either a title
label or a custom title view.

Consistent with iOS design guidelines, the title in the navigation bar is centered by default. However, certain use cases may warrant use of a left aligned title such as: when there is a strong relationship between the title and additional content appearing in the navigation bar, or where centering the title causes ambiguity.

## API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/flexible-headers/navigation-bars/api-docs/Classes/MDCNavigationBar.html">API: MDCNavigationBar</a></li>
</ul>

## Related components

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../ProgressView">ProgressView</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Observing UINavigationItem instances](#observing-uinavigationitem-instances)
- [Extensions](#extensions)
# [Color Theming](#color-theming)
# [Typography Theming](#typography-theming)

- - -

## Overview

Navigation Bar is a drop-in replacement for UINavigationBar with a few notable exceptions:

- No navigationItem stack. Instances of MDCNavigationBar must be explicitly provided with a back
  button. TODO(featherless): Explain how to create a back button with Navigation Bar once
  https://github.com/material-components/material-components-ios/issues/340 lands.

The MDCNavigationBar class is a composition of two [Button Bars](../ButtonBar) and a title label or
title view. The left and right Button Bars are provided with the navigation item's corresponding bar
button items.

Read the Button Bar section on
[UIBarButtonItem properties](../ButtonBar/#uibarbuttonitem-properties) to learn more about supported
UIBarButtonItem properties.

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/NavigationBar'
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
import MaterialComponents.MaterialNavigationBar
```

#### Objective-C

```objc
#import "MaterialNavigationBar.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/observing-navigationitem-instances.md -->

### Observing UINavigationItem instances

MDCNavigationBar can observe changes made to a navigation item property much like how a
UINavigationBar does. This feature is the recommended way to populate the navigation bar's
properties because it allows your view controllers to continue using `navigationItem` as expected,
with a few exceptions outlined below.

> If you intend to use UINavigationItem observation it is recommended that you do not directly set
> the navigation bar properties outlined in `MDCUINavigationItemObservables`. Instead, treat the
> observed `navigationItem` object as the single source of truth for your navigationBar's state.

#### Starting observation

To begin observing a UINavigationItem instance you must call `observeNavigationItem:`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
navigationBar.observe(navigationItem)
```

#### Objective-C
```objc
[navigationBar observeNavigationItem:self.navigationItem];
```
<!--</div>-->

#### Stopping observation

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
navigationBar.unobserveNavigationItem()
```

#### Objective-C
```objc
[navigationBar unobserveNavigationItem];
```
<!--</div>-->

#### Exceptions

All of the typical properties including UIViewController's `title` property will affect the
Navigation Bar as you'd expect, with the following exceptions:

- None of the `animated:` method varients are supported because they do not implement KVO events.
  Use of these methods will result in the Navigation Bar becoming out of sync with the
  navigationItem properties.
- `prompt` is not presently supported. https://github.com/material-components/material-components-ios/issues/230.



## Extensions

<!-- Extracted from docs/color-theming.md -->

# Color Theming

You can theme a navigation bar with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/NavigationBar+Extensions/ColorThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialNavigationBar_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCNavigationBarColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialNavigationBar+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCNavigationBarColorThemer applySemanticColorScheme:colorScheme
     toNavigationBar:component];
```
<!--</div>-->

<!-- Extracted from docs/typography-theming.md -->

# Typography Theming

You can theme a navigation bar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/NavigationBar+Extensions/TypographyThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialNavigationBar_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCNavigationBarTypographyThemer.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialNavigationBar+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCNavigationBarTypographyThemer applyTypographyScheme:colorScheme
     toNavigationBar:component];
```
<!--</div>-->

