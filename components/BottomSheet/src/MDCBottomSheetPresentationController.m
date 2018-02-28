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

#import "MDCBottomSheetController.h"

#import "MaterialMath.h"
#import "private/MDCSheetContainerView.h"

static UIScrollView *MDCBottomSheetGetPrimaryScrollView(UIViewController *viewController) {
  UIScrollView *scrollView = nil;

  // Ensure the view is loaded - occasionally during non-animated transitions the view may not be
  // loaded yet (but the scrollview is still needed for scroll-tracking to work properly).
  if (![viewController isViewLoaded]) {
    (void)viewController.view;
  }

  if ([viewController isKindOfClass:[MDCBottomSheetController class]]) {
    viewController = ((MDCBottomSheetController *)viewController).contentViewController;
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
}

@synthesize delegate;

- (UIView *)presentedView {
  return _sheetView;
}

- (CGRect)frameOfPresentedViewInContainerView {
  CGSize containerSize = self.containerView.frame.size;
  CGSize preferredSize = self.presentedViewController.preferredContentSize;

  if (preferredSize.width > 0 && preferredSize.width < containerSize.width) {
    // We only customize the width and not the height here. MDCSheetContainerView lays out the
    // presentedView taking the preferred height in to account.
    CGFloat width = preferredSize.width;
    CGFloat leftPad = (containerSize.width - width) / 2;
    return CGRectMake(leftPad, 0, width, containerSize.height);
  } else {
    return [super frameOfPresentedViewInContainerView];
  }
}

- (void)presentationTransitionWillBegin {
  id<MDCBottomSheetPresentationControllerDelegate> strongDelegate = self.delegate;
  if ([strongDelegate respondsToSelector:@selector(prepareForBottomSheetPresentation:)]) {
    [strongDelegate prepareForBottomSheetPresentation:self];
  }

  UIView *containerView = [self containerView];

  _dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
  _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4f];
  _dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
  _dimmingView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  UIScrollView *scrollView = self.trackingScrollView;
  if (scrollView == nil) {
    scrollView = MDCBottomSheetGetPrimaryScrollView(self.presentedViewController);
  }
  CGRect sheetFrame = [self frameOfPresentedViewInContainerView];
  _sheetView = [[MDCSheetContainerView alloc] initWithFrame:sheetFrame
                                                contentView:self.presentedViewController.view
                                                 scrollView:scrollView];
  _sheetView.delegate = self;
  _sheetView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

  [containerView addSubview:_dimmingView];
  [containerView addSubview:_sheetView];

  [self updatePreferredSheetHeight];

  // Add tap handler to dismiss the sheet.
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:
      @selector(dismissPresentedControllerIfNecessary:)];
  tapGesture.cancelsTouchesInView = NO;
  containerView.userInteractionEnabled = YES;
  [containerView addGestureRecognizer:tapGesture];

  id <UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];

  // Fade in the dimming view during the transition.
  _dimmingView.alpha = 0.0;
  [transitionCoordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        self->_dimmingView.alpha = 1.0;
      }                                  completion:nil];
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
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        self->_dimmingView.alpha = 0.0;
      }                                  completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [_dimmingView removeFromSuperview];
  }
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self->_sheetView.frame = [self frameOfPresentedViewInContainerView];
        [self->_sheetView layoutIfNeeded];
        [self updatePreferredSheetHeight];
      }                        completion:nil];
}

- (void)updatePreferredSheetHeight {
  CGFloat preferredContentHeight = self.presentedViewController.preferredContentSize.height;

  // If |preferredSheetHeight| has not been specified, use half of the current height.
  if (MDCCGFloatEqual(preferredContentHeight, 0)) {
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

  id<MDCBottomSheetPresentationControllerDelegate> strongDelegate = self.delegate;
  if ([strongDelegate respondsToSelector:
       @selector(bottomSheetPresentationControllerDidDismissBottomSheet:)]) {
    [strongDelegate bottomSheetPresentationControllerDidDismissBottomSheet:self];
  }
}

#pragma mark - MDCSheetContainerViewDelegate

- (void)sheetContainerViewDidHide:(nonnull __unused MDCSheetContainerView *)containerView {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

  id<MDCBottomSheetPresentationControllerDelegate> strongDelegate = self.delegate;
  if ([strongDelegate respondsToSelector:
       @selector(bottomSheetPresentationControllerDidDismissBottomSheet:)]) {
    [strongDelegate bottomSheetPresentationControllerDidDismissBottomSheet:self];
  }
}

@end
