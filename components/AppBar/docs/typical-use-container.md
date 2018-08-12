### Typical use: View controller containment, as a container

There are cases where adding an `MDCAppBarViewController` as a child is not possible, most notably:

- UIPageViewController's view is a horizontally-paging scroll view, meaning there is no fixed view
  to which an app bar could be added.
- Any other view controller that animates its content horizontally without providing a fixed,
  non-horizontally-moving parent view.

In such cases, using `MDCAppBarContainerViewController` is preferred.
`MDCAppBarContainerViewController` is a simple container view controller that places a content view
controller as a sibling to an `MDCAppBarViewController`.

**Note:** the trade off to using this API is that it will affect your view controller hierarchy. If
the view controller makes any assumptions about its parent view controller or its
navigationController properties then these assumptions may break once the view controller is
wrapped.

You'll typically push the container view controller onto a navigation controller, in which case you
will also hide the navigation controller's navigation bar using UINavigationController's
`-setNavigationBarHidden:animated:`.

#### Example

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let container = MDCAppBarContainerViewController(contentViewController: <#T##UIViewController#>)
```

#### Objective-C

```objc
MDCAppBarContainerViewController *container =
    [[MDCAppBarContainerViewController alloc] initWithContentViewController:<#(nonnull UIViewController *)#>];
```
<!--</div>-->
