/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFeatureHighlightViewController.h"

#import "private/MDCFeatureHighlightAnimationController.h"
#import "private/MDCFeatureHighlightView+Private.h"

static const CGFloat kMDCFeatureHighlightPulseAnimationInterval = 1.5f;

@interface MDCFeatureHighlightViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation MDCFeatureHighlightViewController {
  MDCFeatureHighlightAnimationController *_animationController;
  MDCFeatureHighlightCompletion _completion;
  MDCFeatureHighlightView *_featureHighlightView;
  NSTimer *_pulseTimer;
  UIView *_displayedView;
  UIView *_highlightedView;
}

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                    andShowView:(nonnull UIView *)displayedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _highlightedView = highlightedView;
    _displayedView = displayedView;
    _completion = completion;
    _animationController = [[MDCFeatureHighlightAnimationController alloc] init];
    _animationController.presenting = YES;

    [_highlightedView addObserver:self
                       forKeyPath:@"frame"
                          options:NSKeyValueObservingOptionNew
                          context:nil];

    super.transitioningDelegate = self;
    super.modalPresentationStyle = UIModalPresentationCustom;
    
    [self commonMDCFeatureHighlightViewControllerInit];
  }
  return self;
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCAlertController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCAlertController.modalPresentationStyle cannot be changed.");
  return;
}

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  UIView *snapshotView = [highlightedView snapshotViewAfterScreenUpdates:YES];
  // We have to wrap the snapshoted view because _UIReplicantViews can't be accessibility elements.
  UIView *displayedView = [[UIView alloc] initWithFrame:snapshotView.bounds];
  [displayedView addSubview:snapshotView];

  // Copy the accessibility values from the view being highlighted.
  displayedView.isAccessibilityElement = YES;
  displayedView.accessibilityTraits = UIAccessibilityTraitButton;
  displayedView.accessibilityLabel = highlightedView.accessibilityLabel;
  displayedView.accessibilityValue = highlightedView.accessibilityValue;
  displayedView.accessibilityHint = highlightedView.accessibilityHint;

  return [self initWithHighlightedView:highlightedView
                           andShowView:displayedView
                            completion:completion];
}

- (void)commonMDCFeatureHighlightViewControllerInit {
  _displayedView.accessibilityTraits = UIAccessibilityTraitButton;
  
  _featureHighlightView = [[MDCFeatureHighlightView alloc] initWithFrame:CGRectZero];
  _featureHighlightView.displayedView = _displayedView;
  _featureHighlightView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  __weak __typeof__(self) weakSelf = self;
  _featureHighlightView.interactionBlock = ^(BOOL accepted) {
    __typeof__(self) strongSelf = weakSelf;
    [strongSelf dismiss:accepted];
  };
  self.view = _featureHighlightView;
}

- (void)viewWillLayoutSubviews {
  _featureHighlightView.titleLabel.text = self.titleText;
  _featureHighlightView.bodyLabel.text = self.bodyText;
}

- (void)dealloc {
  [_pulseTimer invalidate];
  [_highlightedView removeObserver:self forKeyPath:@"frame"];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  CGPoint point = [_highlightedView.superview convertPoint:_highlightedView.center
                                         toCoordinateSpace:_featureHighlightView];
  _featureHighlightView.highlightPoint = point;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  _pulseTimer = [NSTimer scheduledTimerWithTimeInterval:kMDCFeatureHighlightPulseAnimationInterval
                                                 target:_featureHighlightView
                                               selector:@selector(animatePulse)
                                               userInfo:NULL
                                                repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  [_pulseTimer invalidate];
}

- (UIColor *)outerHighlightColor {
  return _featureHighlightView.outerHighlightColor;
}

- (void)setOuterHighlightColor:(UIColor *)outerHighlightColor {
  _featureHighlightView.outerHighlightColor = outerHighlightColor;
}

- (UIColor *)innerHighlightColor {
  return _featureHighlightView.innerHighlightColor;
}

- (void)setInnerHighlightColor:(UIColor *)innerHighlightColor {
  _featureHighlightView.innerHighlightColor = innerHighlightColor;
}

- (void)acceptFeature {
  [self dismiss:YES];
}

- (void)rejectFeature {
  [self dismiss:NO];
}

- (void)dismiss:(BOOL)accepted {
  _animationController.presenting = NO;
  if (accepted) {
    _animationController.dismissStyle = MDCFeatureHighlightDismissAccepted;
  } else {
    _animationController.dismissStyle = MDCFeatureHighlightDismissRejected;
  }
  [self dismissViewControllerAnimated:YES
                           completion:^() {
                             if (self->_completion) {
                               self->_completion(accepted);
                             }
                           }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context {
  if (object == _highlightedView && [keyPath isEqualToString:@"frame"]) {
    CGPoint point = [_highlightedView.superview convertPoint:_highlightedView.center
                                                      toView:_featureHighlightView];
    _featureHighlightView.highlightPoint = point;
    [_featureHighlightView layoutIfNeeded];
  }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  if (presented == self) {
    return _animationController;
  }
  return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
        (UIViewController *)dismissed {
  if (dismissed == self) {
    return _animationController;
  }
  return nil;
}

@end
