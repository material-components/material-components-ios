### Typography Theming

You can theme an snackbar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/Snackbar+TypographyThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialSnackbar_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCSnackbarTypographyThemer.applyTypographyScheme(typographyScheme)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialSnackbar+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCSnackbarTypographyThemer applyTypographyScheme:colorScheme];
```
<!--</div>-->
