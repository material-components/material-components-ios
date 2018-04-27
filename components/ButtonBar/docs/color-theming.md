<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme Button Bar using the Material Design color system."
iconId: button
path: /catalog/button-bars/color-theming/
-->

# Button Bar Color Theming

You can theme a button bar with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/ButtonBar+Extensions/ColorThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialButtonBar_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCButtonBarColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

``` objc
// Step 1: Import the ColorThemer extension
#import "MaterialButtonBar+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCButtonBarColorThemer applySemanticColorScheme:colorScheme
     toButtonBar:component];
```
<!--</div>-->
