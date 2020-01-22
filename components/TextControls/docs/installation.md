### Installation with CocoaPods

Add any of the following to your `Podfile`, depending on which TextControl target you're interested in:

```bash
pod 'MaterialComponents/TextControls+FilledTextFields'
pod 'MaterialComponents/TextControls+FilledTextFieldsTheming'
pod 'MaterialComponents/TextControls+OutlinedTextFields'
pod 'MaterialComponents/TextControls+OutlinedTextFieldsTheming'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To use TextControls in your code, import the appropriate MaterialTextControls umbrella header (Objective-C) or MaterialComponents module (Swift).

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_FilledTextFieldsTheming
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextFieldsTheming
```

#### Objective-C

```objc
#import "MaterialTextControls+FilledTextFields.h"
#import "MaterialTextControls+FilledTextFieldsTheming.h"
#import "MaterialTextControls+OutlinedTextFields.h"
#import "MaterialTextControls+OutlinedTextFieldsTheming.h"
```

<!--</div>-->

