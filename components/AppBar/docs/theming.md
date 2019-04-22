### Theming

`MDCAppBarViewController` supports Material Theming using a Container Scheme.
There are two variants for Material Theming of an AppBar.  The Surface Variant colors the App Bar
background to be `surfaceColor` and the Primary Variant colors the App Bar background to be
`primaryColor`.

<!--<div class="material-code-render" markdown="1">-->

#### Swift

```swift
// Import the AppBar Theming Extensions module
import MaterialComponents.MaterialAppBar_Theming

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
#import "MaterialAppBar+Theming.h"

...

// Apply your app's Container Scheme to the App Bar controller
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Either Primary Theme
[self.appBarController applyPrimaryThemeWithScheme:containerScheme];

// Or Surface Theme
[self.appBarController applySurfaceThemeWithScheme:containerScheme];
```

<!--</div>-->
