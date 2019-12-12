### Importing

Before using Typography, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialTypography
```

#### Objective-C

```objc
#import "MaterialTypography.h"
```
<!--</div>-->

### Font
Select a font most appropriate to its usage and set it as your label's font. All fonts are returned
from class methods beginning with the font's Material Design type style and ending with 'Font'.
Material Typography should be used consistently throughout the entire UI.

### Opacity
Each font has a respective opacity (alpha) value returned by class methods beginning with the
font's Material Design type style and ending with 'FontOpacity'. These CGFloats should be set on the
label's alpha property. If animating alpha, it should be the maximum value reached.
