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

#import "MDCBottomSheetPresentationController.h"

#import "private/MDCSheetContainerView.h"

static inline BOOL MDCFloatIsApproximatelyZero(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return (fabs(value) < DBL_EPSILON);
#else
  return (fabsf(value) < FLT_EPSILON);
#endif
}

static inline CGFloat MDCRound(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return round(value);
#else
  return roundf(value);
#endif
}

static UIScrollView *MDCBottomSheetGetPrimaryScrollView(UIViewController *viewController) {
  UIScrollView *scrollView = nil;

  // Ensure the view is loaded - occasionally during non-animated transitions the view may not be
  // loaded yet (but the scrollview is still needed for scroll-tracking to work properly).
  if (![viewController isViewLoaded]) {
    (void)viewController.view;
  }

  if ([viewController.view isKindOfClass:[UIScrollView class]]) {
    scrollView = (UIScrollView *)viewController.view;
  } else if ([viewController.view isKindOfClass:[UIWebView class]]) {
    scrollView = ((UIWebView *)viewController.view).scrollView;
  } else if ([viewController isKindOfClass:[UICollectionViewController class]]) {
    scrollView = ((UICollectionViewController *)viewController).collectionView;
  }
  return scrollView;
}

@interface MDCBottomSheetPresentationController () <MDCSheetContainerViewDelegate>
@end

@implementation MDCBottomSheetPresentationController {
  UIView *_dimmingView;
  MDCSheetContainerView *_sheetView;
  CGAffineTransform _savedTransform;
}

@synthesize delegate;

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _dimmingView = [[UIView alloc] init];
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

- (UIView *)presentedView {
  return _sheetView;
}

- (void)presentationTransitionWillBegin {
  UIView *containerView = [self containerView];

  CGRect frame = self.containerView.frame;
  UIScrollView *scrollView = MDCBottomSheetGetPrimaryScrollView(self.presentedViewController);
  _sheetView = [[MDCSheetContainerView alloc] initWithFrame:frame
                                                contentView:self.presentedViewController.view
                                                 scrollView:scrollView];
  _sheetView.delegate = self;
  _sheetView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _savedTransform = _sheetView.transform;
  _sheetView.transform = [self offScreenTransformForPresentedView];

  [containerView addSubview:_dimmingView];
  [containerView addSubview:_sheetView];

  NSDictionary *views = NSDictionaryOfVariableBindings(_dimmingView);

  [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dimmingView]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];
  [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dimmingView]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];

  [self updatePreferredSheetHeight];

  containerView.userInteractionEnabled = YES;
  // Add tap handler to dismiss the sheet.
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(dismissPresentedControllerIfNecessary:)];
  tapGesture.cancelsTouchesInView = NO;
  [containerView addGestureRecognizer:tapGesture];

  id <UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];

  // Fade in the dimming view during the transition.
  [_dimmingView setAlpha:0.0];
  [transitionCoordinator animateAlongsideTransition:
   ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     _sheetView.transform = _savedTransform;
     [_dimmingView setAlpha:1.0];
   } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  if (!completed) {
    [_dimmingView removeFromSuperview];
  }
}

- (void)dismissalTransitionWillBegin {
  id <UIViewControllerTransitionCoordinator> transitionCoordinator =
    [[self presentingViewController] transitionCoordinator];

  [transitionCoordinator animateAlongsideTransition:
   ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     _sheetView.transform = [self offScreenTransformForPresentedView];
     [_dimmingView setAlpha:0.0];
   } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [_dimmingView removeFromSuperview];
  }
}

- (void)updatePreferredSheetHeight {
  CGFloat preferredContentHeight = self.presentedViewController.preferredContentSize.height;

  // If |preferredSheetHeight| has not been specified, use half of the current height.
  if (MDCFloatIsApproximatelyZero(preferredContentHeight)) {
    preferredContentHeight = MDCRound(_sheetView.frame.size.height / 2);
  }
  _sheetView.preferredSheetHeight = preferredContentHeight;
}

- (void)dismissPresentedControllerIfNecessary:(UITapGestureRecognizer *)tapRecognizer {
  // Only dismiss if the tap is outside of the presented view.
  UIView *contentView = self.presentedViewController.view;
  CGPoint pointInContentView = [tapRecognizer locationInView:contentView];
  if ([contentView pointInside:pointInContentView withEvent:nil]) {
    return;
  }
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
  [self.delegate bottomSheetPresentationControllerDidDismiss:self];
}

#pragma mark - MDCSheetContainerViewDelegate

- (void)sheetContainerViewDidHide:(nonnull MDCSheetContainerView *)containerView {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
  [self.delegate bottomSheetPresentationControllerDidDismiss:self];
}

#pragma mark - Private

- (CGAffineTransform)offScreenTransformForPresentedView {
  CGFloat yOffset = CGRectGetHeight(self.presentedViewController.view.bounds);
  CGAffineTransform translation = CGAffineTransformMakeTranslation(0, yOffset);

  return CGAffineTransformConcat(translation, _sheetView.transform);
}

@end
