<!--docs:
title: "Typography Theming"
layout: detail
section: components
excerpt: "How to theme Navigation Bar using the Material Design typography system."
iconId: toolbar
path: /catalog/flexible-headers/navigation-bars/typography-theming/
-->

# Navigation Bar Typography Theming

You can theme a navigation bar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/NavigationBar+Extensions/TypographyThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialNavigationBar_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCNavigationBarTypographyThemer.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialNavigationBar+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCNavigationBarTypographyThemer applyTypographyScheme:colorScheme
     toNavigationBar:component];
```
<!--</div>-->
