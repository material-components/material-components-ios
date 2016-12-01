# Header Stack View

<!--{% if site.link_to_site == "true" %}-->
[![Header Stack View](docs/assets/header_stack_view.png)](docs/assets/header_stack_view.mp4)
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/header_stack_view.mp4" autoplay loop></video></div>{% endif %}-->

The Header Stack View component is a view that coordinates the layout of two vertically stacked
bar views.
<!--{: .intro }-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/layout/structure.html#structure-app-bar">App Bar</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/HeaderStackView/apidocs/Classes/MDCHeaderStackView.html">MDCHeaderStackView</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.


### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/HeaderStackView'
~~~

Then, run the following command:

~~~ bash
pod install
~~~


- - -

## Overview

This view's sole purpose is to facilitate the relative layout of two horizontal bars. The bottom bar
will bottom align and be of fixed height. The top bar will stretch to fill the remaining space if
there is any.

The top bar is typically a navigation bar. The bottom bar, when provided, is typically a tab bar.



- - -

## Usage

### Importing

Before using Header Stack View, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialHeaderStackView.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->


Header Stack View provides MDCHeaderStackView, which is a UIView subclass.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
MDCHeaderStackView *headerStackView = [[MDCHeaderStackView alloc] init];
~~~

#### Swift
~~~ swift
let headerStackView = MDCHeaderStackView()
~~~
<!--</div>-->

You may provide a top bar:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
headerStackView.topBar = navigationBar;
~~~

#### Swift
~~~ swift
headerStackView.topBar = navigationBar
~~~
<!--</div>-->

You may provide a bottom bar:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
headerStackView.bottomBar = tabBar;
~~~

#### Swift
~~~ swift
headerStackView.bottomBar = tabBar
~~~
<!--</div>-->
