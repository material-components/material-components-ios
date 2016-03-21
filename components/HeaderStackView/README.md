---
layout: post
title:  "HeaderStackView"
date:   2016-03-01 20:15:01 -0500
categories: documentation
---

# HeaderStackView

The Header Stack View component is a view that coordinates the layout of two vertically-stacked
bar views.

## Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

    pod 'MaterialComponents/HeaderStackView'

Then, run the following command:

    $ pod install

## Software design considerations

This view's sole purpose is to facilitate the relative layout of its two bars in a predictable way.

The top bar is typically a navigation bar. The bottom bar, when provided, is typically a tab bar.

TODO(featherless): Add link to specification.

TODO(featherless): Add conceptual screenshots of the various scenarios. To include:

- Only a top bar.
- Only a bottom bar.
- Two bars.

TODO(featherless): Discuss relationship to UIStackView introduced in iOS 9.

## Integration

The HeaderStackView can be treated like a typical UIView.

Create a header stack view:

    MDCHeaderStackView *headerStackView = [MDCHeaderStackView new];

You may provide a top bar:

    headerStackView.topBar = navigationBar;

You may provide a bottom bar:

    headerStackView.bottomBar = tabBar;

You'll certainly size the header stack view to fit:

    headerStackView.frame = self.view.bounds;
    [headerStackView sizeToFit];

Add the view:

    [self.view addSubview:headerStackView];
