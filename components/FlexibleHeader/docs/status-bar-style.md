### Status bar style

MDCHeaderViewController instances are able to recommend a status bar style by inspecting the
background color of the MDCFlexibleHeaderView. If you'd like to use this logic to automatically
update your status bar style, implement `childViewControllerForStatusBarStyle` in your app's view
controller.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
override var childViewControllerForStatusBarStyle: UIViewController? {
  return headerViewController
}
```

#### Objective-C
```objc
- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.headerViewController;
}
```
<!--</div>-->
