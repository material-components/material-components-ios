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

#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "MaterialTypography.h"
#import "private/MDCFeatureHighlightAnimationController.h"
#import "private/MDCFeatureHighlightView+Private.h"

static const CGFloat kMDCFeatureHighlightLineSpacing = 1.0f;
static const CGFloat kMDCFeatureHighlightPulseAnimationInterval = 1.5f;

@interface MDCFeatureHighlightViewController () <UIViewControllerTransitioningDelegate>
@property(nonatomic, strong) MDCFeatureHighlightView *view;
@end

@implementation MDCFeatureHighlightViewController {
  MDCFeatureHighlightAnimationController *_animationController;
  MDCFeatureHighlightCompletion _completion;
  MDCFeatureHighlightView *_featureHighlightView;
  NSTimer *_pulseTimer;
  UIView *_displayedView;
  UIView *_highlightedView;
}

@dynamic view;

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                    andShowView:(nonnull UIView *)displayedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _highlightedView = highlightedView;
    _displayedView = displayedView;
    _completion = completion;
    _animationController = [[MDCFeatureHighlightAnimationController alloc] init];
    _animationController.presenting = YES;

    _displayedView.accessibilityTraits = UIAccessibilityTraitButton;

    super.transitioningDelegate = self;
    super.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:
      (__unused id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCAlertController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
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

- (void)loadView {
  _featureHighlightView = [[MDCFeatureHighlightView alloc] initWithFrame:CGRectZero];
  _featureHighlightView.displayedView = _displayedView;
  _featureHighlightView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _featureHighlightView.mdc_adjustsFontForContentSizeCategory =
      _mdc_adjustsFontForContentSizeCategory;

  __weak MDCFeatureHighlightViewController *weakSelf = self;
  _featureHighlightView.interactionBlock = ^(BOOL accepted) {
    MDCFeatureHighlightViewController *strongSelf = weakSelf;
    [strongSelf dismiss:accepted];
  };

  UIGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acceptFeature)];
  [_displayedView addGestureRecognizer:tapGestureRecognizer];

  self.view = _featureHighlightView;
}

- (void)viewWillLayoutSubviews {
  _featureHighlightView.titleLabel.text = self.titleText;
  [self attributedStringForString:self.titleText lineSpacing:kMDCFeatureHighlightLineSpacing];
  _featureHighlightView.bodyLabel.attributedText =
      [self attributedStringForString:self.bodyText lineSpacing:kMDCFeatureHighlightLineSpacing];
}

- (void)dealloc {
  [_pulseTimer invalidate];
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

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [coordinator animateAlongsideTransition:^(__unused
                   id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
    CGPoint point = [self->_highlightedView.superview convertPoint:self->_highlightedView.center
                                                            toView:self->_featureHighlightView];

    self->_featureHighlightView.highlightPoint = point;
    [self->_featureHighlightView layoutIfNeeded];
    [self->_featureHighlightView updateOuterHighlight];
  }
                               completion:nil];
}

- (UIColor *)outerHighlightColor {
  return self.view.outerHighlightColor;
}

- (void)setOuterHighlightColor:(UIColor *)outerHighlightColor {
  self.view.outerHighlightColor = outerHighlightColor;
}

- (UIColor *)innerHighlightColor {
  return self.view.innerHighlightColor;
}

- (void)setInnerHighlightColor:(UIColor *)innerHighlightColor {
  self.view.innerHighlightColor = innerHighlightColor;
}

- (UIColor *)titleColor {
  return self.view.titleColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
  self.view.titleColor = titleColor;
}

- (UIColor *)bodyColor {
  return self.view.bodyColor;
}

- (void)setBodyColor:(UIColor *)bodyColor {
  self.view.bodyColor = bodyColor;
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

#pragma mark - Dynamic Type

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
    [self updateFontsForDynamicType];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateFontsForDynamicType];
}

- (void)updateFontsForDynamicType {
  [_featureHighlightView updateTitleFont];
  [_featureHighlightView updateBodyFont];
  [_featureHighlightView layoutIfNeeded];
}

#pragma mark - Accessibility

- (BOOL)accessibilityPerformEscape {
  [self rejectFeature];

  return YES;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(__unused UIViewController *)presenting
                             sourceController:(__unused UIViewController *)source {
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

#pragma mark - Private

- (NSAttributedString *)attributedStringForString:(NSString *)string
                                      lineSpacing:(CGFloat)lineSpacing {
  if (!string) {
    return nil;
  }
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineSpacing = lineSpacing;

  NSDictionary *attrs = @{NSParagraphStyleAttributeName : paragraphStyle};

  return [[NSAttributedString alloc] initWithString:string attributes:attrs];
}

@end
