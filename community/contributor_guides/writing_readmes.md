# Writing component README.md files

This guide provides the essential recommendations for writing component README.md files.

## Template README.md

This is the basic template for a component's README.md. Parts that you, the writer, are expected to
fill out have been marked with `TODO` statements.

~~~
---
title:  "TODO: ComponentName"
layout: detail
section: documentation
excerpt: "TODO: Single sentence description of the component."
---
# App Bar

![TODO: ComponentName](docs/assets/screenshot.png)
<!--{: .ios-screenshot .right }-->

TODO: Single sentence description of the component.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/<TODO: link to spec>">TODO: link to spec</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/apidocs/<ComponentName>/Classes/<TODO: API name>.html">TODO: API name</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/TODO: ComponentName'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~



- - -

## Overview

TODO *Optional section*. Provide a high level overview of the component here. This is a good place
to provide:

- comparisons with related UIKit APIs, and
- explanations of the overall component structure.



- - -

## Usage

TODO **Required section**. Provide essential integration steps here.

Remember that the audience for this section is someone completely new to using Material components;
don't assume or expect the reader to have read another component's README. At best you can assume
that the reader read the Quick Start guide.

### Additional information section

TODO **Recommended section**. These breakout sections are a perfect opportunity to talk about edge
case behaviors.
~~~

## Code snippets

Every code snippet must provide both an Objective-C version and a Swift version. Consult the
document on [Supported Versions](supported_versions.md) for information on which version of the
Swift language to use when writing examples.

~~~
<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
- (void)viewDidLoad {
  [super viewDidLoad];

  ...

  // After all other views have been registered.
  MDCAppBarAddViews(self);
}
~~~

#### Swift
~~~ swift
override func viewDidLoad() {
  super.viewDidLoad()

  // After all other views have been registered.
  MDCAppBarAddViews(self)
}
~~~
<!--</div>-->
~~~
