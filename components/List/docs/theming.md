## Theming

You can theme a List Item with your app's shared scheme using the MaterialList Theming extension.

You must first add the theming extension to your project:

```bash
pod `MaterialComponents/List+Theming`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Step 1: Import the theming extension
import MaterialComponents.MaterialList_Theming

// Step 2: Create a shared container scheme. A shared scheme should be created once in your app and
// shared with all components.
let containerScheme = MDCContainerScheme()

// Step 3: Apply the scheme to each cell - from within `collectionView(_:cellForItemAt:)`
cell.applyTheme(withScheme:containerScheme)
```

#### Objective-C

```objc
// Step 1: Import the theming extension
#import "MaterialList+Theming.h"

// Step 2: Create a shared container scheme. A shared scheme should be created once in your app and
// shared with all components.
id<MDCContainerScheming> containerScheme = [[MDCContainerScheme alloc] init];

// Step 3: Apply the scheme to each cell - from within `-collectionView:cellForItemAtIndexPath:`
[cell applyThemeWithScheme:containerScheme];
```
<!--</div>-->
