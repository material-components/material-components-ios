<!--docs:
title: "Theming"
layout: detail
section: components
excerpt: "How to theme Buttons using Material Design systems."
iconId: button
path: /catalog/buttons/theming/
-->

# Buttons Theming

You can theme buttons with your app's schemes using the ButtonThemer extension.

You must first add the Button Themer extension to your project:

``` bash
pod 'MaterialComponents/Buttons+Extensions/ButtonThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the ButtonThemer extension
import MaterialComponents.MaterialButtons_ButtonThemer

// Step 2: Create or get a button scheme
let buttonScheme = MDCButtonScheme()

// Step 3: Apply the button scheme to your component using the desired button style
MDCContainedButtonThemer.applyScheme(buttonScheme, to: component)
MDCTextButtonThemer.applyScheme(buttonScheme, to: component)
```

#### Objective-C

``` objc
// Step 1: Import the ButtonThemer extension
#import "MaterialButtons+ButtonThemer.h"

// Step 2: Create or get a button scheme
MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];

// Step 3: Apply the button scheme to your component using the desired button style
[MDCContainedButtonThemer applyScheme:buttonScheme toButton:component];
[MDCTextButtonThemer applyScheme:buttonScheme toButton:component];
```
<!--</div>-->
