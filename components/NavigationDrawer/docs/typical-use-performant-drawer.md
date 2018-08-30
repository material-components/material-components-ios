### Typical use: using the `MDCBottomDrawerViewController` with a need for performant scrolling.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let contentViewController = UITableViewController()
let bottomDrawerViewController = MDCBottomDrawerViewController()
bottomDrawerViewController.contentViewController = contentViewController
bottomDrawerViewController.headerViewController = UIViewController() # this is optional
bottomDrawerViewController.trackingScrollView = contentViewController.view
present(bottomDrawerViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
UITableViewController *contentViewController = [UITableViewController new];
MDCBottomDrawerViewController *bottomDrawerViewController = [[MDCBottomDrawerViewController alloc] init];
bottomDrawerViewController.contentViewController = contentViewController;
bottomDrawerViewController.headerViewController = [UIViewController new];
bottomDrawerViewController.trackingScrollView = contentViewController.view;
[self presentViewController:bottomDrawerViewController animated:YES completion:nil];
```
<!--</div>-->