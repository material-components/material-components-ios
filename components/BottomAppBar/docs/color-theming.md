<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme Bottom App Bar using the Material Design color system."
iconId: bottom_app_bar
path: /catalog/bottomappbar/color-theming/
-->

# Bottom App Bar Color Theming

You can theme a bottom app bar with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/BottomAppBar+Extensions/ColorThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialBottomAppBar_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
<#color_themer_api#>.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

``` objc
// Step 1: Import the ColorThemer extension
#import "MaterialBottomAppBar+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[<#color_themer_api#> applySemanticColorScheme:colorScheme
     to<#themer_parameter_name#>:component];
```
<!--</div>-->
