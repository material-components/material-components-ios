<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme Text Fields using the Material Design color system."
iconId: text_field
path: /catalog/textfields/color-theming/
-->

# Text Fields Color Theming

You can theme a text field with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/TextFields+Extensions/ColorThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialTextFields_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component

// Applying to a text field
MDCTextFieldColorThemer.apply(colorScheme, to: textField)

// Applying to an input controller
MDCTextFieldColorThemer.applySemanticColorScheme(colorScheme, to: inputController)

// Applying to a specific class type of inputController
MDCTextFieldColorThemer.applySemanticColorScheme(colorScheme, 
    toAllControllersOfClass: MDCTextInputControllerUnderline.self)
```

#### Objective-C

``` objc
// Step 1: Import the ColorThemer extension
#import "MaterialTextFields+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component

// Applying to a text field
[MDCTextFieldColorThemer applySemanticColorScheme:colorScheme toTextInput:textField];

// Applying to an input controller
[MDCTextFieldColorThemer applySemanticColorScheme:colorScheme
                            toTextInputController:inputController];

// Applying to a specific class type of inputController
[MDCTextFieldColorThemer applySemanticColorScheme:colorScheme 
                 toAllTextInputControllersOfClass:[MDCTextInputControllerUnderline class]];
```
<!--</div>-->
