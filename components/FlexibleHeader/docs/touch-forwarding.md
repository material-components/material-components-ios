### Touch forwarding

The flexible header allows you to forward touch events to the tracking scroll view. This provides
the illusion that the flexible header is part of the tracking scroll view.

#### Starting touch forwarding

To start touch forwarding you must call `forwardTouchEventsForView:` with each view:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
headerView.forwardTouchEvents(for: someContentView)
```

#### Objective-C
```objc
[headerView forwardTouchEventsForView:someContentView];
```
<!--</div>-->

#### Stopping touch forwarding

To stop touch forwarding you must call `forwardTouchEventsForView:` with each view:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
headerView.stopForwardingTouchEvents(for: someContentView)
```

#### Objective-C
```objc
[headerView stopForwardingTouchEventsForView:someContentView];
```
<!--</div>-->
