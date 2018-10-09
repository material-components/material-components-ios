### Typical use: themed buttons

Create an instance of `MDCButton` and theme it with as one of the Material Design button styles
using the ButtonThemer extension. Once themed, use the button like you would use a typical UIButton
instance.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let button = MDCButton()

// Themed as a text button:
MDCTextButtonThemer.applyScheme(buttonScheme, to: button)
```

#### Objective-C

```objc
MDCButton *button = [[MDCButton alloc] init];

// Themed as a text button:
[MDCTextButtonThemer applyScheme:buttonScheme toButton:button];
```
<!--</div>-->

See the [ButtonThemer documentation](theming.md) for a full list of supported Material Design
button styles.
