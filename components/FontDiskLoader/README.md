---
title:  "FontDiskLoader"
layout: detail
section: documentation
excerpt: "Registers a single custom font asset from disk."
---
#FontDiskLoader

Registers a single custom font asset from disk
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    See
    <a href="https://www.google.com/design/spec/typography.html">
      Typography
    </a>
    for more information
  </li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link">
    <a href="/apidocs/<FontDiskLoader>/Classes/MDCFontDiskLoader.html">
      MDCFontDiskLoader
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

~~~
pod 'MaterialComponents/FontDiskLoader'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~

- - -

## Overview

In order to use custom fonts on iOS the font assets need to be registered before they can be used.
We provide a component that lazily registers your font.

- - -

## Usage

Make sure to add your font (or the bundle it is in) to your app target. The FontDiskLoader will lazy
register the font using a CoreText API so adding a the font to your `info.plist` is not necessary.
All you need to do is intialize the loader with the font name and url to the file and ask for the
font.

## Code snippets

~~~
<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
  MDCFontDiskLoader *fontDiskLoader =
      [[MDCFontDiskLoader alloc] initWithName:nameOfFontInFile URL:fontURLOnDisk];
  UIFont *font = [fontDiskLoader fontOfSize:16];
~~~

#### Swift
~~~ swift
    let fontLoader = MDCFontDiskLoader.init(name: nameOfFontInFile, URL: fontURLOnDisk);
    let myFont:UIFont = fontLoader.fontOfSize(16)!;
}
~~~
<!--</div>-->
