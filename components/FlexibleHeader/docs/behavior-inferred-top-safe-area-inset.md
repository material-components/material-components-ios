### Enabling inferred top safe area insets

Prior to this behavioral flag, the flexible header always assumed that it was presented in a
full-screen capacity, meaning it would be placed directly behind the status bar or device bezel
(such as the iPhone X's notch). This assumption does not support extensions and iPad popovers.

Enabling the `inferTopSafeAreaInsetFromViewController` flag tells the flexible header to use its
view controller ancestry to extract a safe area inset from its context, instead of relying on
assumptions about placement of the header.

This behavioral flag is disabled by default, but will eventually be enabled by default and the flag
will eventually be removed.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.inferTopSafeAreaInsetFromViewController = true
```

#### Objective-C

```objc
flexibleHeaderViewController.inferTopSafeAreaInsetFromViewController = YES;
```
<!--</div>-->

**Note:** if this flag is enabled and you've also provided a `topLayoutGuideViewController`, take
care that the `topLayoutGuideViewController` is not a direct ancestor of the flexible header or your
app **will** enter an infinite loop. As a general rule, your `topLayoutGuideViewController` should
be a sibling to the flexible header.
