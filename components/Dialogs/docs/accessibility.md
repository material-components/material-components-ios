### MDCPresentationController Accessibility

As MDCPresentationController is responsible for the presentation of your
custom view controllers, it does not implement any accessibility
functionality itself.

#### `-accessibilityPerformEscape` Behavior

If you intend your presented view controller to dismiss when a user
in VoiceOver mode has performed the escape gesture the view controller
should implement the accessibilityPerformEscape method.

```
- (BOOL)accessibilityPerformEscape {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
  return YES;
}
```
