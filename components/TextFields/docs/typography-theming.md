### Text Fields Typography Theming

You can theme a text field with your app's typography scheme using the `TypographyThemer` extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/TextFields+TypographyThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialTextFields_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component

// Applying to a text field
MDCTextFieldTypographyThemer.apply(typographyScheme, to: textField)

// Applying to an input controller
MDCTextFieldTypographyThemer.apply(typographyScheme, to: inputController)

// Applying to a specific class type of inputController
MDCTextFieldTypographyThemer.apply(typographyScheme, 
    toAllControllersOfClass: MDCTextInputControllerUnderline.self) 
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialTextFields+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component

// Applying to a text field
[MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme toTextInput:textField];

// Applying to an input controller
[MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme
                              toTextInputController:inputController];

// Applying to a specific class type of inputController
[MDCTextFieldTypographyThemer applyTypographyScheme:typographyScheme 
                   toAllTextInputControllersOfClass:[MDCTextInputControllerUnderline class]];
```
<!--</div>-->
