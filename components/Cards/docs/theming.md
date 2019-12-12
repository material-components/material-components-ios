### Theming

 `MDCCard` supports Material Theming using a Container Scheme.
There are two variants for Material Theming of a MDCCard and MDCCardCollectionCell, which are the default theme
and the outlined theme.

 <!--<div class="material-code-render" markdown="1">-->

 #### Swift

```swift
// Import the Cards Theming Extensions module
import MaterialComponents.MaterialCards_MaterialTheming
 ...
 // Create or use your app's Container Scheme
let containerScheme = MDCContainerScheme()
 // Theme the card with either default theme
card.applyTheme(withScheme: containerScheme)
 // Or outlined theme
card.applyOutlinedTheme(withScheme: containerScheme)
```

 #### Objective-C

```objc
// Import the Cards Theming Extensions header
#import <MaterialComponents/MaterialCards+MaterialTheming.h>
 ...
 // Create or use your app's Container Scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
 // Theme the card with either default theme
[self.card applyThemeWithScheme:containerScheme];
 // Or outlined theme
[self.card applyOutlinedThemeWithScheme:containerScheme];
```

<!--</div>-->
