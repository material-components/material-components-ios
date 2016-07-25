---
title:  "Progress View"
layout: detail
section: components
excerpt: "Progress View is a determinate and linear progress indicator that implements material design animation and layout."
---
# Progress View

<div class="ios-animation right" markdown="1">
  <video src="docs/assets/progress_view.mp4" autoplay loop></video>
  [![ScreenShot](docs/assets/progress_view.png)](docs/assets/progress_view.mp4)
</div>

This control is designed to be a drop-in replacement for `UIProgressView`, with a user experience
influenced by [material design specifications](https://material.google.com/components/progress-activity.html#)
for animation and layout. The API methods are the same as a `UIProgressView`, with the addition of a
few key methods required to achieve the desired animation of the control.
<!--{: .intro }-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://material.google.com/components/progress-activity.html">Progress & activity</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/components/ProgressView/apidocs/Classes/MDCProgressView.html">MDCProgressView</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher
- iOS SDK version 7.0 or higher

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/ProgressView'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~

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
#### Objective-C

~~~ objc
#import "MaterialProgressView.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

Add the progress view to your view hierarchy like you would with any other view. Note that it works
best when the progress view is added at the bottom of a view, as showing (resp. hiding) grows up
(resp. shrinks down).

### Step 1: Add the progress view to a view

Add the progress view to a view and set the desired progress and hidden state.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
@implementation ViewController {
  MDCProgressView *_progressView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Progress view configuration.
  _progressView = [[MDCProgressView alloc] initWithFrame:myFrame];
  _progressView.progress = 0;  // You can also set a greater progress for actions already started.
  [self.view addSubview:_progressView];
}

~~~

#### Swift

~~~ swift
class ProgressViewSwiftExampleViewController: UIViewController {

  let progressView = MDCProgressView()

  override func viewDidLoad() {
    super.viewDidLoad()

    progressView.progress = 0

    let progressViewHeight = CGFloat(2)
    progressView.frame = CGRectMake(0, view.bounds.height - progressViewHeight, view.bounds.width, progressViewHeight);
    view.addSubview(progressView)
  }

~~~
<!--</div>-->

### Step 2: Change the progress and hidden state

Both the progress and the hidden state can be animated, with a completion block.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
- (void)startAndShowProgressView {
  _progressView.progress = 0;
  [_progressView setHidden:NO animated:YES completion:nil];
}

- (void)completeAndHideProgressView {
  [_progressView setProgress:1 animated:YES completion:^(BOOL finished){
    [_progressView setHidden:YES animated:YES completion:nil];
  }];
}
~~~

#### Swift

~~~ swift
func startAndShowProgressView {
  progressView.progress = 0
  progressView.setHidden(false, animated: true)
}

func completeAndHideProgressView {
  progressView.setProgress(1, animated: true) { BOOL finished in
    progressView.setHidden(true, animated: true)
  }
}
~~~

<!--</div>-->
