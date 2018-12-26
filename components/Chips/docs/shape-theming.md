### Shape Theming

You can theme a chip with your app's shape scheme using the ShapeThemer extension.

You must first add the ShapeThemer extension to your project:

```bash
pod 'MaterialComponents/Chips+ShapeThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ShapeThemer extension
import MaterialComponents.MaterialChips_ShapeThemer

// Step 2: Create or get a shape scheme
let shapeScheme = MDCShapeScheme()

// Step 3: Apply the shape scheme to your component
MDCChipViewShapeThemer.applyShapeScheme(shapeScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ShapeThemer extension
#import "MaterialChips+ShapeThemer.h"

// Step 2: Create or get a shape scheme
id<MDCShapeScheming> shapeScheme = [[MDCShapeScheme alloc] init];

// Step 3: Apply the shape scheme to your component
[MDCChipViewShapeThemer applyShapeScheme:shapeScheme
     toChipView:component];
```
<!--</div>-->
