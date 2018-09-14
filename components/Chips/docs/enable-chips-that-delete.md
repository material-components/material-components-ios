If within your `MDCChipField` you want chips that can be deleted follow these steps.

### Accessibility

Enabling this flag will add 24x24 touch targets within the chip view. This goes against Google's recommended 
48x48 touch targets. We recommend if you enable this behavior your associate it with a `MDCSnackbar` or 
`MDCDialog` to confirm allow the user to confirm their behavior.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let chipField = MDCChipField()
chipField.showChipsDeleteButton = true
```

#### Objective-C
```objc
MDCChipField *chipField = [[MDCChipField alloc] init];
chipField.showChipsDeleteButton = YES;
```
<!--</div>-->
