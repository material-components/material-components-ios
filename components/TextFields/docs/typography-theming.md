<!--docs:
title: "Typography Theming"
layout: detail
section: components
excerpt: "How to theme Text Fields using the Material Design typography system."
iconId: text_field
path: /catalog/textfields/typography-theming/
-->

# Text Fields Typography Theming

You can theme a text field with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

``` bash
pod 'MaterialComponents/TextFields+Extensions/TypographyThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialTextFields_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCTextFieldTypographyThemer.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

``` objc
// Step 1: Import the TypographyThemer extension
#import "MaterialTextFields+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCTextFieldTypographyThemer applyTypographyScheme:colorScheme
     to<#themer_parameter_name#>:component];
```
<!--</div>-->
