/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCBottomSheetTransitionController.h"

#import "MDCBottomSheetPresentationController.h"
#import "private/MDCSheetContainerView.h"

static const NSTimeInterval kPresentationDuration = 0.225;
static const NSTimeInterval kDismissalDuration = 0.2;

@interface UIViewController ()
// Weak dependency on GOONav's equivalent API.
- (UIScrollView *)navigationPrimaryScrollView;
@end

static UIScrollView *MDCBottomSheetGetPrimaryScrollView(UIViewController *viewController) {
  UIScrollView *scrollView = nil;

  // Ensure the view is loaded - occasionally during non-animated transitions the view may not be
  // loaded yet (but the scrollview is still needed for scroll-tracking to work properly).
  if (![viewController isViewLoaded]) {
    (void)viewController.view;
  }

  // TODO(b/25442167): This is a soft dependency on GOONav's logic for
  //                   GOONavigationGetPrimaryScrollView.
  if ([viewController respondsToSelector:@selector(navigationPrimaryScrollView)]) {
    scrollView = [(id)viewController navigationPrimaryScrollView];
  } else if ([viewController.view isKindOfClass:[UIScrollView class]]) {
    scrollView = (UIScrollView *)viewController.view;
  } else if ([viewController.view isKindOfClass:[UIWebView class]]) {
    scrollView = ((UIWebView *)viewController.view).scrollView;
  } else if ([viewController isKindOfClass:[UICollectionViewController class]]) {
    scrollView = ((UICollectionViewController *)viewController).collectionView;
  }
  return scrollView;
}

@interface MDCBottomSheetTransitionController () <MDCSheetContainerViewDelegate>
@property(nonatomic, readonly) BOOL isPresenting;
@property(nonatomic, strong) MDCSheetContainerView *sheetView;
@property(nonatomic, strong) UIView *dimmingView;
@property(nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property(nonatomic, weak) UIViewController *presentedViewController;
@property(nonatomic) UIViewController *sourceViewController;
@property(nonatomic) UIViewController *destinationViewController;
@property(nonatomic) UIView *sourceView;
@property(nonatomic) UIView *destinationView;
@property(nonatomic, readonly) UIView *containerView;
@property(nonatomic) CGAffineTransform savedTransform;
@end

@implementation MDCBottomSheetTransitionController

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return self.isPresenting ? kPresentationDuration : kDismissalDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  [self setupForTransitionUsingContext:transitionContext];
  [self prepareTransition];
  [self updatePreferredSheetHeight];

  void (^completionBlock)(BOOL) = ^(BOOL animationFinished) {
    if (!self.isPresenting) {
      [self.sheetView removeFromSuperview];
    }

    BOOL wasCancelled = [transitionContext transitionWasCancelled];
    [transitionContext completeTransition:!wasCancelled];
  };

  if ([transitionContext isAnimated]) {
    [self performTransitionWithCompletion:completionBlock];
  } else {
    [UIView performWithoutAnimation:^{
      [self performTransitionWithCompletion:completionBlock];
    }];
  }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  return [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                         presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
    (UIViewController *)dismissed {
  return self;
}

#pragma mark - Private

- (void)setupForTransitionUsingContext:(id<UIViewControllerContextTransitioning>)context {
  self.transitionContext = context;

  self.sourceViewController =
      [context viewControllerForKey:UITransitionContextFromViewControllerKey];
  self.destinationViewController =
      [context viewControllerForKey:UITransitionContextToViewControllerKey];

  self.sourceView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
  if (self.sourceView == nil) {
    self.sourceView = self.sourceViewController.view;
  }
  self.destinationView = [self.transitionContext viewForKey:UITransitionContextToViewKey];
  if (self.destinationView == nil) {
    self.destinationView = self.destinationViewController.view;
  }
  UIViewController *toPresentingViewController = self.destinationViewController.presentingViewController;
  if (toPresentingViewController == self.sourceViewController) {
    self.presentedViewController = self.destinationViewController;
  } else {
    self.presentedViewController = self.sourceViewController;
  }
}

- (void)prepareTransition {
  if (self.isPresenting) {
    CGRect frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    UIScrollView *scrollView = MDCBottomSheetGetPrimaryScrollView(self.destinationViewController);
    self.sheetView = [[MDCSheetContainerView alloc] initWithFrame:frame
                                                      contentView:self.destinationView
                                                       scrollView:scrollView];
    self.sheetView.delegate = self;
    self.sheetView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:self.sheetView];

    self.presentedViewController = self.destinationViewController;
    self.savedTransform = self.sheetView.transform;
    self.sheetView.transform = [self offScreenTransformForPresentedView];
  }
}

- (CGAffineTransform)offScreenTransformForPresentedView {
  CGFloat yOffset = CGRectGetHeight(self.presentedViewController.view.bounds);
  CGAffineTransform translation = CGAffineTransformMakeTranslation(0, yOffset);

  return CGAffineTransformConcat(translation, self.sheetView.transform);
}

- (void)performTransitionWithCompletion:(void (^)(BOOL))completionBlock {
  // UIKit turns this off. We need to enable taps on the container when the transition starts.
  self.containerView.userInteractionEnabled = YES;

  if (self.isPresenting) {
    [self performPresentationAnimationWithCompletion:completionBlock];
  } else {
    [self performDismissalAnimationWithCompletion:completionBlock];
  }
}

- (void)performPresentationAnimationWithCompletion:(void (^)(BOOL))completionBlock {
  UIView *presentedView = self.sheetView;

  [UIView animateWithDuration:kPresentationDuration
                   animations:^{
                     presentedView.transform = self.savedTransform;
                   }
                   completion:completionBlock];
}

- (void)performDismissalAnimationWithCompletion:(void (^)(BOOL))completionBlock {
  UIView *presentedView = self.sheetView;

  [UIView animateWithDuration:kDismissalDuration
                   animations:^{
                     presentedView.transform = [self offScreenTransformForPresentedView];
                   }
                   completion:completionBlock];
}

- (void)updatePreferredSheetHeight {
  CGFloat preferredContentHeight = self.presentedViewController.preferredContentSize.height;

  // If |preferredSheetHeight| has not been specified, use half of the current height.
  //  if (GOOFloatIsApproximatelyZero(preferredContentHeight) || !self.usePreferredHeight) {
  preferredContentHeight = self.sheetView.frame.size.height / 2;
  if (preferredContentHeight < (CGFloat)FLT_EPSILON) {
    preferredContentHeight = 0;
  }
  //  }
  self.sheetView.preferredSheetHeight = preferredContentHeight;
}

#pragma mark - Accessors

- (BOOL)isPresenting {
  return self.presentedViewController == self.destinationViewController;
}

- (UIView *)presentingView {
  return self.isPresenting ? self.sourceView : self.destinationView;
}

- (UIView *)containerView {
  return [self.transitionContext containerView];
}

#pragma mark - MDCSheetContainerViewDelegate

- (void)sheetContainerViewDidHide:(nonnull MDCSheetContainerView *)containerView {
  [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
