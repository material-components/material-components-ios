### Theming Extensions

You can theme an MDCDialog to match the Material Design Dialog using your app's scheme and the Dialogs theming
extension. To add the theming extension to your project add the following line to your Podfile:

```bash
pod 'MaterialComponents/Dialogs+Theming'
```

Then import the theming extension and the `MDCContainerScheme` and create an `MDCContainerScheme` instance. A container scheme 
defines the design parameters that you can use to theme your dialogs. Finally, call the appropriate method on the theming extension.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the Dialog theming extension and container scheme
import MaterialComponents.MaterialDialogs_Theming
import MaterialComponents.MaterialContainerScheme

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

### Theming Actions

Actions in MDCAlertController have emphasis which affects how the Dialog's buttons will be themed.
High, Medium and low emphasis are supported.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/dialogButtons.png" alt="An alert presented with a title, body, high-emphasis 'OK' button and low-emphasis 'Cancel' button." width="320">
</div>

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
  // Create or reuse a Container scheme
  let scheme = MDCContainerScheme()

  // Create an Alert dialog
  let alert = MDCAlertController(title: "Button Theming", message: "Add item to cart?")

  // Add actions with emphases that will generate buttons with the desired appearance. 
  // An example of a high and a medium emphasis actions:
  alert.addAction(MDCAlertAction(title:"Add Item", emphasis: .high, handler: handler))
  alert.addAction(MDCAlertAction(title:"Cancel", emphasis: .medium, handler: handler))

  // Make sure to apply theming after all actions are added, so they are themed too!
  alert.applyTheme(withScheme: scheme)

  // present the alert
  present(alertController, animated:true, completion:nil)
```

#### Objective-C

```objc
  // Create or reuse a Container scheme
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];

  // Create an Alert dialog
  MDCAlertController *alert = 
      [MDCAlertController alertControllerWithTitle:@"Button Theming" message:@"Add item to cart?"];

  // Add actions with different emphasis, creating buttons with different themes.
  MDCAlertAction *primaryAction = [MDCAlertAction actionWithTitle:@"Add Item"
                                                          emphasis:MDCActionEmphasisHigh
                                                           handler:handler];
  [alert addAction:primaryAction];

  MDCAlertAction *cancelAction = [MDCAlertAction actionWithTitle:@"Cancel"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:handler];
  [alert addAction:cancelAction];

  // Make sure to apply theming after all actions are added, so they are themed too!
  [alert applyThemeWithScheme:scheme];

  // present the alert
  [self presentViewController:alert animated:YES completion:...];
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
