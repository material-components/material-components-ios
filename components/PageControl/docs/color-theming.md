<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme Page Control using the Material Design color system."
iconId: <#icon_id#>
path: /catalog/page-controls/color-theming/
-->

# Page Control Color Theming

You can theme a page control with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/PageControl+Extensions/ColorThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialPageControl_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCPageControlColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

``` objc
// Step 1: Import the ColorThemer extension
#import "MaterialPageControl+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCPageControlColorThemer applySemanticColorScheme:colorScheme
     to<#themer_parameter_name#>:component];
```
<!--</div>-->
