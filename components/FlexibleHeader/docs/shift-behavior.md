### Shifting a flexible header off-screen

A flexible header that tracks a scroll view will expand and contract its height in reaction to
scroll view events. A flexible header can also shift off-screen in reaction to scroll view events
by changing the flexible header's behavior.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
headerViewController.headerView.shiftBehavior = .enabled
```

#### Objective-C
```objc
headerViewController.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
```
<!--</div>-->

> Important: when a flexible header shifts off-screen it **will not hide the content views**. Your
> content views are responsible for hiding themselves in reaction to the flexible header shifting
> off-screen. Read the section on [Reacting to frame changes](#reacting-to-frame-changes) for more
> information.

It is also possible to hide the status bar when shifting the flexible header off-screen. Enable this
behavior by setting the `enabledWithStatusBar` behavior and implementing
`childViewControllerForStatusBarHidden` on the parent view controller.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
headerViewController.headerView.shiftBehavior = .enabledWithStatusBar

override func childViewControllerForStatusBarHidden() -> UIViewController? {
  return headerViewController
}
```

#### Objective-C
```objc
headerViewController.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;

- (UIViewController *)childViewControllerForStatusBarHidden {
  return _headerViewController;
}
```
<!--</div>-->
