To help ensure your bottom app bar is accessible to as many users as possible, please be sure to review the
following recommendations:

### Set `-accessibilityLabel`

Set an appropriate
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel)
to all buttons within the bottom app bar.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
bottomAppBar.floatingButton.accessibilityLabel = "Compose"
let trailingButton = UIBarButtonItem()
trailingButton.accessibilityLabel = "Buy"
bottomAppBar.trailingBarButtonItems = [ trailingButton ]
```

#### Objective-C

```objc
bottomAppBar.floatingButton.accessibilityLabel = @"Compose";
UIBarButtonItem *trailingButton = 
    [[UIBarButtonItem alloc] initWithTitle:nil
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(didTapTrailing:)];
trailingButton.accessibilityLabel = @"Buy";
[bottomAppBar setTrailingBarButtonItems:@[ trailingButton ]];
```
<!--</div>-->

### Set `-accessibilityHint`

Set an appropriate
[`accessibilityHint`](https://developer.apple.com/documentation/objectivec/nsobject/1615093-accessibilityhint)
to all buttons within the bottom app bar.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
bottomAppBar.floatingButton.accessibilityHint = "Create new email"
let trailingButton = UIBarButtonItem()
trailingButton.accessibilityHint = "Purchase the item"
bottomAppBar.trailingBarButtonItems = [ trailingButton ]
```

#### Objective-C

```objc
bottomAppBar.floatingButton.accessibilityHint = @"Create new email";
UIBarButtonItem *trailingButton = 
    [[UIBarButtonItem alloc] initWithTitle:nil
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(didTapTrailing:)];
trailingButton.accessibilityHint = @"Purchase the item";
[bottomAppBar setTrailingBarButtonItems:@[ trailingButton ]];
```
<!--</div>-->
