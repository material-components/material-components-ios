### Color Theming

You can theme an activity indicator with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/ActivityIndicator+ColorThemer'
```

Run `pod install` again.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialActivityIndicator_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCActivityIndicatorColorThemer.applySemanticColorScheme(colorScheme, to: activityIndicator)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialActivityIndicator+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

// Step 3: Apply the color scheme to your component
[MDCActivityIndicatorColorThemer applySemanticColorScheme:colorScheme
     toActivityIndicator:activityIndicator];
```
<!--</div>-->
