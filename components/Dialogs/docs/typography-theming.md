<!--docs:
title: "Typography Theming"
layout: detail
section: components
excerpt: "How to theme Dialogs using the Material Design typography system."
iconId: dialog
path: /catalog/dialogs/typography-theming/
-->

# Dialogs Typography Theming

You can theme a dialog with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/Dialogs+Extensions/TypographyThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialDialogs_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCAlertTypographyThemer.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialDialogs+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCAlertTypographyThemer applyTypographyScheme:colorScheme
     toAlertController:component];
```
<!--</div>-->
