### Typography Theming

You can theme a button bar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/ButtonBar+TypographyThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialButtonBar_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCButtonBarTypographyThemer.applyTypographyScheme(typographyScheme, to: buttonBar)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialButtonBar+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCButtonBarTypographyThemer applyTypographyScheme:colorScheme
     toButtonBar:buttonBar];
```
<!--</div>-->
