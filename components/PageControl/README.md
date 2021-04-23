<!--docs:
title: "Page control"
layout: detail
section: components
excerpt: "Page control is a drop-in Material Design replacement for UIPageControl that implements Material Design animation and layout."
iconId: <#icon_id#>
path: /catalog/page-controls/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme PageControl -->

# Page control

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BPageControl%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BPageControl%5D)

This control is designed to be a drop-in replacement for `UIPageControl`, with a user experience
influenced by Material Design specifications for animation and layout. The API methods are the
same as a `UIPageControl`, with the addition of a few key methods required to achieve the
desired animation of the control.

<img src="docs/assets/pagecontrol.gif" alt="An animation demonstrating a page control alternating between three pages." width="190">

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/PageControl/src/MDCPageControl.h">MDCPageControl</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use](#typical-use)
  - [Differences From UIPageControl](#differences-from-uipagecontrol)
- [Extensions](#extensions)
  - [Color Theming](#color-theming)

- - -

## Overview

<img src="docs/assets/MDCPageControl_screenshot-1.png" alt="screenshot-1" width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Page control showing current page in resting state.

<img src="docs/assets/MDCPageControl_screenshot-2.png" alt="screenshot-2" width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Page control showing animated track with current page indicator positioned along the track.

<img src="docs/assets/MDCPageControl_screenshot-3.png" alt="screenshot-3" width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Page control showing new current page.

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/PageControl'
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
import MaterialComponents.MaterialPageControl
```

#### Objective-C

```objc
#import "MaterialPageControl.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/typical-use.md -->

### Typical use

Integrating the page control requires two steps. First, add a page control with companion scroll
view, and second, forward the scroll view delegate methods to the page control.

**Step 1: Add the page control to a view**

Add the page control to a view and set the desired page control properties. This step is done
similarly to a native `UIPageControl`. In addition, provide a tap gesture handler for the control to
to fire off the `UIControlEventValueChanged` events in which the scroll view would typically be
notified of page changes.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let pageControl = MDCPageControl()
let scrollView = UIScrollView()
let pages = NSMutableArray()

override func viewDidLoad() {
  super.viewDidLoad()

  scrollView.delegate = self
  view.addSubview(scrollView)

  pageControl.numberOfPages = 3

  let pageControlSize = pageControl.sizeThatFits(view.bounds.size)
  pageControl.frame = CGRect(x: 0, y: view.bounds.height - pageControlSize.height, width: view.bounds.width, height: pageControlSize.height)

  pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
  pageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
  view.addSubview(pageControl)
}

func didChangePage(sender: MDCPageControl){
  var offset = scrollView.contentOffset
  offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
  scrollView.setContentOffset(offset, animated: true)
}
```

#### Objective-C

```objc
- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];

  self.pageControl.numberOfPages = 3;

  CGSize pageControlSize = [self.pageControl sizeThatFits:self.view.bounds.size];
  self.pageControl.frame = CGRectMake(0, self.view.bounds.size.height - pageControlSize.height, self.view.bounds.size.width, pageControlSize.height);

  [self.pageControl addTarget:self action:@selector(didChangePage:) forControlEvents: UIControlEventValueChanged];
  self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  [self.view addSubview:self.pageControl];

}

- (void)didChangePage:(MDCPageControl*)sender {
  CGPoint offset = self.scrollView.contentOffset;
  offset.x = (CGFloat)sender.currentPage * self.scrollView.bounds.size.width;
  [self.scrollView setContentOffset:offset animated: true];
}
```
<!--</div>-->

**Step 2: Forwarding the required scroll view delegate methods**

This page control is designed to be used in conjunction with a scroll view. To achieve the desired
page control animation effects, there are three scroll view delegate methods that must be forwarded
to the page control (`-scrollViewDidScroll`, `-scrollViewDidEndDecelerating`, and
`-scrollViewDidEndScrollingAnimation`). This allows the page control to keep in sync with the
scrolling movement of the designated scroll view.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
  pageControl.scrollViewDidScroll(scrollView)
}

func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
  pageControl.scrollViewDidEndDecelerating(scrollView)
}

func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
  pageControl.scrollViewDidEndScrollingAnimation(scrollView)
}
```

#### Objective-C

```objc
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.pageControl scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [self.pageControl scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [self.pageControl scrollViewDidEndScrollingAnimation:scrollView];
}
```
<!--</div>-->

<!-- Extracted from docs/differences-from-uipagecontrol.md -->

### Differences From UIPageControl

This page control provides an animation effect that keeps a page indicator in sync with the
scrolling of a designated scroll view. This is in contrast to a native `UIPageControl`, which
shows the current page indicator without any animated transitions between changes.

As the user scrolls, a track will be drawn with animation from the current indicator position
towards the next indicator position that is being scrolled towards. The current indicator will
float along this track and position itself based on the percent scrolled between the pages.
When the scroll view finishes scrolling, the track will disappear with animation towards the
final position of the new page.


## Extensions

<!-- Extracted from docs/color-theming.md -->

### Color Theming

Page Control does not yet have a Material Design color system theming extension.

