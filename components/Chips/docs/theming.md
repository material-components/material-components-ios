### Theming

 `MDCChipView` supports Material Theming using a Container Scheme.
There are two variants for Material Theming of an MDCChipVIew, which are the default theme
and the outlined theme.

 <!--<div class="material-code-render" markdown="1">-->

 #### Swift

```swift
// Import the Chips Theming Extensions module
import MaterialComponents.MaterialChips_MaterialTheming
 ...
 // Create or use your app's Container Scheme
let containerScheme = MDCContainerScheme()
 // Theme the chip with either default theme
chip.applyTheme(withScheme: containerScheme)
 // Or outlined theme
chip.applyOutlinedTheme(withScheme: containerScheme)
```

 #### Objective-C

```objc
// Import the Tabs Theming Extensions header
#import <MaterialComponents/MaterialChips+MaterialTheming.h>
 ...
 // Create or use your app's Container Scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
 // Theme the chip with either default theme
[self.chip applyThemeWithScheme:containerScheme];
 // Or outlined theme
[self.chip applyOutlinedThemeWithScheme:containerScheme];
```

<!--</div>-->
