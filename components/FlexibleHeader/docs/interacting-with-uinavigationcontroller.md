### Interacting with UINavigationController

Push a view controller with a flexible header onto UINavigationController and you may find that
the existing UINavigationBar is undesired. The most obvious example occurs when your flexible header
has its own navigation bar.

If this is the case then we recommend hiding the UINavigationController's `navigationBar` during
UIViewController appearance events: `viewWillAppear:` or `viewWillDisappear:`. Changing the
navigation bar's visibility during these events gives the highest likelihood of your navigation bar
animating in/out in a reasonable manner.

> Important: Hiding UINavigationController's navigationBar nullifies UINavigationController's swipe-
> to-go-back feature. To continue using this feature whilst hiding the navigationBar, read the
> section on [Enabling Swipe to Go Back With Hidden NavigationBar](#enabling-swipe-to-go-back-with-hidden-navigationbar).

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
override func viewWillAppear(animated: Bool) {
  super.viewWillAppear(animated)

  navigationController?.setNavigationBarHidden(true, animated: animated)
}
```

#### Objective-C
```objc
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}
```
<!--</div>-->

Add the following to view controllers that don't have an app bar:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
override func viewWillAppear(animated: Bool) {
  super.viewWillAppear(animated)

  navigationController?.setNavigationBarHidden(false, animated: animated)
}
```

#### Objective-C
```objc
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:NO animated:animated];
}
```
<!--</div>-->

If all of your view controllers use the App Bar in a given UINavigationController then you can
simply hide the navigationBar when you create the navigation controller. **Don't forget to do this
at app restoration time!**

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
navigationController.setNavigationBarHidden(false, animated: false)
```

#### Objective-C
```objc
UINavigationController *navigationController = ...;
[navigationController setNavigationBarHidden:NO animated:NO];
```
<!--</div>-->
