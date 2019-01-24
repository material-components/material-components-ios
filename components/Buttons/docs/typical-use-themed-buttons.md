### Typical use: themed buttons

Create an instance of `MDCButton` and theme it with as one of the Material Design button styles
using the button theming extension. Once themed, use the button like you would use a typical UIButton
instance.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let button = MDCButton()

// Themed as a text button:
button.applyTextTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
MDCButton *button = [[MDCButton alloc] init];

// Themed as a text button:
[button applyTextThemeWithScheme:containerScheme];
```
<!--</div>-->

See the [button theming documentation](theming.md) for a full list of supported Material Design
button styles.
