<!--docs:
title: "Header Stack Views"
layout: detail
section: components
excerpt: "The Header Stack View component is a view that coordinates the layout of two vertically stacked bar views."
iconId: header
path: /header-stack-views/
-->

# Header Stack Views

<!--{% if site.link_to_site == "true" %}-->
<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/header_stack_view.png" alt="Header Stack View" width="320">
</div>
<!--{% else %}
<div class="article__asset article__asset--screenshot" markdown="1">
  <video src="docs/assets/header_stack_view.mp4" autoplay loop></video>
</div>
{% endif %}-->

The Header Stack View component is a view that coordinates the layout of two vertically stacked
bar views.
<!--{: .article__intro }-->

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/layout/structure.html#structure-app-bar">App Bar</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.


### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/HeaderStackView'
```

Then, run the following command:

``` bash
pod install
```


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
#### Swift
``` swift
import MaterialComponents.MaterialHeaderStackView
```

#### Objective-C

``` objc
#import "MaterialHeaderStackView.h"
```
<!--</div>-->


Header Stack View provides MDCHeaderStackView, which is a UIView subclass.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let headerStackView = MDCHeaderStackView()
```

#### Objective-C

``` objc
MDCHeaderStackView *headerStackView = [[MDCHeaderStackView alloc] init];
```
<!--</div>-->

You may provide a top bar:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
headerStackView.topBar = navigationBar
```

#### Objective-C

``` objc
headerStackView.topBar = navigationBar;
```
<!--</div>-->

You may provide a bottom bar:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
headerStackView.bottomBar = tabBar
```

#### Objective-C

``` objc
headerStackView.bottomBar = tabBar;
```
<!--</div>-->
