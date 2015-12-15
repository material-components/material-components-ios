# Typography

Typography provides methods for displaying text in [material styles](https://www.google.com/design/spec/style/typography.html). Mostly centered around fonts and their opacity.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objectivec
#import "MaterialTypography.h"

UILabel *label = [[UILabel alloc] init];
label.text = @"This is sometext";
label.font = [MDCTypography titleFont];
label.alpha = [MDCTypography titleFontOpacity];

[label sizeToFit];
[self.view addSubview:label];
```
## Font sizes
![type size](gfx/style_typography_styles_scale.png "shows the various font sizes")
Source: [Typography scale spec](https://www.google.com/design/spec/style/typography.html#typography-styles).

## Font opacities
![type opacity](gfx/style_typography_styles_contrast.png "shows the various font opacities")
Source: [Typography opacity spec](https://www.google.com/design/spec/style/typography.html#typography-other-typographic-guidelines).
