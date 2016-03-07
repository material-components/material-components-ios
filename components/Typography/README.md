---
layout: post
title:  "Typography"
date:   2016-03-01 20:15:01 -0500
categories: documentation
---
# Typography

The Typography component provides methods for displaying text in [material styles]
(https://www.google.com/design/spec/style/typography.html), focusing on fonts and their opacity.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objective-c
#import "MaterialTypography.h"

UILabel *label = [[UILabel alloc] init];
label.text = @"This is a title";
label.font = [MDCTypography titleFont];
label.alpha = [MDCTypography titleFontOpacity];

[label sizeToFit];
[self.view addSubview:label];
```

```swift
let label = UILabel()
label.text = "This is a title"
label.font = MDCTypography.titleFont()
label.alpha = MDCTypography.titleFontOpacity()

label.sizeToFit()
self.view.addSubview(label)
```

## Font sizes
![type size](docs/assets/style_typography_styles_scale.png "shows the various font
sizes")
Source: [Typography style spec]
(https://www.google.com/design/spec/style/typography.html#typography-styles)

## Font opacities
![type opacity](docs/assets/style_typography_styles_contrast.png "shows the various font
opacities")
Source: [Typography opacity spec]
(https://www.google.com/design/spec/style/typography.html#typography-other-typographic-guidelines)
