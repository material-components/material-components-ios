# Typography

This component provides a way to stylize text according to the Material Typography spec.

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
