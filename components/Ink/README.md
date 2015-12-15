# Ink

The Ink component provides a
[radial action](https://www.google.com/design/spec/animation/responsive-interaction.html#responsive-interaction-material-response)
in the form of a visual ripple of ink expanding outward from the user's touch.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Displaying ink ripples

The Ink component exposes two interfaces that you can use to add material-like
feedback to the user:

1. `MDCInkView` is a subclass of `UIView` that draws and animates ink ripples
and can be placed anywhere in your view hierarchy.
1. `MDCInkTouchController` combines a `MDCInkView` instance with a
`UITapGestureRecognizer` instance to conveniently drive the ink ripples from the
user's touches.

### MDCInkTouchController

The simplest method of using ink in your views is to use a
`MDCInkTouchController`:

```objective-c
UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
[myButton setTitle:@"Tap me" forState:UIControlStateNormal];
MDCInkTouchController *inkTouchController =
    [[MDCInkTouchController alloc] initWithView:myButton];
[inkTouchController addInkView];
```

The `MDCInkTouchControllerDelegate` gives you control over aspects of the
ink/touch relationship, such as how the ink view is created, where it is
inserted in view hierarchy, etc. For example, to temporarily disable ink
touches, the following code uses the delegate's
`inkTouchControllerShouldProcessInkTouches:` method:

```objective-c
@interface MyDelegate <MDCInkTouchControllerDelegate>
@end

@implementation MyDelegate

- (BOOL)inkTouchControllerShouldProcessInkTouches:
    (MDCInkTouchController *)inkTouchController {
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

```

### MDCInkView

Alternatively, you can use MCDInkView directly to display ink ripples using your
own touch processing:

```objective-c
MyCustomView *myCustomView = [[MyCustomView alloc] initWithFrame:CGRectZero];
MDCInkView *inkView = [[MDCInkView alloc] init];
inkView.inkColor = [UIColor redColor];
[myCustomView addSubview:inkView];
...
[inkView spreadFromPoint:CGPointMake(100, 100) completion:NULL];
```
