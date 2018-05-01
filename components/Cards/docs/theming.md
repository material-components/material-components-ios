<!--docs:
title: "Theming"
layout: detail
section: components
excerpt: "How to theme Card using Material Design systems."
iconId: list
path: /catalog/cards/theming/
-->

# Card Theming

You can theme a card with your app's schemes using the CardThemer extension.

You must first add the Card Themer extension to your project:

```bash
pod 'MaterialComponents/Cards+Extensions/CardThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the CardThemer extension
import MaterialComponents.MaterialCards_CardThemer

// Step 2: Create or get a card scheme
let cardScheme = MDCCardScheme()

// Step 3: Apply the card scheme to your component
MDCCardThemer.applyScheme(cardScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the CardThemer extension
#import "MaterialCards+CardThemer.h"

// Step 2: Create or get a card scheme
MDCCardScheme *colorScheme = [[MDCCardScheme alloc] init];

// Step 3: Apply the card scheme to your component
[MDCCardThemer applyScheme:cardScheme toCard:component];
```
<!--</div>-->
