### Importing

To use the `MDCBannerView` in your code, import the MaterialBanner umbrella header (Objective-C) or MaterialComponents module (Swift).

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents
```

#### Objective-C

```objc
#import "MaterialBanner.h"
```

<!--</div>-->

### Appearance

By default, the `MDCBannerView` is configured to display an image view, a text label and two buttons. To hide the image view on `MDCBannerView`, users can set the `hidden` property on `imageView` to be true. Similarly, users can hide a button on banner view by setting the `hidden` property on `trailingButton` to be true.

### Styling

By default, the `MDCBannerView` is configured to display items with black text and white background. To customize the color and style of the text, image view and buttons displayed on `MDCBannerView`, directly set relevant properties, such as `tintColor`, on `textLabel`, `imageView`, `leadingButton` and `trailingButton`.

### LayoutMargins

`MDCBannerView` uses `layoutMargins` to manage the margins for elements on the banner view.
