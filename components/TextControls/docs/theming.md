### Theming

You can theme a text field to match the Material Design style by importing a theming extension. The content below assumes you have read the article on [Theming](../../../docs/theming.md).

First, import the text field theming extension and create a text field.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialTextControls_OutlinedTextFieldsTheming

let textField = MDCOutlinedTextField()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialTextControls+FilledTextFieldsTheming.h>

MDCFilledTextField *filledTextField = [[MDCFilledTextField alloc] init];
```
<!--</div>-->

Then pass a container scheme to one of the theming methods on the theming extension.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
filledTextField.applyTheme(withScheme: containerScheme)
```

#### Objective-C
```objc
[self.filledTextField applyThemeWithScheme:self.containerScheme];
```
<!--</div>-->





