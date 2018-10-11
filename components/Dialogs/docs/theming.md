### Theming

You can theme an MDCDialog to match the Material Design Dialog using your app's schemes in the DialogThemer
extension.

You must first add the DialogThemer extension to your project:

```bash
pod 'MaterialComponents/Dialogs+DialogThemer'
```

You can then import the extension and create an `MDCAlertControllerThemer` instance. A dialog scheme defines
the design parameters that you can use to theme your dialogs.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the DialogThemer extension
import MaterialComponents.MaterialDialogs_DialogThemer

// Step 2: Create or get a alert scheme
let alertScheme = MDCAlertScheme()

// Step 3: Apply the alert scheme to your component using the desired alert style
MDCAlertControllerThemer.applyScheme(scheme, to: alertController)
```

#### Objective-C

```objc
// Step 1: Import the DialogThemer extension
#import "MaterialDialogs+DialogThemer.h"

// Step 2: Create or get a alert scheme
MDCAlertScheme *alertScheme = [[MDCAlertScheme alloc] init];

// Step 3: Apply the alert scheme to your component using the desired alert style
[MDCAlertControllerThemer applyScheme:alertScheme toAlertController:alertController];
```
<!--</div>-->
