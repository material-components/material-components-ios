<!--docs:
title: "Masked Transitions"
layout: detail
section: components
excerpt: "A masked transition reveals content from a source view using a view controller transition."
iconId: maskedTransition
path: /catalog/masked-transitions/
api_doc_root: true
-->

# Masked Transitions

A masked transition reveals content from a source view using a view controller transition.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/motion/transforming-material.html#transforming-material-radial-transformation">Material Design guidelines: Radial Transformations</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/masked-transitions/api-docs/Classes/MDCMaskedTransition.html">API: MDCMaskedTransition</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/MaskedTransition'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

- - -

## Overview

A masked transition is a UIViewController transition that can be used to present a contextual
expansion from a circular source view. This transition follows the motion timing defined by the
section on [Radial transformations](https://material.io/guidelines/motion/transforming-material.html#transforming-material-radial-transformation)
in the Material Design guidelines.

- - -

## Usage

### Importing

Before using Masked Transition, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialMaskedTransition
```

#### Objective-C

``` objc
#import "MaterialMaskedTransition.h"
```
<!--</div>-->

### Using MDCMaskedTransition to present a view controller

Create an instance of MDCMaskedTransition and assign it to the view controller's
`mdm_transitionController.transition` property prior to presenting the view controller:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
vc.transitionController.transition = MDCMaskedTransition(sourceView: button)
present(vc, animated: true)
```

#### Objective-C

``` objc
vc.mdm_transitionController.transition = [[MDCMaskedTransition alloc] initWithSourceView:button];
[self presentViewController:vc animated:YES completion:nil];
```
<!--</div>-->

### Customizing the presented frame

You can customize the presented frame of the view controller by assigning a
`calculateFrameOfPresentedView` block on the transition instance. For example, to present a modal
dialog centered in the screen you can use the following examples:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let transition = MDCMaskedTransition(sourceView: button)
transition.calculateFrameOfPresentedView = { info in
  let size = CGSize(width: 200, height: 200)
  return CGRect(x: (info.containerView!.bounds.width - size.width) / 2,
                y: (info.containerView!.bounds.height - size.height) / 2,
                width: size.width,
                height: size.height)
}
vc.transitionController.transition = transition
present(vc, animated: true)
```

#### Objective-C

``` objc
MDCMaskedTransition *transition = [[MDCMaskedTransition alloc] initWithSourceView:button];
transition.calculateFrameOfPresentedView = ^(UIPresentationController *info) {
  CGSize size = CGSizeMake(200, 200);
  return CGRectMake((info.containerView.bounds.size.width - size.width) / 2,
                    (info.containerView.bounds.size.height - size.height) / 2,
                    size.width,
                    size.height);
};
vc.mdm_transitionController.transition = transition;
[self presentViewController:vc animated:YES completion:nil];
```
<!--</div>-->
