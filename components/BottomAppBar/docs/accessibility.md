To help ensure your bottom app bar is accessible to as many users as possible, please be sure to review the
following recommendations:

### Set `-accessibilityLabel`

Set an appropriate
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel)
to all buttons within the bottom app bar.

#### Swift

```swift
bottomAppBar.floatingButton.accessibilityLabel = "Compose"
```

#### Objective-C

```objc
bottomAppBar.floatingButton.accessibilityLabel = "Compose"
```

If you do not do this then the button's label will be the name of the image.

#### Swift

```swift
let image = UIImage(named: "Edit")
bottomAppBar.floatingButton.setImage(image, for: .normal)
```

#### Objective-C
```objc
UIImage *image = [UIImage imageNamed:@"Edit"];
[bottomAppBar.floatingButton setImage:image forState:UIControlStateNormal];
```

### Set `-accessibilityHint`

Set an appropriate
[`accessibilityHint`](https://developer.apple.com/documentation/objectivec/nsobject/1615093-accessibilityhint)
to all buttons within the bottom app bar.

#### Swift

```swift
bottomAppBar.floatingButton.accessibilityHint = "Create new email"
```

#### Objective-C

```objc
bottomAppBar.floatingButton.accessibilityHint = "Create new email"
```
