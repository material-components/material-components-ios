### Theming

You can theme an MDCDialog to match the Material Design Dialog using your app's schemes in the DialogThemer
extension.

Make sure the Dialog's Theming extension is added to your project:

```bash
pod 'MaterialComponents/Dialogs+Theming'
```

You can then import the extension and create an `MDCAlertControllerThemer` instance. A dialog scheme defines
the design parameters that you can use to theme your dialogs.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the DialogThemer extension
import MaterialComponents.MaterialDialogs_DialogThemer

// Step 2: Create or get a Material container scheme
let scheme = MDCContainerScheme()

// Step 3 (optional): Customize the default theme by providing custom color or typography schemes:
scheme.colorScheme = myColorScheme
scheme.typographyScheme = myTypographyScheme

// Step 4: Use Material alert themer to theme your MDCAlertController instance
alertController.applyTheme(withScheme: scheme)

// Step 4: Alternatively, Use Material dialog presentation themer to theme your UIViewController instance:
myDialogViewController.mdc_dialogPresentationController.applyTheme(withScheme: scheme)
```

#### Objective-C

```objc
// Step 1: Import the DialogThemer extension
#import "MaterialDialogs+DialogThemer.h"

// Step 2: Create or get a Material container scheme
MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];

// Step 3 (optional): Customize the default theme by providing custom color or typography schemes:
scheme.colorScheme = myColorScheme
scheme.typographyScheme = myTypographyScheme

// Step 4: Use the Material alert themer to theme an MDCAlertController instance
[alertController applyThemeWithScheme:scheme];

// Step 4: Alternatively, Use Material dialog presentation themer to theme your UIViewController instance:
[myDialogViewController.mdc_dialogPresentationController applyThemeWithScheme: scheme];

```
<!--</div>-->