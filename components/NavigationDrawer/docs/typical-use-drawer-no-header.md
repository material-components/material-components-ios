### Typical use: presenting in a drawer without a header.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let contentViewController = UIViewController()
contentViewController.transitioningDelegate = MDCBottomDrawerTransitionController()
contentViewController.modalPresentationStyle = .custom
present(contentViewController, animated: true, completion: nil)
```

#### Objective-C

```objc
UIViewController *contentViewController = [UIViewController new];
contentViewController.transitioningDelegate = [MDCBottomDrawerTransitionController new];
contentViewController.modalPresentationStyle = UIModalPresentationCustom;
[self presentViewController:contentViewController animated:YES completion:nil];
```
<!--</div>-->