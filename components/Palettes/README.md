<!--docs:
title: "Palettes"
layout: detail
section: components
excerpt: "The Palettes component provides Material color palettes."
iconId: color
path: /catalog/palette/
api_doc_root: true
-->

# Palettes

The Palettes component provides Material colors organized into similar palettes.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-color-theming#color-color-palette">Material Design guidelines: Color palettes</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/palette/api-docs/Classes/MDCPalette.html">API: MDCPalette</a></li>
</ul>

- - -

## Installation

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Palettes'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```


- - -

## Usage

### Importing

Before using Palettes, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialPalettes
```

#### Objective-C

```objc
#import "MaterialPalettes.h"
```
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
#### Swift

```swift
view.backgroundColor = MDCPalette.green.tint500
```

#### Objective-C

```objc
self.view.backgroundColor = MDCPalette.greenPalette.tint500;
```
<!--</div>-->
