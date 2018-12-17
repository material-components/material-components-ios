### Typical use: using the `MDCBottomDrawerViewController` with/without a header.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = UIViewController()
bottomDrawerViewController.headerViewController = UIViewController() # this is optional
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = [UIViewController new];
bottomDrawerViewController.headerViewController = [UIViewController new];
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->