@interface MDCBottomDrawerViewController ()

/** The transition controller. */
@property(nonatomic) MDCBottomDrawerTransitionController *transitionController;

@end

@implementation MDCBottomDrawerViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    _transitionController = [[MDCBottomDrawerTransitionController alloc] init];
  }
  return self;
}

- (id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  return _transitionController;
}

- (UIModalPresentationStyle)modalPresentationStyle {
  return UIModalPresentationCustom;
}

- (UIScrollView *)trackingScrollView {
  return _transitionController.trackingScrollView;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _transitionController.trackingScrollView = trackingScrollView;
}

#pragma mark UIAccessibilityAction

// Adds the Z gesture for dismissal.
- (BOOL)accessibilityPerformEscape {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

@end
