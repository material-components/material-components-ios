<!--docs:
title: "Bottom Sheet"
layout: detail
section: components
excerpt: "Bottom sheets slide up from the bottom of the screen to reveal more content."
iconId: animation
path: /catalog/bottom-sheet/
-->


# Bottom Sheet

<div class="article__asset article__asset--screenshot">
   <img src="docs/assets/bottom_sheet.png" alt="Bottom Sheet" width="375">
</div>

Bottom sheets slide up from the bottom of the screen to reveal more content. Bottom sheets integrate with the app to display supporting content or present deep-linked content from other apps.


## Design & API Documentation

<ul class="icon-list">
<li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/components/bottom-sheets.html">Material Design guidelines: Bottom Sheet</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/BottomSheet'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

- - -

## Usage

### Importing

Before using Bottom Sheet, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialBottomSheet
```

#### Objective-C

``` objc
#import "MaterialBottomSheet.h"
```
<!--</div>-->

## Examples

Create a view controller that the bottom sheet will hold and initialize the bottom sheet with that view controller. After the bottom sheet is created, it is ready to be presented on the current view controller.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
// View controller the bottom sheet will hold
let viewController: ViewController = ViewController()
// Initialize the bottom sheet with the view controller just created
let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
// Present the bottom sheet
present(bottomSheet, animated: true, completion: nil)
```

#### Objective-C
``` objc
// View controller the bottom sheet will hold
ViewController *viewController = [[ViewController alloc] init];
// Initialize the bottom sheet with the view controller just created
MDCBottomSheetController *bottomSheet = [[MDCBottomSheetController alloc] initWithContentViewController:viewController];
// Present the bottom sheet
[self presentViewController:bottomSheet animated:true completion:nil];
```

Create a button that will call the code above.

#### Swift
``` swift
let button = UIButton(frame: .zero)
button.addTarget(self, action: #selector(presentBottomSheet), for: .touchUpInside)
```

#### Objective-C
``` objc
_button = [[UIButton alloc] initWithFrame:CGRectZero];
[_button addTarget:self action:@selector(presentBottomSheet) forControlEvents:UIControlEventTouchUpInside];

```

<!--</div>-->
