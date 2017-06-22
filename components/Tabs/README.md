<!--docs:
title: "Tabs"
layout: detail
section: components
excerpt: "Tabs make it easy to explore and switch between different views."
iconId: tabs
path: /catalog/tabs/
-->

# Tabs

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/tabs.png" alt="Tabs" width="375">
</div>

Tabs are bars of buttons used to navigate between groups of content.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/components/tabs.html">Material Design guidelines: Tabs</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 9.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the
following to your `Podfile`:

```
pod 'MaterialComponents/Tabs'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

- - -

## Overview

When a user taps a tab, the content changes to match the selected subject in the tabs.

We provide this functionality through MDCTabBar which communicates via a delegate as well as
MDCTabBarViewController which provides a view containment model similar to UITabViewController.

Tabs can also show a badge (usually a number) like UITabBar.

- - -

## Usage

### Importing

To use the tab bar in your code, import the MaterialTabs umbrella header (Objective-C) or MaterialComponents module (Swift).

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
import MaterialComponents
```

#### Objective-C

``` objc
#import "MaterialTabs.h"
```

<!--</div>-->

### Delegate

Conform your class to the MDCTabBarDelegate protocol and set it as the tab bar's delegate to handle updating the UI when the user selects a tab.

### Selected item

Update the selected tab programmatically by setting `selectedItem`, optionally with an animation. Delegate methods are not called for programmatic changes, so callers are responsible for updating UI as needed after updating the selected item.

### Appearance

Set the `itemAppearance` property on the tab bar to switch between item display modes. Items can be displayed as titles (the default), icons, or combined.

### Styling

By default, the tab bar is configured to display items with white text and icons. To customize the color of the tab bar, set the `tintColor`, `selectedItemTintColor`, `unselectedItemTintColor`, `inkColor`, and `barTintColor` properties. If `selectedItemTintColor` is nil, the tab bar's `tintColor` will be used automatically for selected items.

Configure where items are placed in the tab bar by setting the `alignment` property.

### Bottom navigation

Implement `positionForBar:` and return `UIBarPositionBottom` to configure the tab bar as a bottom
navigation bar. The bar will automatically update with the appropriate styling.

- - -

## Example

### Creating a tab bar

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let tabBar = MDCTabBar(frame: view.bounds)
tabBar.items = [
UITabBarItem(title: "Recents", image: UIImage(named: "phone"), tag: 0),
UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 0),
]
tabBar.itemAppearance = .titledImages
tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
tabBar.sizeToFit()
view.addSubview(tabBar)
```

#### Objective-C

``` objc
MDCTabBar *tabBar = [[MDCTabBar alloc] initWitFrame:self.view.bounds];
tabBar.items = @[
    [[UITabBarItem alloc] initWithTitle:@"Recents" image:[UIImage imageNamed:@"phone"] tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"heart"] tag:0],
];
tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
tabBar.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
[tabBar sizeToFit];
[self.view addSubview:tabBar];
```

<!--</div>-->
