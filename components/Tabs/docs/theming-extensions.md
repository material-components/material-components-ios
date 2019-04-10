### Theming Extensions (Beta)

 `MDCTabBar` supports Material Theming using a Container Scheme. The code is currently
in Beta readiness, which means you will need to follow the [instructions for adding the
MaterialComponentsBeta podspec to your
project](https://github.com/material-components/material-components-ios/blob/73bdc03c2bd2abd032b0b69f05cd76928361aa37/contributing/beta_components.md#beta-program-for-components).
There are two variants for Material Theming of a MDCTabBar, which are the Primary color variant
and the Surface color variant.

 <!--<div class="material-code-render" markdown="1">-->

 #### Swift

 ```swift
// Import the Tabs Theming Extensions module
import MaterialComponentsBeta.MaterialTabs_MaterialTheming
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
#import <MaterialComponentsBeta/MaterialTabBar+MaterialTheming.h>
 ...
 // Create or use your app's Container Scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
 // Theme the tab bar with either Primary Theme
[self.tabBar applyPrimaryThemeWithScheme:containerScheme];
 // Or Surface Theme
[self.tabBar applySurfaceThemeWithScheme:containerScheme];
```

<!--</div>-->
