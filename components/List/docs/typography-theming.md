### Typography Theming

You can theme a List Item cell with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod `MaterialComponents/List+TypographyThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialList_TypographyThemer

// Step 2: Create or get a color scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
MDCListTypographyThemer.applyTypographyScheme(typographyScheme, to: cell)
```

#### Objective-C

```objc
// Step 1: Import the Typography extension
#import "MaterialList+TypographyThemer.h"

// Step 2: Create or get a color scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
[MDCListTypographyThemer applyTypographyScheme:self.typographyScheme
                                    toBaseCell:cell];
```
<!--</div>-->
