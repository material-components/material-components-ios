> **_NOTE:_** This is currently in Beta. Features may change without warning and without a change in the Material 
> Components for iOS version number.

<div class="article__asset article__asset--screenshot">
    <img src="docs/assets/tabbarview-defaults-Fixed-Justified.png" alt="TabBarView showing only titles in a Justified Fixed Tabs layout." width="375">
</div>
<div class="article__asset article__asset--screenshot">
    <img src="docs/assets/tabbarview-defaults-Scrollable-Leading.png" alt="TabBarView showing only titles in a Scrollable layout." width="375">
</div>


### Importing MDCTabBarView

`MDCTabBarView` is currently part of the MaterialComponentsBeta podspec. You
may need to follow the [Material Components for iOS Beta integration
guide](https://github.com/material-components/material-components-ios/blob/develop/contributing/beta_components.md)
to configure your project to use `MDCTabBarView`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponentsBeta.MaterialTabs_TabBarView
```

#### Objective-C

```objc
#import "MaterialTabs+TabBarView.h"
```
<!--</div>-->

### Typical Use of MDCTabBarView

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let tabBarView = MDCTabBarView()
addSubview(tabBarView)

// Configure constraints
```

#### Objective-C

```objc
MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];
[self.view addSubview:tabBarView];

// Configure constraints
```
<!--</div>-->

### Migrating from MDCTabBar

#### Subclassing Restricted

Subclassing is not supported by `MDCTabBarView`. Any requirements that you have
for Material Tabs that are not met by the public APIs should be filed as a
feature request or bug against `MDCTabBarView`.

#### Selected Item Behavior

`MDCTabBarView` does not automatically mark any item as *selected* when the
`items` array is set, unless the previously-selected item is in the new
`items` array.  This is a change from `MDCTabBar`, but ensures that the view
and its APIs present equivalent information.

#### Colors, Fonts, and Theming

To set the image tint colors, use `- setImageTintColor:forState:`. The
`MDCTabBar` APIs, `- selectedItemTintColor` and `- unselectedItemTintColor` are
unavailable. 

To set the fonts of the labels, use `- setTitleFont:forState:`.
The `MDCTabBar` APIs, `- selectedItemTitleFont` and `- unselectedItemTitleFont`
are unavailable. Note that the tab bar may adjust the sizes of its views to
account for changes in fonts, and that can result in unexpected changes from
Fixed Tabs to Scrollable Tabs depending on font choices and title length.

`MDCTabBarView` uses Material Ripple by default (`MDCRippleView`) and does not
support Ink. You may configure the Ripple color for touch feedback by setting
the `- rippleColor` property.

#### Alignment and Item Rendering

The `MDCTabBar` API `itemAppearance` has no equivalent on `MDCTabBarView`.
Whatever relevant properties (*e.g.*, `title`, `image`) are provided on `UITabBarItem`
should be used instead.

The `MDCTabBar` APIs `displaysUppercaseTitles` and `titleTextTransform` have no
equivalent in `MDCTabBarView`. Titles are rendered as set on `UITabBarItem` and
`accessibilityLabel` should be set on the item if the title text is not
correctly handled by UIAccessibility.

#### UIBarPositioningDelegate

`MDCTabBarView` no longer conforms to `UIBarPositioning`, since Material Tabs
are always positioned above their related content views. As a result,
`MDCTabBarViewDelegate` does not inherit from `UIBarPositioningDelegate`.

#### Selection Indicator Template

The Selection Indicator Template APIs and protocols are copied nearly verbatim
from `MDCTabBar`, with the names changed to prevent collision. One difference
is the expected behavior of `contentFrame` as used by the indicator template.
In `MDCTabBar` the value of `contentFrame` was the union of the title and image
frames. However, in `MDCTabBarView` the width of the `contentFrame` is always
the width of the title (when present), and the height will include both the
title and image. This change is necessary to support internal clients.

#### Custom Views

Features like badges and horizontal layout of titles and images are not
supported on `MDCTabBarView`. Clients who need such behavior should implement
their own custom `UIView` and assign it to the `mdc_customView` property of a
`UITabBarItem` sublcass that conforms to `MDCTabBarItemCustomViewing`. A simple
subclass conforming to the `MDCTabBarItemCustomViewing` protocol is provided as
`MDCTabBarItem`.

<!--<div class="material-code-render" markdown="1">-->

##### Swift

```swift
let customView = MyCustomTabView()
let customItem = MDCTabBarItem()
customItem.mdc_customView = customView
let tabBarView = MDCTabBarView()
tabBarView.items = [ customItem ]
```

##### Objective-C

```objc
MyCustomTabView *customView = [[MyCustomTabView alloc] init];
MDCTabBarItem *customItem = [[MDCTabBarItem alloc] init];
customItem.mdc_customView = customView;
MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];
tabBarView.items = @[ customItem ]
```
<!--</div>-->

> **_NOTE:_** This will be updated as APIs are added and migrations are defined.
