### Typical use: View controller containment, as a navigation controller

The easiest integration path for using the app bar is through the `MDCAppBarNavigationController`.
This API is a subclass of UINavigationController that automatically adds an
`MDCAppBarViewController` instance to each view controller that is pushed onto it, unless an app bar
or flexible header already exists.

When using the `MDCAppBarNavigationController` you will, at a minimum, need to configure the added
app bar's background color using the delegate.

#### Example

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let navigationController = MDCAppBarNavigationController()
navigationController.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)

// MARK: MDCAppBarNavigationControllerDelegate

func appBarNavigationController(_ navigationController: MDCAppBarNavigationController,
                                willAdd appBarViewController: MDCAppBarViewController,
                                asChildOf viewController: UIViewController) {
  appBarViewController.headerView.backgroundColor = <#(UIColor)#>
}
```

#### Objective-C

```objc
MDCAppBarNavigationController *navigationController =
    [[MDCAppBarNavigationController alloc] init];
[navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>];

#pragma mark - MDCAppBarNavigationControllerDelegate

- (void)appBarNavigationController:(MDCAppBarNavigationController *)navigationController
       willAddAppBarViewController:(MDCAppBarViewController *)appBarViewController
           asChildOfViewController:(UIViewController *)viewController {
  appBarViewController.headerView.backgroundColor = <#(nonnull UIColor *)#>;
}
```
<!--</div>-->
