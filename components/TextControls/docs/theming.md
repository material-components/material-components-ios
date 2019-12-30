### Theming

You can theme a text field to match the Material Design style by using a theming extension. The content below assumes you have read the article on [Theming](../../../docs/theming.md).

First, import the theming extension for TextControls and create a text field.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialTextControls
import MaterialComponents.MaterialTextControls_Theming

let textField = MDCOutlinedTextField()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialTextControls.h>
#import <MaterialComponents/MaterialTextControls+Theming.h>

MDCFilledTextField *filledTextField = [[MDCFilledTextField alloc] init];
```
<!--</div>-->

Then pass a container scheme to one of the theming methods on a theming extension.

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





