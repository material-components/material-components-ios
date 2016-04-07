---
title:  "TODO: Roboto Font Loader"
layout: detail
section: documentation
excerpt: "The Roboto Font Loader lazy loads the Robot font."
---
# Roboto Font Loader

The Roboto Font Loader lazy loads the Roboto font.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://www.google.com/design/spec/resources/roboto-noto-fonts.html">
      Roboto font resource
    </a>
  </li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link">
    <a href="/apidocs/RobotoFontLoader/Classes/MDCRobotoFontLoader.html">
      MDCRobotoFontLoader
    </a>
  </li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the
following to your `Podfile`:

```
pod 'MaterialComponents/RobotoFontLoader'
```

Then, run the following command:

~~~ bash
$ pod install
~~~

## Usage

### Importing

Before using Roboto Font Loader, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialRobotoFontLoader.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

## Advanced Usage
### Typography's weak dependency
By default the Roboto Font Loader is used by the Typography component. For more
information see
[Typography](https://github.com/google/material-components-ios/tree/develop/components/Typography).
