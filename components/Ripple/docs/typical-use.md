### Importing

Before using Ripple, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponentsBeta.MaterialRipple
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

### MDCRippleTouchController

The simplest method of using ripple in your views is to use a
`MDCRippleTouchController`:

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
ripple/touch relationship, such as to temporarily disable ripple
touches, the following code uses the delegate's
`rippleTouchController:shouldProcessRippleTouchesAtTouchLocation:` method:

<!--<div class="material-code-render" markdown="1">-->

#### Swift
```swift
class MyDelegate: NSObject, MDCRippleTouchControllerDelegate {

  func rippleTouchController(_ rippleTouchController: MDCRippleTouchController, shouldProcessRippleTouchesAtTouchLocation location: CGPoint) -> Bool {
    // Determine if we want to display the ink
    return true
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
  return YES;
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
let myCustomView = MyCustomView(frame: CGRect.zero)
let rippleView = MDCRippleView()
rippleView.inkColor = UIColor.red
myCustomView.addSubview(rippleView)
...
// When the touches begin, there is one animation
rippleView.beginRippleTouchDownAtPoint(at: touchPoint, animated: true, completion: nil)
...
// When the touches end, there is another animation
inkView.beginRippleTouchUpAnimated(animated: true, completion: nil)
```

#### Objective-C
```objc
MyCustomView *myCustomView = [[MyCustomView alloc] initWithFrame:CGRectZero];
MDCInkView *rippleView = [[MDCRippleView alloc] init];
rippleView.inkColor = [UIColor redColor];
[myCustomView addSubview:rippleView];
...
// When the touches begin, there is one animation
[inkView beginRippleTouchDownAtPoint:touchPoint animated:YES completion:nil];
...
// When the touches end, there is another animation
[inkView beginRippleTouchUpAnimated:YES completion:nil];
```
<!--</div>-->
