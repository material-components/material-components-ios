<!--docs:
title: "Typography scheme"
layout: detail
section: components
excerpt: "The Material Design typography system can be used to create a type hierarchy that reflects your brand or style."
iconId: themes
path: /catalog/theming/typography/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme schemes/Typography -->

# Typography Scheme

The Material Design typography system can be used to create a type hierarchy that reflects your
brand or style. A _typography scheme_ represents your theme's specific fonts, such as its body
font or button font.

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-typography-theming">Material Design guidelines: Typography theming</a></li>
</ul>

## Related documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../">Theming</a></li>
</ul>

## Table of contents

- [Overview](#overview)
  - [Semantic typography values](#semantic-typography-values)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Dynamic Type](#dynamic-type)

- - -

## Overview

An implementation of the Material Design typography scheme is provided in the `MDCTypographyScheme`
class. By default, an instance of this class is configured with the Material defaults. While it is
possible to use these defaults out of the box, you are encouraged to customize these fonts to
better represent your branch.

Most components with text elements support being themed with a typography scheme using a
`typography themer` extension. You can learn more about which extensions are available for a given
component by reading the [component documentation](../../).

### Semantic typography values

A typography scheme includes the following semantic font style values, some of which have multiple
numbered variants. The fonts are sized in decreasing size.  headline1 is larger than headline2
which is larger than headline3 and so on.

| Color name    | Use        |
|:--------------|:---------- |
| `headline`    | The largest text on the screen, reserved for short, important text or numerals. |
| `subtitle`    | Smaller than headline, typically reserved for medium-emphasis text that is shorter in length. |
| `body`        | Typically used for long-form writing. |
| `caption`     | One of the smallest font sizes, may be used sparingly to annotate other visual elements. |
| `button`      | Used in calls to action, such as buttons or tabs. |
| `overline`    | One of the smallest font sizes, might be used to introduce a headline. |

## Installation

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/schemes/Typography'
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
import MaterialComponents.MaterialTypographyScheme
```

#### Objective-C

```objc
#import "MaterialTypographyScheme.h"
```
<!--</div>-->

## Usage

<!-- Extracted from docs/dynamic-type.md -->

### Dynamic Type

#### Overview

Users configure text styles on fonts, such as caption and overline, included in a typography scheme. Then, these scalable fonts can be used for [Dynamic Type](../../Typography) for components. Some default versions of MDCTypographyScheme include scalable fonts. The inline documentation indicates whether a default version of MDCTypographyScheme consists of scalable fonts or not.

#### useCurrentContentSizeCategoryWhenApplied

`useCurrentContentSizeCategoryWhenApplied` is a property on MDCTypographyScheme. This property only has an effect if the fonts stored on the typography scheme are scalable. It indicates whether the scalable font on the scheme should be adjusted with respect to the current content size category when it is applied on a component.

