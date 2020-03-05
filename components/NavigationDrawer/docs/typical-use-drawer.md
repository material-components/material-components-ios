### Typical use: using the `MDCBottomDrawerViewController` with/without a header.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = UIViewController()
// This is optional, however if a `headerViewController` is not provided, it is recommended to set
// the `bottomDrawerViewController`'s `shouldUseStickyStatusBar` property to `YES` to prevent the
//drawer content from potentially overlapping with the status bar content.
bottomDrawerViewController.headerViewController = UIViewController()
// This following two properties are optional, but recommended if targeting devices on iOS 11.0 or later.
bottomDrawerVC.shouldIncludeSafeAreaInContentHeight = true
bottomDrawerVC.shouldIncludeSafeAreaInInitialDrawerHeight = true
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = [UIViewController new];
// This is optional, however if a `headerViewController` is not provided, it is recommended to set
// the `bottomDrawerViewController`'s `shouldUseStickyStatusBar` property to `YES` to prevent the
// drawer content from potentially overlapping with the status bar content.
bottomDrawerViewController.headerViewController = [UIViewController new];
// This following two properties are optional, but recommended if targeting devices on iOS 11.0 or later.
bottomDrawerVC.shouldIncludeSafeAreaInContentHeight = YES;
bottomDrawerVC.shouldIncludeSafeAreaInInitialDrawerHeight = YES;
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->