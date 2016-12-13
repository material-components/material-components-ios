# Typography

<!--{% if site.link_to_site == "true" %}-->
[![Typography](docs/assets/typography.png)](docs/assets/typography.mp4)
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/typography.mp4" autoplay loop></video></div>{% endif %}-->

The Typography component provides methods for displaying text using the type sizes and opacities
from the Material Design specifications.
<!--{: .intro }-->

### Design Specifications

<ul class="icon-list">
<li class="icon-link"><a href="https://www.google.com/design/spec/style/typography.html">Typography</a></li>
</ul>

### API Documentation

<ul class="icon-list">
<li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Typography/apidocs/Classes/MDCTypography.html">MDCTypography</a></li>
<li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/FontDiskLoader/apidocs/Classes.html#/c:objc(cs)MDCSystemFontLoader">MDCSystemFontLoader</a></li>
<li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Typography/apidocs/Protocols/MDCTypographyFontLoading.html">MDCTypographyFontLoading</a></li>
</ul>

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/Typography'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

## Usage

### Importing

Before using Typography, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
import MaterialComponents.MaterialTypography
~~~

#### Objective-C

~~~ objc
#import "MaterialTypography.h"
~~~
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
<!--{: .illustration }-->

### Font opacity reference
![Material Design Type Opacity](docs/assets/style_typography_styles_contrast.png
                                "Shows the Material Design font opacities")
<!--{: .illustration }-->

## Examples

### Create a Title Label

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
import MaterialComponents.MaterialTypography

let label = UILabel()
label.text = "This is a title"
label.font = MDCTypography.titleFont()
label.alpha = MDCTypography.titleFontOpacity()

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
label.sizeToFit()
self.view.addSubview(label)
~~~

#### Objective C

~~~ objc
#import "MaterialTypography.h"

UILabel *label = [[UILabel alloc] init];
label.text = @"This is a title";
label.font = [MDCTypography titleFont];
label.alpha = [MDCTypography titleFontOpacity];

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
[label sizeToFit];
[self.view addSubview:label];

~~~
<!--</div>-->

### Create a Display 1 Label

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
import MaterialComponents.MaterialTypography

let label = UILabel()
label.text = "Display 1"
label.font = MDCTypography.display1Font()
label.alpha = MDCTypography.display1FontOpacity()

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
label.sizeToFit()
self.view.addSubview(label)
~~~

#### Objective

~~~ objc
#import "MaterialTypography.h"

UILabel *label = [[UILabel alloc] init];
label.text = @"Display 1";
label.font = [MDCTypography display1Font];
label.alpha = [MDCTypography display1FontOpacity];

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
[label sizeToFit];
[self.view addSubview:label];

~~~
<!--</div>-->

### Set an Existing Label as a Caption Label

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
import MaterialComponents.MaterialTypography

self.label.font = MDCTypography.captionFont()
self.label.alpha = MDCTypography.captionFontOpacity()

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
self.label.sizeToFit()
~~~
#### Objective C

~~~ objc
#import "MaterialTypography.h"

self.label.font = [MDCTypography captionFont];
self.label.alpha = [MDCTypography captionFontOpacity];

// If using autolayout, the following line is unnecessary as long
// as all constraints are valid.
[self.label sizeToFit];
~~~
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
~~~ swift
class CustomFontLoader: NSObject, MDCTypographyFontLoading {
  func regularFontOfSize(fontSize: CGFloat) -> UIFont {
    // Consider using MDCFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomRegularFont", size: fontSize)!
  }
  func mediumFontOfSize(fontSize: CGFloat) -> UIFont {
    // Consider using MDCFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomMediumFont", size: fontSize)!
  }
  func lightFontOfSize(fontSize: CGFloat) -> UIFont {
    // Consider using MDCFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomLightFont", size: fontSize)!
  }
}

...

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
... before any UI is called
  MDCTypography.setFontLoader(CustomFontLoader())
...
}
~~~

#### Objective-C

~~~ objc
@interface CustomFontLoader : NSObject <MDCTypographyFontLoading>
@end

@implementation CustomFontLoader

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  // Consider using MDCFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomRegularFont" size:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  // Consider using MDCFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomMediumFont" size:fontSize];
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  // Consider using MDCFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomLightFont" size:fontSize];
}

@end

...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
... before any UI is called
    [MDCTypography setFontLoader:[[CustomFontLoader alloc] init];
...
}
~~~
<!--</div>-->
