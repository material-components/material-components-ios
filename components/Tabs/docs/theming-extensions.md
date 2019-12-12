### Theming Extensions

`MDCTabBar` supports Material Theming using a Container Scheme.
There are two variants for Material Theming of a MDCTabBar, which are the Primary Theme
and the Surface Theme.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

```swift
// Import the Tabs Theming Extensions module
import MaterialComponents.MaterialTabs_MaterialTheming
 ...
 // Create or use your app's Container Scheme
let containerScheme = MDCContainerScheme()
 // Theme the tab bar with either Primary Theme
tabBar.applyPrimaryTheme(withScheme: containerScheme)
 // Or Surface Theme
tabBar.applySurfaceTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Import the Tabs Theming Extensions header
#import <MaterialComponents/MaterialTabBar+MaterialTheming.h>
 ...
 // Create or use your app's Container Scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
 // Theme the tab bar with either Primary Theme
[self.tabBar applyPrimaryThemeWithScheme:containerScheme];
 // Or Surface Theme
[self.tabBar applySurfaceThemeWithScheme:containerScheme];
```

<!--</div>-->
