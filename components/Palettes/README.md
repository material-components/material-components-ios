<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/Palettes/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/material-components/material-components-ios/tree/develop/components/Palettes">GitHub</a> for README documentation.{% endif %}-->

# Palettes

The Palettes component provides Material colors organized into similar palettes.
<!--{: .intro }-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="http://www.google.com/design/spec/style/color.html#color-color-palette">Color palettes</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Palettes/apidocs/Classes/MDCPalette.html">MDCPalette</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/Palettes'
~~~

Then, run the following command:

~~~ bash
pod install
~~~


- - -

## Usage

### Importing

Before using Palettes, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialPalettes.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

### Using palettes

Much like UIColor objects, MDCPalette objects are immutable static objects you can use to obtain
Material colors. All palettes have a set of tints with lower numbers being lighter colors and higher
numbers being darker colors. The 500 tint is the most common representative color for its respective
palette. Most palettes (but not all) also have a set of accent colors following a similar naming
scheme.

- - -

## Examples

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
view.backgroundColor = [MDCPalettes greenPalette].tint500;
~~~

#### Swift

~~~ swift
view.backgroundColor = MDCPalettes.greenPalette().tint500;
~~~

<!--</div>-->
