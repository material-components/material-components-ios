<!--docs:
title: "Ripple"
layout: detail
section: components
excerpt: "The Ripple component provides a radial action in the form of a visual ripple expanding outward from"
iconId: <#icon_id#>
path: /catalog/ripple/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme Ripple -->

# Ripple

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BRipple%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BRipple%5D)

The Ripple component provides a radial action in the form of a visual ripple expanding outward from
the user's touch. 
Ripple is a visual form of feedback for touch events providing users a clear signal that an element is being touched.

<img src="docs/assets/ripple.gif" alt="An animation showing a Material ripple on multiple surfaces." width="210">

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-ripple">Material Design guidelines: Ripple</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Classes/MDCRippleTouchController.html">MDCRippleTouchController</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Classes/MDCRippleView.html">MDCRippleView</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Protocols/MDCRippleTouchControllerDelegate.html">MDCRippleTouchControllerDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Protocols/MDCRippleViewDelegate.html">MDCRippleViewDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Enums.html">Enumerations</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Enums/MDCRippleState.html">MDCRippleState</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/ripple/api-docs/Enums/MDCRippleStyle.html">MDCRippleStyle</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)

- - -

## Overview

`MDCRippleView` is a material design implementation of touch feedback and is a successor of Ink.

Ripple is currently a [beta component](docs/../../contributing/beta_components.md). Therefore, clients that
wish to use Ripple in their app will need to manually clone the repo and add the code to their project. 

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Ripple'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To import the component:

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


## Usage

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

