<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/Tabs/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios/tree/develop/components/Tabs">GitHub</a> for README documentation.{% endif %}-->

# Tabs

<!--{% if site.link_to_site == "true" %}-->
<a alt="Tab Bar"><img src="docs/assets/tab_bar.png" width="320px"></a>
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/tab_bar.mp4" autoplay loop></video></div>{% endif %}-->

Tabs are bars of buttons used to navigate between groups of content.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://material.google.com/components/tabs.html">
      Tabs
    </a>
  </li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 9.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the
following to your `Podfile`:

~~~
pod 'MaterialComponents/Tabs'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Overview

When a user taps a tab, the content should change to match the selected subject in the tabs. This is similar to a UITabBarViewController's behavior. But unlike a UITabBarViewController, tabs does not provide an interface for switching the views or view controllers. There is no array of view controllers like UITabBarViewController's array of view controllers.

Rather, the tabs report to their delegate when there is a tab selection. The delegate can then handle the changing of views.

Tabs can also show a badge (usually a number) like UITabBar.

- - -

## Usage

### Importing

To use the tab bar in your code, import the MaterialTabs umbrella header (Objective-C) or MaterialComponents module (Swift).

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
import MaterialComponents
~~~

#### Objective-C

~~~ objc
#import "MaterialTabs.h"
~~~

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

- - -

## Example

### Creating a tab bar

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
let tabBar = MDCTabBar(frame: view.bounds)
tabBar.items = [
UITabBarItem(title: "Recents", image: UIImage(named: "phone"), tag: 0),
UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 0),
]
tabBar.itemAppearance = .titledImages
tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
tabBar.sizeToFit()
view.addSubview(tabBar)
~~~

#### Objective-C

~~~ objc
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
~~~

<!--</div>-->
