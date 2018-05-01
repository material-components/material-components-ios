### Touch forwarding

The Flexible Header allows you to forward touch events to the tracking scroll view. This provides
the illusion that the Flexible Header is part of the tracking scroll view.

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
