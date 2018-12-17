## Examples - Multi Line

### Text Field with Floating Placeholder

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let textFieldFloating = MDCMultilineTextField()
scrollView.addSubview(textFieldFloating)

textFieldFloating.placeholder = "Full Name"
textFieldFloating.textView.delegate = self

textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating) // Hold on as a property
```

#### Objective-C

``` objc
MDCMultilineTextField *textFieldFloating = [[MDCMultilineTextField alloc] init];
[self.scrollView addSubview:textFieldFloating];

textFieldFloating.placeholder = @"Full Name";
textFieldFloating.textView.delegate = self;

self.textFieldControllerFloating = [[MDCTextInputControllerUnderline alloc] initWithTextInput:textFieldFloating];
```
<!--</div>-->

### Text Field with Character Count and Inline Placeholder

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
// First the text field component is setup just like a UITextField
let textFieldDefaultCharMax = MDCMultilineTextField()
scrollView.addSubview(textFieldDefaultCharMax)

textFieldDefaultCharMax.placeholder = "Enter up to 50 characters"
textFieldDefaultCharMax.textView.delegate = self

// Second the controller is created to manage the text field
textFieldControllerDefaultCharMax = MDCTextInputControllerUnderline(textInput: textFieldDefaultCharMax) // Hold on as a property
textFieldControllerDefaultCharMax.characterCountMax = 50
textFieldControllerDefaultCharMax.isFloatingEnabled = false
```

#### Objective-C

``` objc
// First the text field component is setup just like a UITextField
MDCMultilineTextField *textFieldDefaultCharMax = [[MDCMultilineTextField alloc] init];
[self.scrollView addSubview:textFieldDefaultCharMax];

textFieldDefaultCharMax.placeholder = @"Enter up to 50 characters";
textFieldDefaultCharMax.textView.delegate = self;

// Second the controller is created to manage the text field
self.textFieldControllerDefaultCharMax = [[MDCTextInputControllerUnderline alloc] initWithTextInput: textFieldDefaultCharMax];
self.textFieldControllerDefaultCharMax.characterCountMax = 50;
self.textFieldControllerDefaultCharMax.floatingEnabled = NO;
```
<!--</div>-->
