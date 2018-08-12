### Background images

This example shows how to add a custom background image view to a flexible header.

You can create and add a UIImageView subview to the flexible header view's content view:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let headerView = headerViewController.headerView

let imageView = ...
imageView.frame = headerView.bounds
imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
headerView.contentView.insertSubview(imageView, at: 0)

imageView.contentMode = .scaleAspectFill
imageView.clipsToBounds = true
```

#### Objective-C
```objc
UIImageView *imageView = ...;
imageView.frame = self.headerViewController.headerView.bounds;
imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
[self.headerViewController.headerView.contentView insertSubview:imageView atIndex:0];

imageView.contentMode = UIViewContentModeScaleAspectFill;
imageView.clipsToBounds = YES;
```
<!--</div>-->

Notes:

- Add the image view to the header view's `contentView`, not the header view itself.
- Set the `contentMode` to "ScaleAspectFill" to ensure that the image always fills the available
  header space, even if the image is too small. This is usually preferred, but consider changing
  the contentMode if you want a different behavior.
- Enable `clipsToBounds` in order to ensure that your image view does not bleed past the bounds of
  the header view. The header view's `clipsToBounds` is disabled by default.
