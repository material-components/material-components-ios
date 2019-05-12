### Migration guide: Ink to Ripple

Ink and Ripple provide similar APIs: a view (`MDCInkView`, `MDCRippleView`), and a touch controller (`MDCInkTouchController`, `MDCRippleTouchController`). 

While Ripple and Ink’s implementations slightly vary, the public APIs are nearly identical. Furthermore, Ripple’s API does not produce additional side effects and can be used interchangeably.

These two notions make the migration path from Ink to Ripple relatively simple.

For guidance, these are the current naming differences that you need to pay attention to when migrating:

**`MDCInkView` vs `MDCRippleView`:**

|`MDCInkView`|`MDCRippleView`|
|---|---|
|`animationDelegate`|`rippleViewDelegate`|
|`maxRippleRadius`|`maximumRadius`|
|`startTouchBeganAtPoint:animated:completion:`|`beginRippleTouchDownAtPoint:animated:completion:`|
|`startTouchEndAtPoint:animated:completion:`|`beginRippleTouchUpAnimated:completion:`|
|`inkAnimationDidStart:inkView`|`rippleTouchDownAnimationDidBegin:rippleView`|
|`inkAnimationDidEnd:inkView`|`rippleTouchUpAnimationDidEnd:rippleView`|
|`inkStyle`|`rippleStyle`|
|`inkColor`|`rippleColor`|
|`cancelAllAnimationsAnimated:`|`cancelAllRipplesAnimated:completion:`|

**`MDCInkTouchController` vs `MDCRippleTouchController`:**

|`MDCInkTouchController`|`MDCRippleTouchController`|
|---|---|
|`defaultInkView`|`rippleView`|
|`initWithView:` → `addInkView`|`init` → `addRippleToView:`\*|
|`view`|`view`|
|`delegate`|`delegate`|
|`gestureRecognizer`|`gestureRecognizer`|
|`inkTouchController:insertInkView:intoView:`|`rippleTouchController:insertRippleView:intoView:`|
|`inkTouchController:shouldProcessInkTouchesAtTouchLocation:`|`rippleTouchController:shouldProcessRippleTouchesAtTouchLocation:`|
|`inkTouchController:didProcessInkTouchesAtTouchLocation:`|`rippleTouchController:didProcessRippleTouchesAtTouchLocation:`|

*\*Ripple provides a more convenient API if the ink's initialized view is the view that the ink is then added to. All you need is to initialize the ripple with `initWithView:` and there is no need to use an equivalent `addInkView` afterwards.*

**Based on the above guidance, the overall strategy to migrate Ink to Ripple in each component is as follows:**

* Provide an enableRippleBehavior bool property to allow to opt-in to use Ripple instead of Ink (where the default to this property is NO).

Component Header:
```objc
/*
 This property determines if an @c <#INSERT CLASS NAME> should use the @c MDCRippleView behavior or not.
 By setting this property to @c YES, @c MDCRippleView is used to provide the user visual
 touch feedback, instead of the legacy @c MDCInkView.
 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;
```

Component Implementation Setter:
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

* Add the RippleView/RippleTouchController APIs beside their InkView/InkTouchController counterparts.

* If the component itself has public APIs that use the term "Ink" like “InkStyle” or “InkColor”, the developer should add APIs to use the term “Ripple” instead. When Ink will eventually be deprecated, these APIs will be deprecated as part of that process. Another option instead of exposing specific Ripple APIs is to expose the `MDCRippleView` property in the public API.
