# Icons

This component provides a subset of the Material Design icons found at
https://github.com/google/material-design-icons.

Each Material icon is contained within its own bundle and can be individually added to a project.
This allows you to have complete control over the image assets you pull into your application.

## Installation with CocoaPods

To add an icon to your Xcode project using CocoaPods, add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Icons/ic_arrow_back'
```

Then, run the following command:

```bash
pod install
```

## Integration

We've provided convenience methods for accessing icons. Each icon has its own header that extends
the MDCIcons class with a static method.

To access an icon's helper methods, import the corresponding header:

    #import "MaterialIcons+ic_arrow_back.h"

To load an icon from disk, use the corresponding `pathFor` method:

    UIImage *backButtonImage = [UIImage imageWithContentsOfFile:[MDCIcons pathFor_ic_arrow_back]];

You are free to cache the resulting image as you see fit for your application.
