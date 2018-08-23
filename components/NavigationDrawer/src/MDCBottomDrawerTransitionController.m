static const NSTimeInterval kMDCBottomDrawerOpenAnimationDuration = 0.34;
static const NSTimeInterval kMDCBottomDrawerCloseAnimationDuration = 0.3;
static const CGFloat kMDCBottomDrawerOpenAnimationSpringDampingRatio = 0.85f;

@implementation MDCBottomDrawerTransitionController

#pragma mark UIViewControllerTransitioningDelegate

- (nullable id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
    (UIViewController *)dismissed {
  return self;
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  BOOL voiceOverIsRunning = UIAccessibilityIsVoiceOverRunning();
  UIUserInterfaceSizeClass verticalSizeClass = source.traitCollection.verticalSizeClass;
  BOOL compactHeight = verticalSizeClass == UIUserInterfaceSizeClassCompact;
  BOOL showFullscreen = compactHeight || voiceOverIsRunning;

  if (showFullscreen) {
    // TODO(yar): Display the presented view controller and header within a flexible header
    // container.
    return nil;
  } else {
    MDCBottomDrawerPresentationController *presentationController =
        [[MDCBottomDrawerPresentationController alloc] initWithPresentedViewController:presented
                                                              presentingViewController:presenting];
    presentationController.trackingScrollView = self.trackingScrollView;
    return presentationController;
  }
}

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:
    (nullable id<UIViewControllerContextTransitioning>)transitionContext {
  BOOL presenting = [self isPresentingFromContext:transitionContext];
  if (presenting) {
    return kMDCBottomDrawerOpenAnimationDuration;
  }
  return kMDCBottomDrawerCloseAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  // If a view in the transitionContext is nil, it likely hasn't been loaded by its view controller
  // yet.  Ask for it directly to initiate a loadView on the ViewController.
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  if (fromView == nil) {
    fromView = fromViewController.view;
  }

  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  if (toView == nil) {
    toView = toViewController.view;
  }

  BOOL presenting = [self isPresentingFromContext:transitionContext];
  UIView *animatingView = presenting ? toView : fromView;
  UIView *containerView = transitionContext.containerView;

  if (presenting) {
    [containerView addSubview:animatingView];
    CGRect initialFrame = containerView.bounds;
    initialFrame.origin.y = containerView.bounds.size.height;
    animatingView.frame = initialFrame;
    [UIView animateWithDuration:kMDCBottomDrawerOpenAnimationDuration
        delay:0
        usingSpringWithDamping:kMDCBottomDrawerOpenAnimationSpringDampingRatio
        initialSpringVelocity:0.f
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CGRect finalFrame = containerView.bounds;
          animatingView.frame = finalFrame;
        }
        completion:^(BOOL finished) {
          [transitionContext completeTransition:YES];
        }];
  } else {
    [UIView animateWithDuration:kMDCBottomDrawerCloseAnimationDuration
        animations:^{
          CGRect finalFrame = containerView.bounds;
          finalFrame.origin.y = containerView.bounds.size.height;
          animatingView.frame = finalFrame;
        }
        completion:^(BOOL finished) {
          [fromViewController.view removeFromSuperview];
          [transitionContext completeTransition:YES];
          [toViewController setNeedsStatusBarAppearanceUpdate];
        }];
  }
}

- (BOOL)isPresentingFromContext:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIViewController *toPresentingViewController = toViewController.presentingViewController;
  return (toPresentingViewController == fromViewController) ? YES : NO;
}

@end
