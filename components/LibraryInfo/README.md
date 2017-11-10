<!--docs:
title: "Library Info"
layout: detail
section: components
excerpt: "LibraryInfo contains programmtic access to information about the Material Components library."
iconId: misc
path: /catalog/library-info/
api_doc_root: true
-->

# Library information

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/layout/structure.html#structure-app-bar">Material Design guidelines: App Bar Structure</a></li>
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/patterns/scrolling-techniques.html">Material Design guidelines: Scrolling Techniques</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBar.html">API: MDCAppBar</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarContainerViewController.html">API: MDCAppBarContainerViewController</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/LibraryInfo'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

- - -

## Overview

The Library Info object provides information about the Material Components library compiled into
this binary.

- - -

## Usage

### Importing

Before using App Bar, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents
```

#### Objective-C

``` objc
#import "MaterialLibraryInfo.h"
```
<!--</div>-->

### Accessing the library information

LibraryInfo contains a singleton class of type LibraryInfo that can be queried.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
print("This binary was compiled with MDC-iOS v" + MDCLibraryInfo.version + ".")
```

#### Objective-C

``` objc
NSLog(@"This binary was compiled with MDC-iOS v%@.", MDCLibraryInfo.version);
```
<!--</div>-->
