### Theming Extensions

You can theme an MDCTextField using the TextFields theming extension. To add the theming extension to your project add the following line to your Podfile:

```bash
pod 'MaterialComponents/TextFields+Theming'
```

Then import the theming extension and the `MDCContainerScheme` and create an `MDCContainerScheme` instance. A container scheme
defines schemes for subsystems like Color and Typography. Finally, call theming methods on the theming extension of your MDCTextInputController instance.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TextFields theming extension and container scheme
import MaterialComponents.MaterialTextFields_Theming
import MaterialComponents.MaterialContainerScheme

// Step 2: Create or get a container scheme
let containerScheme = MDCContainerScheme()

// Step 3: Apply the container scheme to your component using the desired alwert style
textInputController.applyTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Step 1: Import the TextField theming extension and container scheme
#import "MaterialTextFields+Theming.h"
#import "MaterialContainerScheme.h"

// Step 2: Create or get a container scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Step 3: Apply the container scheme to your component using the desired alert style
[textInputController applyThemeWithScheme:containerScheme];
```
<!--</div>-->
