<!--docs:
title: "Typography"
layout: detail
section: components
excerpt: "The Typography component provides methods for displaying text using the type sizes and opacities from the Material Design specifications."
iconId: typography
path: /catalog/typography/
-->

# Typography

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/typography.png" alt="Typography" width="375">
</div>

The Typography component provides methods for displaying text using the type sizes and opacities
from the Material Design specifications.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/style/typography.html">Typography</a></li>
</ul>

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/Typography'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

## Usage

### Importing

Before using Typography, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialTypography
```

#### Objective-C

``` objc
#import "MaterialTypography.h"
```
<!--</div>-->

### Font
Select a font most appropriate to its usage and set it as your label's font. All fonts are returned
from class methods beginning with the font's Material Design type style and ending with 'Font'.
Material Typography should be used consistently throughout the entire UI.

### Opacity
Each font has a respective opacity (alpha) value returned by class methods beginning with the
font's Material Design type style and ending with 'FontOpacity'. These CGFloats should be set on the
label's alpha property. If animating alpha, it should be the maximum value reached.

## Type Sizes and Opacities

`MDCTypography` provides a `UIFont` font and a `CGFloat` opacity for each of the standard type
settings in the Material Design specifications.

### Material Design type styles and their respective `MDCTypography` methods

| Material Design Type | MDCTypography Font | MDCTypography Opacity |
| -------------------- | ------------------ | --------------------- |
| Display 4 | display4Font | display4FontOpacity |
| Display 3 | display3Font | display3FontOpacity |
| Display 2 | display2Font | display2FontOpacity |
| Display 1 | display1Font | display1FontOpacity |
| Headline | headlineFont | headlineFontOpacity |
| Subheading | subheadFont | subheadFontOpacity |
| Body 2 | body2Font | body2FontOpacity |
| Body 1 | body1Font | body1FontOpacity |
| Caption | captionFont | captionFontOpacity |
| Button | buttonFont | buttonFontOpacity |
<!--{: .data-table }-->

### Font size reference
![Material Design Type Size](docs/assets/style_typography_styles_scale.png
                             "Shows the Material Design font sizes")
<!--{: .article__asset.article__asset--illustration }-->

### Font opacity reference
![Material Design Type Opacity](docs/assets/style_typography_styles_contrast.png
                                "Shows the Material Design font opacities")
<!--{: .article__asset.article__asset--illustration }-->

## Examples

### Create a Title Label

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let label = UILabel()
label.text = "This is a title"
label.font = MDCTypography.titleFont()
label.alpha = MDCTypography.titleFontOpacity()

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
label.sizeToFit()
self.view.addSubview(label)
```

#### Objective C

``` objc
UILabel *label = [[UILabel alloc] init];
label.text = @"This is a title";
label.font = [MDCTypography titleFont];
label.alpha = [MDCTypography titleFontOpacity];

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
[label sizeToFit];
[self.view addSubview:label];
```
<!--</div>-->

### Create a Display 1 Label

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let label = UILabel()
label.text = "Display 1"
label.font = MDCTypography.display1Font()
label.alpha = MDCTypography.display1FontOpacity()

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
label.sizeToFit()
self.view.addSubview(label)
```

#### Objective

``` objc
UILabel *label = [[UILabel alloc] init];
label.text = @"Display 1";
label.font = [MDCTypography display1Font];
label.alpha = [MDCTypography display1FontOpacity];

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
[label sizeToFit];
[self.view addSubview:label];

```
<!--</div>-->

### Set an Existing Label as a Caption Label

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
label.font = MDCTypography.captionFont()
label.alpha = MDCTypography.captionFontOpacity()

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
label.sizeToFit()
```
#### Objective C

``` objc
self.label.font = [MDCTypography captionFont];
self.label.alpha = [MDCTypography captionFontOpacity];

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
[self.label sizeToFit];
```
<!--</div>-->

## Advanced Usage

### Custom Fonts
Material Components for iOS allows you to set your own font for all of the components. Use the class
method `setFontLoader:` on MDCTypography to specify a loader that conforms to the
`MDCTypographyFontLoading` protocol.

If you want to use the system font use `MDCSystemFontLoader` which already conforms to the
`MDCTypographyFontLoading` protocol. It is used if no font loader is set.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
class CustomFontLoader: NSObject, MDCTypographyFontLoading {
  func regularFont(ofSize fontSize: CGFloat) -> UIFont {
    // Consider using MDFFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomRegularFont", size: fontSize)!
  }
  func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
    // Consider using MDFFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomMediumFont", size: fontSize)!
  }
  func lightFont(ofSize fontSize: CGFloat) -> UIFont {
    // Consider using MDFFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomLightFont", size: fontSize)!
  }
}

...

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

  // Before any UI is called
  MDCTypography.setFontLoader(CustomFontLoader())

}
```

#### Objective-C

``` objc
@interface CustomFontLoader : NSObject <MDCTypographyFontLoading>
@end

@implementation CustomFontLoader

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  // Consider using MDFFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomRegularFont" size:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  // Consider using MDFFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomMediumFont" size:fontSize];
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  // Consider using MDFFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomLightFont" size:fontSize];
}

@end

...

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Before any UI is called
  [MDCTypography setFontLoader:[[CustomFontLoader alloc] init]];
}
```
<!--</div>-->
