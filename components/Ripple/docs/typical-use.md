### Importing

Before using Ripple, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialRipple
```

#### Objective-C

```objc
#import "MaterialRipple.h"
```
<!--</div>-->

The Ripple component exposes two interfaces that you can use to add material-like
feedback to the user:

1. `MDCRippleView` is a subclass of `UIView` that draws and animates ripples
and can be placed anywhere in your view hierarchy.
2. `MDCRippleTouchController` bundles an `MDCRippleView` instance with a
`UITapGestureRecognizer` instance to conveniently drive the ripples from the
user's touches.
3. `MDCStatefulRippleView` is a subclass of `MDCRippleView` that provides support for states. This allows to set the ripple in a state and have the ripple visually represent that state as part of the Material guidelines.

### MDCRippleTouchController

The simplest method of using ripple in your views is to use a
`MDCRippleTouchController`:

Initialize using the default initializer:
<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let myButton = UIButton(type: .system)
myButton.setTitle("Tap Me", for: .normal)
let rippleTouchController = MDCRippleTouchController()
rippleTouchController.addRipple(to: myButton)
```

#### Objective-C
```objc
UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MDCRippleTouchController *rippleTouchController = [[MDCRippleTouchController alloc] init];
[rippleTouchController addRippleToView:myButton];
```
<!--</div>-->

Initialize using the `initWithView:` convenience initializer:
<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let myButton = UIButton(type: .system)
myButton.setTitle("Tap Me", for: .normal)
let rippleTouchController = MDCRippleTouchController(view: myButton)
```

#### Objective-C
```objc
UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MDCRippleTouchController *rippleTouchController = [[MDCRippleTouchController alloc] initWithView:myButton];
```
<!--</div>-->

The `MDCRippleTouchControllerDelegate` gives you some control over aspects of the
ripple/touch relationship and its placement in the view hierarchy.
In the example below we are using the delegate to declare that we only want to process ripple
touches if the touch is in a certain location. We also insert the Ripple view at the bottom of
the parent view's view hierarchy. The reason we insert the ripple view at the bottom of the parent view's
hierarchy in this example, is so the ripple's overlay color would not affect the visibility and contrast
of the view's subviews, which may be images conveying a message or text.

<!--<div class="material-code-render" markdown="1">-->

#### Swift
```swift
class MyDelegate: NSObject, MDCRippleTouchControllerDelegate {

  func rippleTouchController(_ rippleTouchController: MDCRippleTouchController, shouldProcessRippleTouchesAtTouchLocation location: CGPoint) -> Bool {
    // Determine if we want to display the ripple
    return exampleView.frame.contains(location)
  }

  func rippleTouchController(_ rippleTouchController: MDCRippleTouchController,
                             insert rippleView: MDCRippleView,
                             into view: UIView) {
    view.insertSubview(rippleView, at: 0)
  }

  func rippleTouchController(_ rippleTouchController: MDCRippleTouchController,
                             didProcessRippleView rippleView: MDCRippleView,
                             atTouchLocation location: CGPoint) {
    print("Did process ripple view!")
  }

}

...

let myButton = UIButton(type: .system)
myButton.setTitle("Tap Me", for: .normal)

let myDelegate = MyDelegate()

let rippleTouchController = MDCRippleTouchController(view: myButton)
rippleTouchController.delegate = myDelegate
```

#### Objective-C
```objc
@interface MyDelegate: NSObject <MDCRippleTouchControllerDelegate>
@end

@implementation MyDelegate

- (BOOL)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
    shouldProcessRippleTouchesAtTouchLocation:(CGPoint)location {
  return CGRectContainsPoint(exampleView.frame, location);
}

- (void)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
         didProcessRippleView:(MDCRippleView *)rippleView
              atTouchLocation:(CGPoint)location {
  NSLog(@"Did process ripple view!");
}

- (void)rippleTouchController:(MDCRippleTouchController *)rippleTouchController insertRippleView:(MDCRippleView *)rippleView intoView:(UIView *)view {
    [view insertSubview:rippleView atIndex:0];
}
@end

