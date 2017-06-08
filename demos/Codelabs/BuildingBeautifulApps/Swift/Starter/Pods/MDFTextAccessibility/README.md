MDFTextAccessibility assists in selecting text colors that will meet the
[W3C standards for accessibility](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html).

[![Build Status](https://travis-ci.org/material-foundation/material-text-accessibility-ios.svg?branch=develop)](https://travis-ci.org/material-foundation/material-text-accessibility-ios)
[![Code Coverage](http://codecov.io/github/material-foundation/material-text-accessibility-ios/coverage.svg?branch=develop)](http://codecov.io/github/material-foundation/material-text-accessibility-ios?branch=develop)

*May 24, 2016: We're still staging MDFTextAccessibility, feel free to poke
around, but non-code things like CocoaPods support and continuous integration
testing will be ramping up over the next few weeks. The API is relatively stable
at this point.*

## Accessibility of text

Apps created for the widest range of users should ensure that users can read
text presented over any background. While the legibility of text depends on many
things, a great start is to provide a sufficiently large *contrast ratio*
between foreground text colors and their background colors. The contrast ratio
of two colors is a measurement of how much the brightness of two colors differ.
For example, white on dark grey might have a contrast ratio of 9:1, while white
on medium grey might only have a contrast ratio of 4:1. In general, larger
contrast ratios are better and will ensure the widest range of users can easily
read the text in your app.

The [W3C](https://www.w3.org)'s
[Web Content Accessibility Guidelines](https://www.w3.org/TR/WCAG/#visual-audio-contrast)
contains two recommendations for text contrast ratios:

1. Minimum contrast: text should have a contrast ratio of at least 4.5:1,
   except for "large" text, which can have a contrast ratio of 3:1.
2. Enhanced contrast: text should have a contrast ratio of at least 7:1, except
   for large text, which can have a contrast ratio of 4.5:1.

"Large" text is nominally defined as at least 18pt in a normal font face or at
least 14pt in a bold font face. For more information (including some important
exceptions), see the
[Guidelines](https://www.w3.org/TR/WCAG/#visual-audio-contrast).

## Computing contrast ratios

Computing acceptable contrast ratios involves the foreground color, the
background color, the text size, and the transparency of the foreground color,
if any. MDFTextAccessibility provides convenient access to colors that will
automatically give acceptable contrast ratios.

For methods that return a UIColor, the color along with its alpha is guaranteed
to provide a contrast ratio meeting the minimum ratios recommended by the W3C.
The returned alpha may be greater than the requested alpha to ensure acceptable
contrast ratios, that is, the returned color may be more opaque than requested
to ensure that the text remains legible.

## Legible text on images

Displaying text legibly on arbitrary images is difficult because the image
content can conflict with the text. Images with smooth gradients or blurred
regions are likely to result in more legible text; images with many details and
high contrast are less likely to result in legible text.

MDFTextAccessibility provides methods that attempt to select a good color for
displaying text on a particular image, but the quality of the results will
depend on the contents of the image. If the content of the image is not known
(for example, when images provided by the user), then consider using a
semi-transparent shim between the image and the text to increase contrast.

## Usage

### Basic usage

The simplest usage is to select between black and white text depending on the
background color, irrespective of the font:

```objective-c
label.textColor = [MDFTextAccessibility textColorOnBackgroundColor:label.backgroundColor
                                                         textAlpha:1
                                                              font:nil];
```

Many design standards for user interfaces use text colors that are not fully
opaque. However, transparent text can reduce legibility, so you can request a
color that is as close as possible to a particular alpha value while still being
legible:

```objective-c
label.textColor = [MDFTextAccessibility textColorOnBackgroundColor:label.backgroundColor
                                                   targetTextAlpha:0.85
                                                              font:nil];
```

Since the W3C recommends different contrast ratios for "normal" and "large"
text, including the font can result in a text color closer to your target alpha
when appropriate:

```objective-c
label.textColor = [MDFTextAccessibility textColorOnBackgroundColor:label.backgroundColor
                                                         textAlpha:0.85
                                                              font:label.font];
```

### Advanced usage

For more advanced usage, such as selecting from a set of colors other than white
and black, see MDFTextAccessibility's
`textColorFromChoices:onBackgroundColor:options:`.

## License

MDFTextAccessiblity is licensed under the [Apache License Version 2.0](LICENSE).
