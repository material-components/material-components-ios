### Theming extensions

You can theme an MDCDialog to match the Material Design Dialog using your app's schemes in the Dialog theming
extension.

You must first add the Dialog theming extension to your project, by following the standard 
[beta component](../../../contributing/beta_components.md) steps.

You can then import the theming extension and create an `MDCContainerScheme` instance. A container scheme 
defines the design parameters that you can use to theme your dialogs.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the Dialog theming extension and container scheme
import MaterialComponentsBeta.MaterialDialogs_Theming
import MaterialComponentsBeta.MaterialContainerScheme

// Step 2: Create or get a container scheme
let containerScheme = MDCContainerScheme()

// Step 3: Apply the container scheme to your component using the desired alert style
alertController.applyTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Step 1: Import the Dialog theming extension and container scheme
#import "MaterialDialogs+Theming.h"
#import "MaterialContainerScheme.h"

// Step 2: Create or get a container scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Step 3: Apply the container scheme to your component using the desired alert style
[alertController applyThemeWithScheme:containerScheme];
```
<!--</div>-->

### Using a Themer

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
