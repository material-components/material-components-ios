---
title:  "Typography"
layout: detail
section: documentation
---
# Typography

The Typography component provides methods for displaying text using the type sizes and opacities
from the Material Design specifications.
<!--{: .intro }-->

### Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/style/typography.html">Typography</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/apidocs/Typography/Classes/MDCFontResource.html">MDCFontResource</a></li>
  <li class="icon-link"><a href="/apidocs/Typography/Classes/MDCRobotoFontLoader.html">MDCRobotoFontLoader</a></li>
  <li class="icon-link"><a href="/apidocs/Typography/Classes.html#/c:objc(cs)MDCSystemFontLoader">MDCSystemFontLoader</a></li>
  <li class="icon-link"><a href="/apidocs/Typography/Classes/MDCTypography.html">MDCTypography</a></li>
  <li class="icon-link"><a href="/apidocs/Typography/Protocols/MDCTypographyFontLoader.html">MDCTypographyFontLoader</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add the Typography component to your Xcode project using CocoaPods, add the following to your PodFile:

~~~ bash
$ pod 'MaterialComponents/Typography'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~


- - -

## Usage

<!--<div class="material-code-render" markdown="1">-->
### Objective C

~~~ objc
#import "MaterialTypography.h"

UILabel *label = [[UILabel alloc] init];
label.text = @"This is a title";
label.font = [MDCTypography titleFont];
label.alpha = [MDCTypography titleFontOpacity];

[label sizeToFit];
[self.view addSubview:label];

~~~

### Swift
~~~ swift
let label = UILabel()
label.text = "This is a title"
label.font = MDCTypography.titleFont()
label.alpha = MDCTypography.titleFontOpacity()

label.sizeToFit()
self.view.addSubview(label)
~~~
<!--</div>-->



- - -

## Type Sizes and Opacities

`MDCTypography` provides a `UIFont` font and a `CGFloat` opacity for each of the standard type settings in the Material Design
specifications.

### Material Design type styles and their respective `MDCTypography` methods.

| Material Design Type | MDCTypography Font | MDCTypography Opacity |
| Display 4 | display4Font | display4Opacity |
| Display 3 | display3Font | display3Opacity |
| Display 2 | display2Font | display2Opacity |
| Display 1 | display1Font | display1Opacity |
| Headline | headlineFont | headlineOpacity |
| Subheading | subheadFont | subheadOpacity |
| Body 2 | body2Font | body2Opacity |
| Body 1 | body1Font | body1Opacity |
| Caption | captionFont | captionOpacity |
| Button | buttonFont | buttonOpacity |
<!--{: .data-table }-->

### Font size reference
![Material Design Type Size](docs/assets/style_typography_styles_scale.png "Shows the Material Design font
sizes")
<!--{: .illustration }-->

### Font opacity reference
![Material Design Type Opacity](docs/assets/style_typography_styles_contrast.png "Shows the Material Design font
opacities")
<!--{: .illustration }-->


