### Migration guide: minMaxHeightIncludesSafeArea

Deprecation schedule:

- October 16, 2018: minMaxHeightIncludesSafeArea will be disabled by default.
- October 23, 2018: minMaxHeightIncludesSafeArea will be marked deprecated.
- November 23, 2018: minMaxHeightIncludesSafeArea will be deleted.

`minMaxHeightIncludesSafeArea` is a behavioral flag on `MDCFlexibleHeaderView that must be disabled
to ensure iPhone X compatibility.

When this property is enabled (the legacy behavior), the `minimumHeight` and `maximumHeight` values
are expected to include the device's top safe area insets in their value. This means it is the
responsibility of the client to update these height values with the values of the top safe area
insets.

When you disable this property you are expected to set `minimumHeight` and `maximumHeight` to only
the height of the content that would be displayed below the top safe area insets.

We intend to eventually **disable** `minMaxHeightIncludesSafeArea` by default and remove the
property altogether. As such, you are encouraged to proactively disable this property now anywhere
that you use a FlexibleHeader.

Example usage:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
headerViewController.headerView.minMaxHeightIncludesSafeArea = false
headerViewController.headerView.maximumHeight = 128
headerViewController.headerView.minimumHeight = 56
```

#### Objective-C
```objc
headerViewController.headerView.minMaxHeightIncludesSafeArea = NO;
headerViewController.headerView.maximumHeight = 128;
headerViewController.headerView.minimumHeight = 56;
```
<!--</div>-->
