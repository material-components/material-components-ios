### Creating a text field

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let estimatedFrame = ...
let textField = MDCFilledTextField(frame: estimatedFrame)
textField.label.text = "This is the floating label"
textField.leadingAssistiveLabel.text = "This is helper text"
textField.sizeToFit()
view.addSubview(textField)
```

#### Objective-C

```objc
CGRect estimatedFrame = ...
MDCOutlinedTextField *textField = [[MDCOutlinedTextField alloc] initWithFrame:estimatedFrame];
textField.label.text = "This is the floating label";
textField.leadingAssistiveLabel.text = "This is helper text";
[textField sizeToFit];
[view addSubview:textField];
```

<!--</div>-->
