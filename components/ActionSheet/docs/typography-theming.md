### Typography Theming

You can theme an Action Sheet with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod `MaterialComponentsBeta/ActionSheet+TypographyThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponentsBeta.MaterialActionSheet_TypographyThemer

// Step 2: Create or get a color scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the color scheme to your component
let actionSheet = MDCActionSheetController()
MDCActionSheetTypographyThemer.applyTypographyScheme(typographyScheme, to: actionSheet)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialActionSheet+TypographyThemer.h"

// Step 2: Create or get a color scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the color scheme to your component
MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
[MDCActionSheetTypographyThemer applyTypographyScheme:self.typographyScheme
                              toActionSheetController:actionSheet];
```
<!--</div>-->
