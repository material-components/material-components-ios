<!--docs:
title: "Ink"
layout: detail
section: components
excerpt: "The Ink component provides a radial action in the form of a visual ripple of ink expanding outward from the user's touch."
iconId: ripple
path: /catalog/ink/
-->

# Ink

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/ink.png" alt="Ink" width="375">
</div>

The Ink component provides a radial action in the form of a visual ripple of ink expanding
outward from the user's touch.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/animation/responsive-interaction.html#responsive-interaction-radial-action">Radial Action</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/Ink'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```


- - -

## Usage

### Importing

Before using Ink, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents
```

#### Objective-C

``` objc
#import "MaterialInk.h"
```
<!--</div>-->

The Ink component exposes two interfaces that you can use to add material-like
feedback to the user:

1. `MDCInkView` is a subclass of `UIView` that draws and animates ink ripples
and can be placed anywhere in your view hierarchy.
2. `MDCInkTouchController` bundles an `MDCInkView` instance with a
`UITapGestureRecognizer` instance to conveniently drive the ink ripples from the
user's touches.

### MDCInkTouchController

The simplest method of using ink in your views is to use a
`MDCInkTouchController`:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let myButton = UIButton(type: .system)
myButton.setTitle("Tap Me", for: .normal)
let inkTouchController = MDCInkTouchController(view: myButton)
inkTouchController?.addInkView()
```

#### Objective-C
``` objc
UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:myButton];
[inkTouchController addInkView];
```
<!--</div>-->



The `MDCInkTouchControllerDelegate` gives you control over aspects of the
ink/touch relationship, such as how the ink view is created, where it is
inserted in view hierarchy, etc. For example, to temporarily disable ink
touches, the following code uses the delegate's
`inkTouchController:shouldProcessInkTouchesAtTouchLocation:` method:

<!--<div class="material-code-render" markdown="1">-->

#### Swift
``` swift
class MyDelegate: NSObject, MDCInkTouchControllerDelegate {

  func inkTouchController(_ inkTouchController: MDCInkTouchController, shouldProcessInkTouchesAtTouchLocation location: CGPoint) -> Bool {
    // Determine if we want to display the ink
    return true
  }

}

...

let myButton = UIButton(type: .system)
myButton.setTitle("Tap Me", for: .normal)

let myDelegate = MyDelegate()

let inkTouchController = MDCInkTouchController(view: myButton)
inkTouchController?.delegate = myDelegate
inkTouchController?.addInkView()

```

#### Objective-C
``` objc
@interface MyDelegate: NSObject <MDCInkTouchControllerDelegate>
@end

@implementation MyDelegate

- (BOOL)inkTouchController:(MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  return YES;
}

@end

...

UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MyDelegate *myDelegate = [[MyDelegate alloc] init];
MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:myButton];
inkTouchController.delegate = myDelegate;
[inkTouchController addInkView];
```
<!--</div>-->

**NOTE:** The ink touch controller does not keep a strong reference to the view to which it is attaching the ink view.
An easy way to prevent the ink touch controller from being deallocated prematurely is to make it a property of a view controller (like in these examples.)

### MDCInkView

Alternatively, you can use MCDInkView directly to display ink ripples using your
own touch processing:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let myCustomView = MyCustomView(frame: CGRect.zero)
let inkView = MDCInkView()
inkView.inkColor = UIColor.red
myCustomView.addSubview(inkView)
...
// When the touches begin, there is one animation
inkView.startTouchBeganAnimation(at: touchPoint, completion: nil)
...
// When the touches end, there is another animation
inkView.startTouchEndedAnimation(at: touchPoint, completion: nil)
```

#### Objective-C
``` objc
MyCustomView *myCustomView = [[MyCustomView alloc] initWithFrame:CGRectZero];
MDCInkView *inkView = [MDCInkView new];
inkView.inkColor = [UIColor redColor];
[myCustomView addSubview:inkView];
...
// When the touches begin, there is one animation
[inkView startTouchBeganAnimationAtPoint:touchPoint completion:nil];
...
// When the touches end, there is another animation
[inkView startTouchEndedAnimationAtPoint:touchPoint completion:nil];
```
<!--</div>-->
