---
title:  "Ink"
layout: detail
section: documentation
---
# Ink

The Ink component provides a radial action in the form of a visual ripple of ink expanding
outward from the user's touch.
<!--{: .intro }-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/animation/responsive-interaction.html#responsive-interaction-radial-action">Radial Action</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/apidocs/Ink/Classes/MDCInkTouchController.html">MDCInkTouchController</a></li>
  <li class="icon-link"><a href="/apidocs/Ink/Classes/MDCInkView.html">MDCInkView</a></li>
  <li class="icon-link"><a href="/apidocs/Ink/Protocols/MDCInkTouchControllerDelegate.html">MDCInkTouchControllerDelegate</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
$ pod 'MaterialComponents/Ink'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~


- - -

## Usage

The Ink component exposes two interfaces that you can use to add material-like
feedback to the user:

1. `MDCInkView` is a subclass of `UIView` that draws and animates ink ripples
and can be placed anywhere in your view hierarchy.
2. `MDCInkTouchController` combines a `MDCInkView` instance with a
`UITapGestureRecognizer` instance to conveniently drive the ink ripples from the
user's touches.

### MDCInkTouchController

The simplest method of using ink in your views is to use a
`MDCInkTouchController`:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MDCInkTouchController *inkTouchController =
    [[MDCInkTouchController alloc] initWithView:myButton];
[inkTouchController addInkView];
~~~
<!--</div>-->



The `MDCInkTouchControllerDelegate` gives you control over aspects of the
ink/touch relationship, such as how the ink view is created, where it is
inserted in view hierarchy, etc. For example, to temporarily disable ink
touches, the following code uses the delegate's
`inkTouchController:shouldProcessInkTouchesAtTouchLocation:` method:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
@interface MyDelegate <MDCInkTouchControllerDelegate>
@end

@implementation MyDelegate

- (BOOL)inkTouchController:(MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  return [self checkIfWeShouldDisplayInk];
}

@end

...

UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
MyDelegate *myDelegate = [[MyDelegate] alloc] init];
MDCInkTouchController *inkTouchController =
    [[MDCInkTouchController alloc] initWithView:myButton];
inkTouchController.delegate = myDelegate;
[inkTouchController addInkView];

~~~

<!--</div>-->

### MDCInkView

Alternatively, you can use MCDInkView directly to display ink ripples using your
own touch processing:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
MyCustomView *myCustomView = [[MyCustomView alloc] initWithFrame:CGRectZero];
MDCInkView *inkView = [[MDCInkView alloc] init];
inkView.inkColor = [UIColor redColor];
[myCustomView addSubview:inkView];
...
[inkView spreadFromPoint:CGPointMake(100, 100) completion:NULL];
~~~

<!--</div>-->
