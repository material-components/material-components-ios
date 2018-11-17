## Accessibility

To help ensure your Action Sheet is accessible to as many users as possible, please be sure to reivew the following
recommendations:

The scrim by default enables the "Z" gesture to dismiss. If `isScrimAccessibilityElement` is not set or is set to
`false` then `scrimAccessibilityLabel`, `scrimAccessibilityHint`, and `scrimAccessibilityTraits` will
have any effect.

### Set `-isScrimAccessibilityElement`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.isScrimAccessibilityElement = true
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.isScrimAccessibilityElement = YES;
```
<!--</div>-->

### Set `-scrimAccessibilityLabel`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.scrimAccessibilityLabel = "Cancel"
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.scrimAccessibilityLabel = @"Cancel";
```
<!--</div>-->

### Set `-scrimAccessibilityHint`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.scrimAccessibilityHint = "Dismiss the action sheet"
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.scrimAccessibilityHint = @"Dismiss the action sheet";
```

<!--</div>-->

### Set `-scrimAccessibilityTraits`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.scrimAccessibilityTraits = UIAccessibilityTraitButton
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.scrimAccessibilityTraits = UIAccessibilityTraitButton;
```
<!--</div>-->
