### Typical use: using the `MDCBottomDrawerViewController` with a need for performant scrolling.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let contentViewController = UITableViewController()
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = contentViewController
// This is optional, however if a `headerViewController` is not provided, it is recommended to set
// the `bottomDrawerViewController`'s `shouldUseStickyStatusBar` property to `YES` to prevent the
// drawer content from potentially overlapping with the status bar content.
bottomDrawerViewController.headerViewController = UIViewController()
bottomDrawerViewController.trackingScrollView = contentViewController.view
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
UITableViewController *contentViewController = [UITableViewController new];
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = contentViewController;
// This is optional, however if a `headerViewController` is not provided, it is recommended to set
// the `bottomDrawerViewController`'s `shouldUseStickyStatusBar` property to `YES` to prevent the
// drawer content from potentially overlapping with the status bar content.
bottomDrawerViewController.headerViewController = [UIViewController new];
bottomDrawerViewController.trackingScrollView = contentViewController.view;
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->