### usesSuperviewShadowLayerAsMask migration

tl;dr: If you are adding ripples to views with custom `layer.shadowPath` values, please disable
`usesSuperviewShadowLayerAsMask` and assign an explicit layer mask to the ripple view if needed
instead. usesSuperviewShadowLayerAsMask will eventually be disabled by default and then deleted.

MDCRippleView currently implements a convenience behavior that will inherit its parent view's
`layer.shadowPath` as the mask of the ripple view itself. This works for the general case where the
ripple view's frame equals the bounds of its super view, but behaves unexpectedly for any other
frame of the ripple view.

Due to the brittleness of this behavior, a new migration property, `usesSuperviewShadowLayerAsMask`,
has been added that will allow you to disable this behavior in favor of a more explicit
determination of the ripple's layer mask.

Example usage:

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// During initialization:
rippleView.usesSuperviewShadowLayerAsMask = false

// Simple example of applying a mask to the ripple view using the ripple view's bounds:
let rippleViewMask = CAShapeLayer()
rippleViewMask.path = UIBezierPath(rect: rippleView.bounds).cgPath
rippleView.layer.mask = rippleViewMask
```

#### Objective-C

```objc
// During initialization:
rippleView.usesSuperviewShadowLayerAsMask = NO;

// Simple example of applying a mask to the ripple view using the ripple view's bounds:
CAShapeLayer *rippleViewMask = [[CAShapeLayer alloc] init];
rippleViewMask.path = [UIBezierPath bezierPathWithRect:rippleView.bounds].CGPath;
rippleView.layer.mask = rippleViewMask;
```
<!--</div>-->

Please consider disabling `usesSuperviewShadowLayerAsMask` if you are creating MDCRippleView
instances. The property will be disabled by default in the future and then deprecated.
