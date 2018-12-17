### Color Theming

You can theme an Action Sheet with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod `MaterialComponentsBeta/ActionSheet+ColorThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponentsBeta.MaterialActionSheet_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
let actionSheet = MDCActionSheetController()
MDCActionSheetColorThemer.applySemanticColorScheme(colorScheme, to: actionSheet)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialActionSheet+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSematnicColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
[MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                            toActionSheetController:actionSheet];
```
<!--</div>-->
