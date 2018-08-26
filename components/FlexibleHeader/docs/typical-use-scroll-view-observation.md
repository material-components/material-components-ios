### Enabling observation of the tracking scroll view

If you do not require the flexible header's shift behavior, then you can avoid having to manually
forward UIScrollViewDelegate events to the flexible header by enabling
`observesTrackingScrollViewScrollEvents` on the flexible header view. Observing the tracking
scroll view allows the flexible header to over-extend, if enabled, and allows the header's shadow to
show and hide itself as the content is scrolled.

**Note:** if you support pre-iOS 11 then you will also need to explicitly clear your tracking scroll
view in your deinit/dealloc method.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.headerView.observesTrackingScrollViewScrollEvents = true

deinit {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  appBarViewController.headerView.trackingScrollView = nil
}
```

#### Objective-C

```objc
flexibleHeaderViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}
```
<!--</div>-->

**Note:** if `observesTrackingScrollViewScrollEvents` is enabled then you can neither enable shift
behavior nor manually forward scroll view delegate events to the flexible header.
