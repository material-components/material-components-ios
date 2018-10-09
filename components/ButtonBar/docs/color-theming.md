### Color Theming

You can theme a button bar with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/ButtonBar+ColorThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialButtonBar_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCButtonBarColorThemer.applySemanticColorScheme(colorScheme, to:buttonBar)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialButtonBar+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCButtonBarColorThemer applySemanticColorScheme:colorScheme
     toButtonBar:buttonBar];
```
<!--</div>-->
