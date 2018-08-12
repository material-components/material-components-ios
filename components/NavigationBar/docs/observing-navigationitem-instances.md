### Observing UINavigationItem instances

MDCNavigationBar can observe changes made to a navigation item property much like how a
UINavigationBar does. This feature is the recommended way to populate the navigation bar's
properties because it allows your view controllers to continue using `navigationItem` as expected,
with a few exceptions outlined below.

> If you intend to use UINavigationItem observation it is recommended that you do not directly set
> the navigation bar properties outlined in `MDCUINavigationItemObservables`. Instead, treat the
> observed `navigationItem` object as the single source of truth for your navigationBar's state.

#### Starting observation

To begin observing a UINavigationItem instance you must call `observeNavigationItem:`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
navigationBar.observe(navigationItem)
```

#### Objective-C
```objc
[navigationBar observeNavigationItem:self.navigationItem];
```
<!--</div>-->

#### Stopping observation

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
navigationBar.unobserveNavigationItem()
```

#### Objective-C
```objc
[navigationBar unobserveNavigationItem];
```
<!--</div>-->

#### Exceptions

All of the typical properties including UIViewController's `title` property will affect the
navigation bar as you'd expect, with the following exceptions:

- None of the `animated:` method varients are supported because they do not implement KVO events.
  Use of these methods will result in the navigation bar becoming out of sync with the
  navigationItem properties.
- `prompt` is not presently supported. https://github.com/material-components/material-components-ios/issues/230.

