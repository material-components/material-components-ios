---
title:  "Header Stack View"
layout: detail
section: documentation
---
# Header Stack View

![Header Stack View](docs/assets/headerstackview_screenshot.png)
<!--{: .ios-screenshot .right }-->

The Header Stack View component is a view that coordinates the layout of two vertically-stacked
bar views.
<!--{: .intro }-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/">TODO</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/apidocs/HeaderStackView/Classes/MDCHeaderStackView.html">MDCHeaderStackView</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.


### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
$ pod 'MaterialComponents/HeaderStackView'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~


- - -

## Usage

This view's sole purpose is to facilitate the relative layout of its two bars in a predictable way.

The top bar is typically a navigation bar. The bottom bar, when provided, is typically a tab bar.

TODO(featherless): Add link to specification (do this above).

TODO(featherless): Add conceptual screenshots of the various scenarios. To include:

- Only a top bar.
- Only a bottom bar.
- Two bars.

TODO(featherless): Discuss relationship to UIStackView introduced in iOS 9.


- - -

## Integration

The HeaderStackView can be treated like a typical UIView.

Create a header stack view:

~~~ objc
MDCHeaderStackView *headerStackView = [MDCHeaderStackView new];
~~~

You may provide a top bar:

~~~ objc
headerStackView.topBar = navigationBar;
~~~

You may provide a bottom bar:

~~~ objc
headerStackView.bottomBar = tabBar;
~~~

You'll certainly size the header stack view to fit:

~~~ objc
headerStackView.frame = self.view.bounds;
[headerStackView sizeToFit];
~~~

Add the view:

~~~ objc
[self.view addSubview:headerStackView];
~~~

