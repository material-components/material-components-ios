### Typical use: using the `MDCBottomDrawerViewController` without a header.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = UIViewController()
// This is optional, but is recommended to prevent the drawer content from potentially overlapping with
// the status bar content.
bottomDrawerViewController.shouldUseStickyStatusBar = true
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = [UIViewController new];
// This is optional, but is recommended to prevent the drawer content from potentially overlapping with
// the status bar content.
bottomDrawerViewController.shouldUseStickyStatusBar = YES;
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->