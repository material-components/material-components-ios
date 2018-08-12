### Subclassing considerations

A subclass of your view controller may add additional views in their viewDidLoad, potentially
resulting in the header being covered by the new views. It is the responsibility of the subclass to
take the z-index into account:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
view.insertSubview(myCustomView, belowSubview: headerViewController.headerView)
```

#### Objective-C

```objc
[self.view insertSubview:myCustomView belowSubview:self.headerViewController.headerView];
```
<!--</div>-->
