<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/FontDiskLoader/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/material-components/material-components-ios/tree/develop/components/FontDiskLoader">GitHub</a> for README documentation.{% endif %}-->

#FontDiskLoader

Registers a single custom font asset from disk
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://www.google.com/design/spec/typography.html">
      Typography
    </a>
  </li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://material-ext.appspot.com/mdc-ios-preview/components/FontDiskLoader/apidocs/Classes/MDCFontDiskLoader.html">
      MDCFontDiskLoader
    </a>
  </li>
</ul>

## Overview

In order to use custom fonts on iOS the font assets need to be registered before they can be used.
Font Disk Loader lazily registers your custom fonts.

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/FontDiskLoader'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

### Importing

Before using Font Disk Loader, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialFontDiskLoader.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

## Usage

Make sure to add your font (or the bundle it is in) to your app target. The FontDiskLoader will lazy
register the font using a CoreText API so adding a the font to your `info.plist` is not necessary.
All you need to do is initialize the loader with the font name and url to the file and ask for the
font.

## Code snippets

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
  MDCFontDiskLoader *fontDiskLoader =
      [[MDCFontDiskLoader alloc] initWithFontName:nameOfFontInFile URL:fontURLOnDisk];
  UIFont *font = [fontDiskLoader fontOfSize:16];
~~~

#### Swift
~~~ swift
    let fontLoader = MDCFontDiskLoader.init(fontName: nameOfFontInFile, fontURL: fontURLOnDisk);
    let myFont:UIFont = fontLoader.fontOfSize(16)!;
~~~
<!--</div>-->
