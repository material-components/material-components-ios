static UIColor *MDCBottomDrawerOverlayBackgroundColor(void) {
  return [UIColor colorWithWhite:0 alpha:0.4f];
}

@interface MDCBottomDrawerPresentationController () <UIGestureRecognizerDelegate>

/**
 * A semi-transparent view that darkens the visible main view when the drawer is displayed.
 */
@property(nonatomic) UIView *dimmingView;

/**
 * The bottom drawer container view controller.
 */
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;

@end

@implementation MDCBottomDrawerPresentationController

- (UIView *)presentedView {
  return self.bottomDrawerContainerViewController.view;
}

- (void)presentationTransitionWillBegin {
  UIView *containerView = [self containerView];

  MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController =
      [[MDCBottomDrawerContainerViewController alloc]
          initWithOriginalPresentingViewController:self.presentingViewController
                                trackingScrollView:self.trackingScrollView];
  if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
    MDCBottomDrawerViewController *bottomDrawerViewController =
        (MDCBottomDrawerViewController *)self.presentedViewController;
    bottomDrawerContainerViewController.mainContentViewController =
        bottomDrawerViewController.mainContentViewController;
    bottomDrawerContainerViewController.headerViewController =
        bottomDrawerViewController.headerViewController;
  } else {
    bottomDrawerContainerViewController.mainContentViewController = self.presentedViewController;
  }
  bottomDrawerContainerViewController.animatingPresentation = YES;
  self.bottomDrawerContainerViewController = bottomDrawerContainerViewController;

  self.dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
  self.dimmingView.backgroundColor = MDCBottomDrawerOverlayBackgroundColor();
  self.dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
  self.dimmingView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.dimmingView.accessibilityIdentifier = @"Close drawer";
  self.dimmingView.accessibilityTraits |= UIAccessibilityTraitButton;

  [containerView addSubview:self.dimmingView];
  [containerView addSubview:self.bottomDrawerContainerViewController.view];

  // Set up the tap recognizer to dimiss the drawer by.
  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDrawer)];
  [containerView addGestureRecognizer:tapGestureRecognizer];
  tapGestureRecognizer.delegate = self;

  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];

  // Fade in the dimming view during the transition.
  self.dimmingView.alpha = 0.0;
  [transitionCoordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1.0;
      }
                      completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  self.bottomDrawerContainerViewController.animatingPresentation = NO;
  [self.bottomDrawerContainerViewController.view setNeedsLayout];
  if (!completed) {
    [self.dimmingView removeFromSuperview];
  }
}

- (void)dismissalTransitionWillBegin {
  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];
  [transitionCoordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.0;
      }
                      completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.dimmingView removeFromSuperview];
  }
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];
  [self.bottomDrawerContainerViewController.view layoutIfNeeded];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  // We close the drawer on rotation or window splitting.
  [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Private

- (void)hideDrawer {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  return [self.bottomDrawerContainerViewController gestureRecognizer:gestureRecognizer
                                                  shouldReceiveTouch:touch];
}

@end
