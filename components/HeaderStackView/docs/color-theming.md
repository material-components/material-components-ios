<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme Header Stack View using the Material Design color system."
iconId: header
path: /catalog/flexible-headers/header-stack-views/color-theming/
-->

# Header Stack View Color Theming

You can theme a header stack view with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/HeaderStackView+Extensions/ColorThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialHeaderStackView_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCHeaderStackViewColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialHeaderStackView+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCHeaderStackViewColorThemer applySemanticColorScheme:colorScheme
     toHeaderStackView:component];
```
<!--</div>-->
