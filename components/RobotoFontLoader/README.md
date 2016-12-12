# Roboto Font Loader

The Roboto Font Loader lazy loads the Roboto font.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://www.google.com/design/spec/resources/roboto-noto-fonts.html">
      Roboto font resource
    </a>
  </li>
  <li class="icon-link">
    <a href="https://www.google.com/design/spec/typography.html">
      Typography
    </a>
  </li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://material-ext.appspot.com/mdc-ios-preview/components/RobotoFontLoader/apidocs/Classes/MDCRobotoFontLoader.html">
      MDCRobotoFontLoader
    </a>
  </li>
</ul>

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/RobotoFontLoader'
```

Then, run the following command:

~~~ bash
pod install
~~~

## Usage

The Roboto Font Loader Component provides APIs for getting the Roboto Fonts. Consider using the
Typography Component for font styles recomended by Material spec.

### Importing

Before using Roboto Font Loader, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
import MaterialComponents
~~~

#### Objective-C

~~~ objc
#import "MaterialRobotoFontLoader.h"
~~~
<!--</div>-->

### Dependencies

The Roboto Font Loader Component depends on the FontDiskLoader Component.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
let myFont:UIFont = [[MDCRobotoFontLoader sharedInstance] regularFontOfSize:16];
~~~
<!--</div>-->

## Advanced Usage
### Typography

Set the `MDCRobotoFontLoader` as `MDCTypography`'s fontLoader in order to use Roboto for all
components.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
  MDCTypography.setFontLoader(MDCRobotoFontLoader.sharedInstance())
  ...
}
~~~

#### Objective-C
~~~ objc
- (BOOL)application:(UIApplication *)application
    willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [MDCTypography setFontLoader:[MDCRobotoFontLoader sharedInstance]];
    ...
}
~~~
<!--</div>-->

For more information see
[Typography](https://github.com/material-components/material-components-ios/tree/develop/components/Typography).

### The font bundle
If you are not using `RobotoFontLoader` it is recommended that you not depend on it in your App's
podspec. We make this recommendation because the subspec comes with a 1.1mb bundle holding the
fonts. This means you should not depend on the entire Material Components for iOS spec and you
should just pull in the components, the subspecs, that you use.

The easiest way to determine if you are depending on RobotoFontLoader is by checking if your
Podfile.lock has:

~~~ bash
MaterialComponents/RobotoFontLoader
~~~

If it does, one of your specs depends on RobotoFontLoader and its fonts will be added to your App.
