<!-- This file was auto-generated using ./scripts/generate_readme Banner -->

# Banner

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BBanner%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BBanner%5D)

A banner displays a prominent message and related optional actions.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/banner.png" alt="Banner" width="320">
</div>

## Design & API documentation


## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Appearance](#appearance)
  - [Styling](#styling)
  - [LayoutMargins](#layoutmargins)
- [Examples](#examples)
  - [Creating a banner view](#creating-a-banner-view)

- - -

## Overview

`MDCBannerView` is a view that displays an important, succinct message, and provides actions for users to address (or dismiss the banner). It requires a user action to be dismissed.

## Installation

<!-- Extracted from docs/installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Banner'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To use the `MDCBannerView` in your code, import the MaterialBanner umbrella header (Objective-C) or MaterialComponents module (Swift).

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialBanner
```

#### Objective-C

```objc
#import "MaterialBanner.h"
```

<!--</div>-->



## Usage

<!-- Extracted from docs/typical-use.md -->

### Appearance

By default, `MDCBannerView` is configured to display an image view, a text label and two buttons. To hide the image view on `MDCBannerView`, users can set the `hidden` property on `imageView` to be true. Similarly, users can hide a button on the banner view by setting the `hidden` property on `trailingButton` to be true.

### Styling

By default, `MDCBannerView` is configured to display items with black text and white background with a grey divider at the bottom of the view. To customize the color and style of the text, image view and buttons displayed on `MDCBannerView`, directly set the relevant properties, such as `tintColor`, on `textView`, `imageView`, `leadingButton` and `trailingButton`. `showsDivider` and `dividerColor` can be used to control the divider's visibility and color.

`MDCBannerView` can handle its layout style in both an automatic way and manual ways through `bannerViewLayoutStyle` property. By default, `MDCBannerViewLayoutStyleAutomatic` is set and layout is set automatically based on how elements are configured on the `MDCBannerView`. `MDCBannerViewLayoutStyleSingleRow`, `MDCBannerViewLayoutStyleMultiRowStackedButton` and `MDCBannerViewLayoutStyleMultiRowAlignedButton` are values that can be used as manual ways to handle layout style.

### LayoutMargins

`MDCBannerView` uses `layoutMargins` to manage the margins for elements on the banner view.
<!--</div>-->


## Examples

<!-- Extracted from docs/examples.md -->

### Creating a banner view

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bannerView = MDCBannerView()
bannerView.textView.text = "Text on Banner"
bannerView.imageView.image = UIImage(named: "bannerIcon")
bannerView.leadingButton.setTitle("Action", for: .normal)
bannerView.trailingButton.hidden = true

// Optional configuration on layoutMargins
bannerView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);

let bannerViewSize = bannerView.sizeThatFits(view.bounds.size)
bannerView.frame = CGRect(x: 0, y: 0, width: bannerViewSize.width, height: bannerViewSize.height)

view.addSubview(bannerView)
```

#### Objective-C

```objc
MDCBannerView *bannerView = [[MDCBannerView alloc] init];
bannerView.textView.text = @"Text on Banner";
bannerView.imageView.image = [UIImage imageNamed:@"bannerIcon"];
[bannerView.leadingButton setTitle:@"Action" forState:UIControlStateNormal];
bannerView.trailingButton.hidden = YES;

// Optional configuration on layoutMargins. 
bannerView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);

CGSize bannerViewSize = [bannerView sizeThatFits:self.view.bounds.size];
bannerView.frame = CGRectMake(0, 0, bannerViewSize.width, bannerViewSize.height);

[self.view addSubview:bannerView];
```

<!--</div>-->

