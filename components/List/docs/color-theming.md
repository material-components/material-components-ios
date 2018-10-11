### Color Theming

You can theme a List Item with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod `MaterialComponents/List+ColorThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialList_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
MDCListColorThemer.applySemanticColorScheme(colorScheme, to: cell)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialList+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSematnicColorScheme alloc] init];

// Step 3: Apply the color scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
[MDCListColorThemer applySemanticColorScheme:colorScheme
                                  toBaseCell:cell];
```
<!--</div>-->
