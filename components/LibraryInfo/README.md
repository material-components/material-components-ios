<!--docs:
title: "Library info"
layout: detail
section: components
excerpt: "Library info contains programmatic access to information about the Material Components library."
iconId: misc
path: /catalog/library-info/
api_doc_root: true
-->

# Library Info

Library info contains programmatic access to information about the Material Components library.

## Installation

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```bash
pod 'MaterialComponents/LibraryInfo'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

- - -

## Overview

The Library Info object provides information about the Material Components library compiled into
this binary.

- - -

## Usage

### Importing

Before using LibraryInfo, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents
```

#### Objective-C

```objc
#import "MaterialLibraryInfo.h"
```
<!--</div>-->

### Accessing the library information

LibraryInfo contains a singleton class of type LibraryInfo that can be queried.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
print("This binary was compiled with MDC-iOS v" + MDCLibraryInfo.version + ".")
```

#### Objective-C

```objc
NSLog(@"This binary was compiled with MDC-iOS v%@.", MDCLibraryInfo.version);
```
<!--</div>-->
