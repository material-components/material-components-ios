### Reacting to frame changes

In order to react to flexible header frame changes you can set yourself as the
MDCFlexibleHeaderViewController instance's `layoutDelegate`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
extension MyViewController: MDCFlexibleHeaderViewLayoutDelegate {

  // MARK: MDCFlexibleHeaderViewLayoutDelegate
  func flexibleHeaderViewController(_: MDCFlexibleHeaderViewController,
      flexibleHeaderViewFrameDidChange flexibleHeaderView: MDCFlexibleHeaderView) {
    // Called whenever the frame changes.
  }
}
```

#### Objective-C
```objc
// Conform to MDCFlexibleHeaderViewLayoutDelegate
@interface MyViewController () <MDCFlexibleHeaderViewLayoutDelegate>
@end

// Set yourself as the delegate.
headerViewController.layoutDelegate = self;

#pragma - MDCFlexibleHeaderViewLayoutDelegate

- (void)flexibleHeaderViewController:(MDCFlexibleHeaderViewController *)flexibleHeaderViewController
    flexibleHeaderViewFrameDidChange:(MDCFlexibleHeaderView *)flexibleHeaderView {
  // Called whenever the frame changes.
}
```
<!--</div>-->

### Utilizing Top Layout Guide on Parent View Controller

When pairing  MDCFlexibleHeaderViewController with a view controller, it may be desirable to use
the paired view controller's `topLayoutGuide` to constrain additionals views. To constrain the
`topLayoutGuide` to the bottom point of the MDCFlexibleHeaderViewController, call
updateTopLayoutGuide on the flexible header view controller within the paired view controller's
viewWillLayoutSubviews method.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
override func viewWillLayoutSubviews() {
    super.viewDidLayoutSubviews()
    headerViewController.updateTopLayoutGuide()
}
```

#### Objective-C

```objc
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.headerViewController updateLayoutGuide];
}
```
<!--</div>-->
