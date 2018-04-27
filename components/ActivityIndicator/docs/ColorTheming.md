<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme Activity Indicator using the Material Design color system."
iconId: progress_activity
path: /catalog/progress-indicators/activity-indicators/ColorTheming/
-->

# Activity Indicator Color Theming

You can theme an activity indicator with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/ActivityIndicator+Extensions/ColorThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialActivityIndicator_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCActivityIndicatorColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

``` objc
// Step 1: Import the ColorThemer extension
#import "MaterialActivityIndicator+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCActivityIndicatorColorThemer applySemanticColorScheme:colorScheme
     toActivityIndicator:component];
```
<!--</div>-->
