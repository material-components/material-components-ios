### Enabling Swipe to Dismiss

When using MDCFlexibileHeaderController within a UINavigationController, setting the
UINavigationController's navigationBarHidden property to `YES` results in the loss of the
swipe-to-go-back feature associated with the controller.

To re-enable this feature whilst hiding the navigation controller's navigationBar we recommend
setting a pointer to the current interactivePopGestureRecognizer's delegate in the `viewWillAppear:`
method before setting the navigationBarHidden property to `YES`, setting the
interactivePopGestureRecognizer's delegate to `nil` while the MDCFlexibileHeaderController's parent
controller is actively on-screen in `viewDidAppear:`, then re-setting the
interactivePopGestureRecognizer's delegate to the held pointer in the `viewWillDisappear:` method.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Create pointer to hold active interactivePopGestureRecognizer delegate
var existingInteractivePopGestureRecognizerDelegate: UIGestureRecognizerDelegate?

override func viewWillAppear(animated: Bool) {
  super.viewWillAppear(animated)

  // Hold reference to current interactivePopGestureRecognizer delegate
  if let delegate = navigationController?.interactivePopGestureRecognizer?.delegate {
      existingInteractivePopGestureRecognizerDelegate = delegate
  }
  navigationController?.setNavigationBarHidden(true, animated: animated)
}

override func viewDidAppear(animated: Bool) {
  super.viewDidAppear(animated)

  // Set interactivePopGestureRecognizer delegate to nil
  navigationController?.interactivePopGestureRecognizer?.delegate = nil
}

override func viewWillDisappear(animated: Bool) {
  super.viewWillDisappear(animated)

  // Return interactivePopGestureRecognizer delegate to previously held object
  if let delegate = existingInteractivePopGestureRecognizerDelegate {
      navigationController?.interactivePopGestureRecognizer?.delegate = delegate
  }
}
```

#### Objective-C
```objc
@interface MyViewController ()

// Create pointer to hold active interactivePopGestureRecognizer delegate
@property(nonatomic, strong) id <UIGestureRecognizerDelegate> existingInteractivePopGestureRecognizerDelegate;

@end

@implementation

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // Hold reference to current interactivePopGestureRecognizer delegate
  if (self.navigationController.interactivePopGestureRecognizer.delegate) {
      self.existingInteractivePopGestureRecognizerDelegate =
          self.navigationController.interactivePopGestureRecognizer.delegate;
  }
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  // Set interactivePopGestureRecognizer delegate to nil
  self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  // Return interactivePopGestureRecognizer delegate to previously held object
  if (self.existingInteractivePopGestureRecognizerDelegate) {
      self.navigationController.interactivePopGestureRecognizer.delegate =
          self.existingInteractivePopGestureRecognizerDelegate;
  }
}

@end

```

<!--</div>-->
