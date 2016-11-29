<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/RobotoFontLoader/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/material-components/material-components-ios/tree/develop/components/RobotoFontLoader">GitHub</a> for README documentation.{% endif %}-->

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
#### Objective-C

~~~ objc
#import "MaterialRobotoFontLoader.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

### Dependencies

The Roboto Font Loader Component depends on the FontDiskLoader Component.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
UIFont *font = [[MDCRobotoFontLoader sharedInstance] regularFontOfSize:16];
~~~

#### Swift
~~~ swift
let myFont:UIFont = [[MDCRobotoFontLoader sharedInstance] regularFontOfSize:16];
}
~~~
<!--</div>-->

## Advanced Usage
### Typography's weak dependency
When included in your build the Roboto Font Loader is used by the Typography component. This runtime
check occurs when no specific Font Loader is set on Typography, resulting in Roboto being used for
Material Typography.
For more information see
[Typography](https://github.com/material-components/material-components-ios/tree/develop/components/Typography).
