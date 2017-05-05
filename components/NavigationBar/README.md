<!--docs:
title: "Navigation Bar"
layout: detail
section: components
excerpt: "The Navigation Bar component is a view composed of a left and right Button Bar and either a title label or a custom title view."
iconId: toolbar
path: /catalog/navigation-bars/
-->

# Navigation Bar

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/navigation_bar.png" alt="Navigation Bar" width="320">
</div>

The Navigation Bar component is a view composed of a left and right Button Bar and either a title
label or a custom title view.
<!--{: .article__intro }-->

Consistent with iOS design guidelines, the title in the navigation bar is centered by default. However, certain use cases may warrant use of a left aligned title such as: when there is a strong relationship between the title and additional content appearing in the navigation bar, or where centering the title causes ambiguity.
<!--{: .article__intro }-->

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/layout/structure.html">Layout Structure</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/NavigationBar'
```

Then, run the following command:

``` bash
pod install
```



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




- - -

## Usage

### Importing

Before using Navigation Bar, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialNavigationBar
```

#### Objective-C

``` objc
#import "MaterialNavigationBar.h"
```
<!--</div>-->

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
``` swift
navigationBar.observe(navigationItem)
```

#### Objective-C
``` objc
[navigationBar observeNavigationItem:self.navigationItem];
```
<!--</div>-->

#### Stopping observation

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
navigationBar.unobserveNavigationItem()
```

#### Objective-C
``` objc
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

