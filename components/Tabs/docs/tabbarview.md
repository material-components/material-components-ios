> **_NOTE:_** This is currently in Beta. Features may change without warning and without a change in the Material 
> Components for iOS version number.

### Importing MDCTabBarView

`MDCTabBarView` is currently part of the MaterialComponentsBeta podspec. You may need to follow the [Material Components for iOS
Beta integration guide](https://github.com/material-components/material-components-ios/blob/develop/contributing/beta_components.md) to configure
your project to use `MDCTabBarView`.

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

> **_NOTE:_** This will be updated as APIs are added and migrations are defined.
