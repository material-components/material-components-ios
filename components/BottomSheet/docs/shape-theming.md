### Shape Theming

You can theme a bottom sheet with your app's shape scheme using the ShapeThemer extension.

You must first add the ShapeThemer extension to your project:

```bash
pod 'MaterialComponents/BottomSheet+ShapeThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ShapeThemer extension
import MaterialComponents.MaterialBottomSheet_ShapeThemer

// Step 2: Create or get a shape scheme
let shapeScheme = MDCShapeScheme()

// Step 3: Apply the shape scheme to your component
MDCBottomSheetControllerShapeThemer.applyShapeScheme(shapeScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ShapeThemer extension
#import "MaterialBottomSheet+ShapeThemer.h"

// Step 2: Create or get a shape scheme
id<MDCShapeScheming> shapeScheme = [[MDCShapeScheme alloc] init];

// Step 3: Apply the shape scheme to your component
[MDCBottomSheetControllerShapeThemer applyShapeScheme:shapeScheme
     toBottomSheetController:component];
```
<!--</div>-->
