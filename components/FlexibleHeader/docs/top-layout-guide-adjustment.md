### Adjusting the top layout guide of a view controller

If your content view controller depends on the top layout guide being adjusted — e.g. if the
content does not have a tracking scroll view and therefore relies on the top layout guide to perform
layout calculations — then you should consider setting `topLayoutGuideViewController` to the
content view controller.

Setting this property does two things:

1. Adjusts the view controller's `topLayoutGuide` property to take the flexible header into account
   (most useful pre-iOS 11).
2. On iOS 11 and up — if there is no tracking scroll view — also adjusts the
   `additionalSafeAreaInsets` property to take the flexible header into account.

**Note:** `topLayoutGuideAdjustmentEnabled` is automatically enabled if this property is set.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.topLayoutGuideViewController = contentViewController
```

#### Objective-C

```objc
flexibleHeaderViewController.topLayoutGuideViewController = contentViewController;
```
<!--</div>-->
