<!--docs:
title: "Shape scheme"
layout: detail
section: components
excerpt: "The Material shape scheme provides support for theming an app with a semantic set of shapes."
iconId: themes
path: /catalog/theming/shape/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme schemes/Shape -->

# Shape scheme

The Material Design shape system can be used to create a shape theme that reflects your brand or
style. A _shape scheme_ represents your theme's specific shape values, such as the shape values of large container components.

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-color-theming">Material Design guidelines: Color theming</a></li>
</ul>

## Related documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../">Theming</a></li>
</ul>

## Table of contents

- [Overview](#overview)
  - [Semantic color values](#semantic-color-values)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use: customizing a color scheme](#typical-use-customizing-a-color-scheme)

- - -

## Overview

An implementation of the Material Design color scheme is provided in the `MDCSemanticColorScheme`
class. By default, an instance of this class is configured with the Material defaults. While it is
possible to use these defaults out of the box, you are highly encouraged to set — at a minimum — the
primary and secondary color values. The following image shows an MDCButton themed with the default
color scheme values (top) and an MDCButton themed with custom color scheme values (bottom).

<img src="docs/assets/themedbuttons.png" width="144" alt="An MDCButton themed with the default color scheme and a custom one.">

Most components support being themed with a color scheme using a `color themer` extension. You can
learn more about which extensions are available for a given component by reading the
[component documentation](../../).

### Semantic color values

A color scheme consists of the following semantic color values:

| Color name            | Use        |
|:--------------------- |:---------- |
| `primaryColor`        | The color displayed most frequently across your app’s screens and components. |
| `primaryColorVariant` | A light or dark variation of the primary color. |
| `secondaryColor`      | Provides ways to accent and distinguish your product. Floating action buttons use the secondary color. |
| `errorColor`          | The indication of errors within components such as text fields. |
| `surfaceColor`        | Typically maps to the background of components such as cards, sheets, and dialogs. |
| `backgroundColor`     | Typically found behind scrollable content. |

Each of these colors are paired with a corresponding "on-color". An on color defines the
color for text and iconography drawn on top of the associated color. Take care when picking on
colors that they meet [the accessibility guidelines for text and contrasting color](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html).

| On color name         | Use        |
|:--------------------- |:---------- |
| `onPrimaryColor`      | Text/iconography drawn on top of `primaryColor`. |
| `onSecondaryColor`    | Text/iconography drawn on top of `secondaryColor`. |
| `onErrorColor`        | Text/iconography drawn on top of `errorColor`. |
| `onSurfaceColor`      | Text/iconography drawn on top of `surfaceColor`. |
| `onBackgroundColor`   | Text/iconography drawn on top of `backgroundColor`. |

## Installation

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/schemes/ColorScheme'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To import the component:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialColorScheme
```

#### Objective-C

```objc
#import "MaterialColorScheme.h"
```
<!--</div>-->

## Usage

<!-- Extracted from docs/typical-use-customizing-a-scheme.md -->

### Typical use: customizing a color scheme

You'll typically want to create one default `MDCSemanticColorScheme` instance for your app where all
of the color properties are set to your desired brand or style.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let colorScheme = MDCSemanticColorScheme()
colorScheme.primaryColor = UIColor(red: CGFloat(0x21) / 255.0,
                                   green: CGFloat(0x21) / 255.0,
                                   blue: CGFloat(0x21) / 255.0,
                                   alpha: 1)
colorScheme.primaryColorVariant = UIColor(red: CGFloat(0x44) / 255.0,
                                   green: CGFloat(0x44) / 255.0,
                                   blue: CGFloat(0x44) / 255.0,
                                   alpha: 1)

// In this case we don't intend to use a secondary color, so we make it match our primary color
colorScheme.secondaryColor = colorScheme.primaryColor
```

#### Objective-C

```objc
// A helper method for creating colors from hex values.
static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [[UIColor alloc] initWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                                green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                                 blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
colorScheme.primaryColor = ColorFromRGB(0x212121);
colorScheme.primaryColorVariant = ColorFromRGB(0x444444);

// In this case we don't intend to use a secondary color, so we make it match our primary color
colorScheme.secondaryColor = colorScheme.primaryColor;
```
<!--</div>-->

