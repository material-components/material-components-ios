### Theming

You can theme a card with your app's schemes using the CardThemer extension.

MDCCardThemer exposes apis to theme MDCCard and MDCCardCollectionCell instances as either a default or outlined variant. An outlined variant behaves identically to a default styled card, but differs in its coloring and in that it has a stroked border. Use 'applyScheme:toCard:' to style an instance with default values and 'applyOutlinedVariantWithScheme:toCard:' to style an instance with the outlined values.

You must first add the Card Themer extension to your project:

```bash
pod 'MaterialComponents/Cards+CardThemer'
```

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
