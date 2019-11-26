### Typography Theming

You can theme a tab bar with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod 'MaterialComponents/Tabs+TypographyThemer'
```
<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Step 1: Import the TypographyThemer extension
import MaterialComponents.MaterialTabs_TypographyThemer

// Step 2: Create or get a typography scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component
MDCTabBarTypographyThemer.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the TypographyThemer extension
#import "MaterialTabs+TypographyThemer.h"

// Step 2: Create or get a typography scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component
[MDCTabBarTypographyThemer applyTypographyScheme:colorScheme
     toTabBar:component];
```
<!--</div>-->
