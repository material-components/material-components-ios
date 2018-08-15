### WKWebView considerations

When a WKWebView with content that is smaller than the screen is set as a tracking scroll view for
a flexible header, the WKWebView's scroll view may not correctly calculate its contentSize.height.
This bug manifests as a small web page that is scrollable when it shouldn't be and can most easily
be reproduced by loading a simple HTML string into a WKWebView with a single word in the body tag.

To fix this bug, at a minimum you must enable the new runtime behavior
`useAdditionalSafeAreaInsetsForWebKitScrollViews` and set a `topLayoutGuideViewController`. Doing so
will fix the bug on iOS 11 and up.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
flexibleHeaderViewController.useAdditionalSafeAreaInsetsForWebKitScrollViews = true
flexibleHeaderViewController.topLayoutGuideViewController = contentViewController
```

#### Objective-C
```objc
flexibleHeaderViewController.useAdditionalSafeAreaInsetsForWebKitScrollViews = YES;
flexibleHeaderViewController.topLayoutGuideViewController = contentViewController;
```
<!--</div>-->

If you support any OS below iOS 11, you'll **also** need to adjust the frame of your WKWebView on
devices running these older operating systems so that the web view is aligned to the top layout
guide.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
if #available(iOS 11.0, *) {
  // No need to do anything - additionalSafeAreaInsets will inset our content.
  webView.autoresizingMask = [.width | .height]
} else {
  // Fixes the WKWebView contentSize.height bug pre-iOS 11.
  webView.translatesAutoresizingMaskIntoConstraints = false
  NSLayoutConstraint.activate([
    NSLayoutConstraint(item: webView,
                       attribute: .top,
                       relatedBy: .equal,
                       toItem: topLayoutGuide,
                       attribute: .bottom,
                       multiplier: 1,
                       constant: 0),
    NSLayoutConstraint(item: webView,
                       attribute: .bottom,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .bottom,
                       multiplier: 1,
                       constant: 0),
    NSLayoutConstraint(item: webView,
                       attribute: .left,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .left,
                       multiplier: 1,
                       constant: 0),
    NSLayoutConstraint(item: webView,
                       attribute: .right,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .right,
                       multiplier: 1,
                       constant: 0),
  ])
}
```

#### Objective-C
```objc
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    // No need to do anything - additionalSafeAreaInsets will inset our content.
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  } else {
#endif
  // Fixes the WKWebView contentSize.height bug pre-iOS 11.
  webView.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:
   @[[NSLayoutConstraint constraintWithItem:webView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.topLayoutGuide
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1.0
                                   constant:0],
     [NSLayoutConstraint constraintWithItem:webView
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1.0
                                   constant:0],
     [NSLayoutConstraint constraintWithItem:webView
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1.0
                                   constant:0],
     [NSLayoutConstraint constraintWithItem:webView
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1.0
                                   constant:0]
     ]];
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  }
#endif
```
<!--</div>-->