...

UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MyDelegate *myDelegate = [[MyDelegate alloc] init];
MDCRippleTouchController *rippleTouchController = [[MDCRippleTouchController alloc] initWithView:myButton];
rippleTouchController.delegate = myDelegate;
```
<!--</div>-->

**NOTE:** The ripple touch controller does not keep a strong reference to the view to which it is attaching the ripple view.
An easy way to prevent the ripple touch controller from being deallocated prematurely is to make it a property of a view controller (like in these examples.)

### MDCRippleView

Alternatively, you can use MDCRippleView directly to display ripples using your
own touch processing:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let myCustomView = MyCustomView(frame: .zero)
let rippleView = MDCRippleView()
rippleView.rippleColor = .red
myCustomView.addSubview(rippleView)
...
// When the touches begin, there is one animation
rippleView.beginRippleTouchDownAtPoint(at: touchPoint, animated: true, completion: nil)
...
// When the touches end, there is another animation
rippleView.beginRippleTouchUpAnimated(animated: true, completion: nil)
```

#### Objective-C
```objc
MyCustomView *myCustomView = [[MyCustomView alloc] initWithFrame:CGRectZero];
MDCRippleView *rippleView = [[MDCRippleView alloc] init];
rippleView.rippleColor = UIColor.redColor;
[myCustomView addSubview:rippleView];
...
// When the touches begin, there is one animation
[rippleView beginRippleTouchDownAtPoint:touchPoint animated:YES completion:nil];
...
// When the touches end, there is another animation
[rippleView beginRippleTouchUpAnimated:YES completion:nil];
```
<!--</div>-->

### MDCStatefulRippleView

You can also use MDCStatefulRippleView to display stateful ripples using your
own touch processing.
To fully benefit from MDCStatefulRipple's ability to move between states visually,
the view that is adding the stateful ripple view must override 
UIView's `touchesBegan`, `touchesMoved`, `touchesEnded` and `touchesCancelled`
and call the stateful ripple view's corresponding APIs before calling the `super` implementation.
Here is an example:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let myCustomView = MyCustomView(frame: .zero)
let statefulRippleView = MDCStatefulRippleView()
statefulRippleView.setRippleColor(.blue, for: .selected)
myCustomView.addSubview(statefulRippleView)

...

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  statefulRippleView.touchesBegan(touches, with: event)
  super.touchesBegan(touches, with: event)

  statefulRippleView.isRippleHighlighted = true
}

override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  statefulRippleView.touchesMoved(touches, with: event)
  super.touchesMoved(touches, with: event)
}

override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
  statefulRippleView.touchesEnded(touches, with: event)
  super.touchesEnded(touches, with: event)

  statefulRippleView.isRippleHighlighted = false
}

override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  statefulRippleView.touchesCancelled(touches, with: event)
  super.touchesCancelled(touches, with: event)

  statefulRippleView.isRippleHighlighted = false
}
```

#### Objective-C
```objc
MyCustomView *myCustomView = [[MyCustomView alloc] initWithFrame:CGRectZero];
MDCStatefulRippleView *statefulRippleView = [[MDCStatefulRippleView alloc] init];
[statefulRippleView setRippleColor:UIColor.blueColor forState:MDCRippleStateSelected];
[myCustomView addSubview:statefulRippleView];

...

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [statefulRippleView touchesBegan:touches withEvent:event];
  [super touchesBegan:touches withEvent:event];

  statefulRippleView.rippleHighlighted = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [statefulRippleView touchesMoved:touches withEvent:event];
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [statefulRippleView touchesEnded:touches withEvent:event];
  [super touchesEnded:touches withEvent:event];

  statefulRippleView.rippleHighlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [statefulRippleView touchesCancelled:touches withEvent:event];
  [super touchesCancelled:touches withEvent:event];

  statefulRippleView.rippleHighlighted = NO;
}
```
<!--</div>-->
