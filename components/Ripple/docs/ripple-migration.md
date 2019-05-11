Ink and Ripple provide similar APIs: a view (`MDCInkView`, `MDCRippleView`), and a touch controller (`MDCInkTouchController`, `MDCRippleTouchController`). 

While Ripple and Ink’s implementations slightly vary, the public APIs are nearly identical. Furthermore, Ripple’s API does not produce additional side effects and can be used interchangeably.

These two notions make the migration path from Ink to Ripple relatively simple.

For guidance, these are the current naming differences that you need to pay attention to when migrating:

**`MDCInkView` vs `MDCRippleView`:**

<table>
  <tr>
    <td>`MDCInkView`</td>
    <td>`MDCRippleView`</td>
  </tr>
  <tr>
    <td>`animationDelegate`</td>
    <td>`rippleViewDelegate`</td>
  </tr>
  <tr>
    <td>`maxRippleRadius`</td>
    <td>`maximumRadius`</td>
  </tr>
  <tr>
    <td>`startTouchBeganAtPoint:animated:completion:`</td>
    <td>`beginRippleTouchDownAtPoint:animated:completion:`</td>
  </tr>
  <tr>
    <td>`startTouchEndAtPoint:animated:completion:`</td>
    <td>`beginRippleTouchUpAnimated:completion:`</td>
  </tr>
  <tr>
    <td>`inkAnimationDidStart:inkView`</td>
    <td>`rippleTouchDownAnimationDidBegin:rippleView`</td>
  </tr>
  <tr>
    <td>`inkAnimationDidEnd:inkView`</td>
    <td>`rippleTouchUpAnimationDidEnd:rippleView`</td>
  </tr>
</table>


*Other API differences are simply a regex replacement of: (1)Ink(2) to (1)Ripple(2) where (1) and (2) are [a-zA-Z]\*.*

**`MDCInkTouchController` vs `MDCRippleTouchController`:**

<table>
  <tr>
    <td> `MDCInkTouchController` </td>
    <td> `MDCRippleTouchController` </td>
  </tr>
  <tr>
    <td>`defaultInkView`</td>
    <td>`rippleView`</td>
  </tr>
  <tr>
    <td>`initWithView:` → `addInkView`</td>
    <td>2 ways:
1. `initWithView:` 
2. `init` → `addRippleToView:`</td>
  </tr>
</table>


*Other API differences are simply a regex replacement of: (1)Ink(2) to (1)Ripple(2) where (1) and (2) are [a-zA-Z]\*.*

**Based on the above guidance, the overall strategy to migrate Ink to Ripple in each component is as follows:**

*Skip to step 2 if we want to entirely replace Ink and not have Ripple as an opt-in feature*

* Provide an enableRippleBehavior bool property to allow to opt in to use Ripple instead of Ink (where the default to this property is NO). The setter of this Bool:

```objc
- (void)setEnableRippleBehavior:(BOOL)enableRippleBehavior {
  _enableRippleBehavior = enableRippleBehavior;

  if (enableRippleBehavior) {
    [self.inkView removeFromSuperview];
    self.rippleView.frame = self.bounds;
    [self insertSubview:self.rippleView belowSubview:X];
  } else {
    [self.rippleView removeFromSuperview];
    [self insertSubview:self.inkView belowSubview:X];
  }
}
```

* **If skipped to this step:** Replace all InkView/InkTouchController API calls with their RippleView/RippleTouchController counterparts.

  **If not:**Add the RippleView/RippleTouchController APIs beside their InkView/InkTouchController counterparts.

* **(Optional)** If the component itself has public APIs that use the term "Ink" like “InkStyle” or “InkColor”, the developer can decide if to add/modify APIs to use the term “Ripple”. But for a quick migration, the existing exposed APIs could remain and be reused.
