If you would like to announce when the Feature Highlight is shown we recommend doing it inside the completion 
block.

#### Swift

```swift
let vc = MDCFeatureHighlightViewController(highlightedView: button, completion:nil)
present(vc, animated: true, completion: {
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, 
    "Try out this cool feature") })
```

#### Objective-C

```objc
MDCFeatureHighlightViewController *vc =
    [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button 
                                                            completion:nil];
[self presentViewController:vc, animated:YES completion:^{
  UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, 
  @"Try out this new feature.");
}];
```

