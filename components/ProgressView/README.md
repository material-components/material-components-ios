<!--docs:
title: "Progress View"
layout: detail
section: components
excerpt: "Progress View is a determinate and linear progress indicator that implements Material Design animation and layout."
iconId: progress_linear
path: /catalog/progress-views/
-->

# Progress View

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/progress_view.png" alt="Progress View" width="375">
</div>

This control is designed to be a drop-in replacement for `UIProgressView`, with a user experience
influenced by [Material Design specifications](https://material.io/guidelines/components/progress-activity.html#)
for animation and layout. The API methods are the same as a `UIProgressView`, with the addition of a
few key methods required to achieve the desired animation of the control.
<!--{: .article__intro }-->

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/components/progress-activity.html">Progress & activity</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher
- iOS SDK version 7.0 or higher

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/ProgressView'
```

Then, run the following command:

``` bash
$ pod install
```

- - -

## Differences From UIProgressView

This progress view provides an animation effect when showing and hidding it: it grows up (resp.
shrinks down). Additionally, all animated changes APIs take an optional completion block, to
synchronize multistep animations.

- - -

## Usage

### Importing

Before using Progress View, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialProgressView
```

#### Objective-C

``` objc
#import "MaterialProgressView.h"
```
<!--</div>-->

Add the progress view to your view hierarchy like you would with any other view. Note that it works
best when the progress view is added at the bottom of a view, as showing (resp. hiding) grows up
(resp. shrinks down).

### Step 1: Add the progress view to a view

Add the progress view to a view and set the desired progress and hidden state.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let progressView = MDCProgressView()
progressView.progress = 0

let progressViewHeight = CGFloat(2)
progressView.frame = CGRect(x: 0, y: view.bounds.height - progressViewHeight, width: view.bounds.width, height: progressViewHeight)
view.addSubview(progressView)
```

#### Objective-C

``` objc
@property(nonatomic) MDCProgressView *progressView;
...

// Progress view configuration.
self.progressView = [[MDCProgressView alloc] initWithFrame:myframe];
self.progressView.progress = 0;  // You can also set a greater progress for actions already started.
[self.view addSubview:self.progressView];
```
<!--</div>-->

### Step 2: Change the progress and hidden state

Both the progress and the hidden state can be animated, with a completion block.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
func startAndShowProgressView() {
  progressView.progress = 0
  progressView.setHidden(false, animated: true)
}

func completeAndHideProgressView() {
  progressView.setProgress(1, animated: true) { (finished) in
    self.progressView.setHidden(true, animated: true)
  }
}
```

#### Objective-C

``` objc
- (void)startAndShowProgressView {
  self.progressView.progress = 0;
  [self.progressView setHidden:NO animated:YES completion:nil];
}

- (void)completeAndHideProgressView {
  __weak __typeof__(self) weakSelf = self;
  [self.progressView setProgress:1 animated:YES completion:^(BOOL finished){
    [weakSelf.progressView setHidden:YES animated:YES completion:nil];
  }];
}
```
<!--</div>-->
