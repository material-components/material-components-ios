### Typical use: floating action buttons

MDCFloatingButton is a subclass of MDCButton that implements the Material Design floating action
button style and behavior. Floating action buttons should be provided with a templated image for
their normal state and then themed accordingly.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Note: you'll need to provide your own image - the following is just an example.
let plusImage = UIImage(named: "plus").withRenderingMode(.alwaysTemplate)
let button = MDCFloatingButton()
button.setImage(plusImage, forState: .normal)
```

#### Objective-C

```objc
// Note: you'll need to provide your own image - the following is just an example.
UIImage *plusImage =
    [[UIImage imageNamed:@"plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
[button setImage:plusImage forState:UIControlStateNormal];
```
<!--</div>-->
