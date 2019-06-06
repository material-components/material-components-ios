# Typography Scheme

The Material Design typography system can be used to create a type hierarchy that reflects your
brand or style. A _typography scheme_ represents your theme's specific fonts, such as its body
font or button font.

## Design & API documentation

* [Material Design guidelines: Typography theming](https://material.io/go/design-typography-theming)

## Related documentation

* [Theming](../../)

<!-- toc -->

- - -

## Overview

An implementation of the Material Design typography scheme is provided in the `MDCTypographyScheme`
class. By default, an instance of this class is configured with the Material defaults. While it is
possible to use these defaults out of the box, you are encouraged to customize these fonts to
better represent your branch.

Most components with text elements support being themed with a typography scheme using a
`typography themer` extension. You can learn more about which extensions are available for a given
component by reading the [component documentation](../../../).

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

- [Dynamic Type](dynamic-type.md)
