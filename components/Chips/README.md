<!--docs:
title: "Chips"
layout: detail
section: components
excerpt: "Chips represent complex entities in small blocks, such as a contact."
iconId: chip
path: /catalog/chips/
api_doc_root: true
-->

# Chips

Chips represent complex entities, such as a contact, in small blocks.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/components/chips.html">Material Design guidelines: Chips</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 8.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/Chips'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

- - -

## Usage

### Importing

Before using Chips, you'll need to import them:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialChips
```

#### Objective-C

``` objc
#import "MaterialChips.h"
```
<!--</div>-->

### Ink ripple animation
Chips display animated ink splashes when the user presses the chip. Keep in mind this will appear on
top of your 'highlighted' backgroundColor.

### Stateful properties
Like UIButton, Material Chips have many state-dependant properties. Set your background color, title
color, border style, and elevation for each of their states. If you don't set a value for a specific
state it will fall back to whatever value has been provided for the Normal state. Don't forget that
you'll also need to set values for the combined states, such as Highlighted | Selected.

### Selected Image View
In order to make it as clear as possible a chip has been selected, you can optionally set the image
of the `selectedImageView`. This image will only appear when the chip is selected. If you have a
image set on the standard `imageView`, then the `selectedImageView` will appear on top. Otherwise
you'll need to resize the chip to show the selected image. See the Filter chip example to see this
in action.

### Padding
There are 4 `padding` properties which control how a chip is laid out. One for each of the chip's
subviews (`imageView` and `selectedImageView` share one padding property), and one which wraps all
the others (`contentPadding`). This is useful so that you can set each of the padding properties to
ensure your chips look correct whether or not they have an image and/or accessory view. The chip
uses these property to determine `intrinsicContentSize` and `sizeThatFits`.

### Collections of Chips
It is easiest to show large groups of Chips by containing them in a UICollectionView. Use
`MDCChipCollectionViewCell` and `MDCChipCollectionViewLayout` to configure a collection view to show
chips.

- - -

## Examples

### Create a single Chip

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let chipView = MDCChipView()
chipView.title = "Tap me"
chipView.setTitleColor(UIColor.red, for: .selected)
chipView.sizeToFit()
chipView.addTarget(self, action: #selector(tap), for: .touchUpInside)
self.view.addSubview(chipView)
```

#### Objective-C

``` objc
MDCChipView *chipView = [[MDCChipView alloc] init];
chipView.title = @"Tap me";
[chipView setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
[chipView sizeToFit];
[chipView addTarget:self
               action:@selector(tap:)
     forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:chipView];
```
<!--</div>-->
