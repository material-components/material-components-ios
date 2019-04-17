### Theming Extensions (Beta)

`MDCAppBarViewController` supports Material Theming using a Container Scheme. The code is currently
in Beta readiness, which means you will need to follow the [instructions for adding the
MaterialComponentsBeta podspec to your project](https://github.com/material-components/material-components-ios/blob/develop/contributing/beta_components.md).
There are two variants for Material Theming of an AppBar.  The Surface Variant colors the App Bar
background to be `surfaceColor` and the Primary Variant colors the App Bar background to be
`primaryColor`.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

```swift
// Import the AppBar Theming Extensions module
import MaterialComponentsBeta.MaterialAppBar_MaterialTheming

...

// Apply your app's Container Scheme to the App Bar controller
let containerScheme = MDCContainerScheme()

// Either Primary Theme
appBarViewController.applyPrimaryTheme(withScheme: containerScheme)

// Or Surface Theme
appBarViewController.applySurfaceTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Import the AppBar Theming Extensions header
#import <MaterialComponentsBeta/MaterialAppBar+MaterialTheming.h>

...

// Apply your app's Container Scheme to the App Bar controller
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Either Primary Theme
[self.appBarController applyPrimaryThemeWithScheme:containerScheme];

// Or Surface Theme
[self.appBarController applySurfaceThemeWithScheme:containerScheme];
```

<!--</div>-->
