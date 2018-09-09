### Color Theming

Note: At present, Bottom App Bar only has a "Surface Variant" color themer for the Material Design color
system.

- Task: [Implement a primary variant color
  themer](https://github.com/material-components/material-components-ios/issues/3929)

You can theme a Bottom App Bar with your app's color scheme using the ColorThemer extension.

You must first add the ColorThemer extension to your project:

```ruby
pod 'MaterialComponents/BottomAppBar+ColorThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension and Buttons Themers
import MaterialComponents.MaterialBottomAppBar_ColorThemer
import MaterialComponents.MaterialButtons_ButtonThemer

// Step 2: Create or get a color scheme and typography scheme
let colorScheme = MDCSemanticColorScheme()
let typgoraphyScheme = MDCTypographyScheme()
let buttonScheme = MDCButtonScheme()
buttonScheme.colorScheme = colorScheme
buttonScheme.typographyScheme = typographyScheme

// Step 3: Apply the button scheme to the Bottom App Bar's floating button and
// the color scheme to your Bottom App Bar
MDCFloatingActionButtonThemer.applyScheme(buttonScheme, to: bottomBarView.floatingButton)
MDCBottomAppBarColorThemer.applySurfaceVariant(withSemanticColorScheme: colorScheme,
                                               to: bottomBarView)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension and Buttons Themers
#import "MaterialBottomAppBar+ColorThemer.h"
#import "MaterialButtons+ButtonThemer.h"

// Step 2: Create or get a color scheme and typography scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];
MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
buttonScheme.colorScheme = colorScheme;
buttonScheme.typographyScheme = typographyScheme;

// Step 3: Apply the button scheme to the Bottom App Bar's floating button and
// the color scheme to your Bottom App Bar
[MDCFloatingActionButtonThemer applyScheme:buttonScheme
                                  toButton:self.bottomBarView.floatingButton];
[MDCBottomAppBarColorThemer applySurfaceVariantWithSemanticColorScheme:colorScheme
                                                    toBottomAppBarView:bottomAppBarView];
```
<!--</div>-->

