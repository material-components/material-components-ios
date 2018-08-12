### Removing safe area insets from the min/max heights

The minimum and maximum height values of the flexible header view assume by default that the values
include the top safe area insets value. This assumption no longer holds true on devices with a
physical safe area inset and it never held true when flexible headers were shown in non full screen
settings (such as popovers on iPad).

This behavioral flag is enabled by default, but will eventually be disabled by default and the flag
will eventually be removed.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.headerView.minMaxHeightIncludesSafeArea = false
```

#### Objective-C

```objc
flexibleHeaderViewController.headerView.minMaxHeightIncludesSafeArea = NO;
```
<!--</div>-->
