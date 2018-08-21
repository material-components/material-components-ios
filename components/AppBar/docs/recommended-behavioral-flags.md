### Recommended behavioral flags

The app bar component and its dependencies include a variety of flags that affect the behavior of
the `MDCAppBarViewController`. Many of these flags represent feature flags that we are using
to allow client teams to migrate from an old behavior to a new, usually less-buggy one.

You are encouraged to set all of the behavioral flags immediately after creating an instance of the
app bar.

The minimal set of recommended flag values are:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Enables support for iPad popovers and extensions.
// Automatically enables topLayoutGuideAdjustmentEnabled as well, but does not set a
// topLayoutGuideViewController.
appBarViewController.inferTopSafeAreaInsetFromViewController = true

// Enables support for iPhone X safe area insets.
appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
```

#### Objective-C

```objc
// Enables support for iPad popovers and extensions.
// Automatically enables topLayoutGuideAdjustmentEnabled as well, but does not set a
// topLayoutGuideViewController.
appBarViewController.inferTopSafeAreaInsetFromViewController = YES;

// Enables support for iPhone X safe area insets.
appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;
```
<!--</div>-->
