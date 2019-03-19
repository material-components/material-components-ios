// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCFeatureHighlightViewController.h"

#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "MaterialFeatureHighlightStrings.h"
#import "MaterialFeatureHighlightStrings_table.h"
#import "MaterialTypography.h"
#import "private/MDCFeatureHighlightAnimationController.h"
#import "private/MDCFeatureHighlightView+Private.h"

// The Bundle for string resources.
static NSString *const kMaterialFeatureHighlightBundle = @"MaterialFeatureHighlight.bundle";

static const CGFloat kMDCFeatureHighlightLineSpacing = 1;
static const CGFloat kMDCFeatureHighlightPulseAnimationInterval = (CGFloat)1.5;

@interface MDCFeatureHighlightViewController () <UIViewControllerTransitioningDelegate>
@property(nonatomic, nullable, weak) MDCFeatureHighlightView *featureHighlightView;
@end

@implementation MDCFeatureHighlightViewController {
  MDCFeatureHighlightAnimationController *_animationController;
  MDCFeatureHighlightCompletion _completion;
  NSString *_viewAccessiblityHint;
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
    _outerHighlightColor =
        [[UIColor blueColor] colorWithAlphaComponent:kMDCFeatureHighlightOuterHighlightAlpha];
    _innerHighlightColor = [UIColor whiteColor];

    _displayedView.accessibilityTraits = UIAccessibilityTraitButton;

    _viewAccessiblityHint = [[self class] dismissAccessibilityHint];

    super.transitioningDelegate = self;
    super.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.featureHighlightView.displayedView = _displayedView;
  self.featureHighlightView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.featureHighlightView.mdc_adjustsFontForContentSizeCategory =
      _mdc_adjustsFontForContentSizeCategory;
  self.featureHighlightView.mdc_legacyFontScaling = _mdc_legacyFontScaling;

  __weak MDCFeatureHighlightViewController *weakSelf = self;
  self.featureHighlightView.interactionBlock = ^(BOOL accepted) {
    MDCFeatureHighlightViewController *strongSelf = weakSelf;
    [strongSelf dismiss:accepted];
  };

  UIGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acceptFeature)];
  [_displayedView addGestureRecognizer:tapGestureRecognizer];

  self.featureHighlightView.outerHighlightColor = _outerHighlightColor;
  self.featureHighlightView.innerHighlightColor = _innerHighlightColor;
  self.featureHighlightView.titleColor = _titleColor;
  self.featureHighlightView.bodyColor = _bodyColor;
  self.featureHighlightView.titleFont = _titleFont;
  self.featureHighlightView.bodyFont = _bodyFont;
  self.featureHighlightView.accessibilityHint = _viewAccessiblityHint;
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
  self.view = [[MDCFeatureHighlightView alloc] initWithFrame:CGRectZero];
  self.featureHighlightView = (MDCFeatureHighlightView *)self.view;
}

- (void)viewWillLayoutSubviews {
  self.featureHighlightView.titleLabel.attributedText =
      [self attributedStringForString:self.titleText lineSpacing:kMDCFeatureHighlightLineSpacing];
  self.featureHighlightView.bodyLabel.attributedText =
      [self attributedStringForString:self.bodyText lineSpacing:kMDCFeatureHighlightLineSpacing];
}

- (void)dealloc {
  [_pulseTimer invalidate];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  CGPoint point = [_highlightedView.superview convertPoint:_highlightedView.center
                                         toCoordinateSpace:self.featureHighlightView];
  self.featureHighlightView.highlightPoint = point;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  _pulseTimer = [NSTimer scheduledTimerWithTimeInterval:kMDCFeatureHighlightPulseAnimationInterval
                                                 target:self.featureHighlightView
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
  [coordinator
      animateAlongsideTransition:^(
          __unused id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [self resetHighlightPoint];
      }
      completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [self resetHighlightPoint];
      }];
}

- (void)resetHighlightPoint {
  CGPoint point = [_highlightedView.superview convertPoint:_highlightedView.center
                                                    toView:self.featureHighlightView];
  self.featureHighlightView.highlightPoint = point;
  [self.featureHighlightView layoutIfNeeded];
  [self.featureHighlightView updateOuterHighlight];
}

- (void)setOuterHighlightColor:(UIColor *)outerHighlightColor {
  _outerHighlightColor = outerHighlightColor;
  if (self.isViewLoaded) {
    self.featureHighlightView.outerHighlightColor = outerHighlightColor;
  }
}

- (void)setInnerHighlightColor:(UIColor *)innerHighlightColor {
  _innerHighlightColor = innerHighlightColor;
  if (self.isViewLoaded) {
    self.featureHighlightView.innerHighlightColor = innerHighlightColor;
  }
}

- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;
  if (self.isViewLoaded) {
    self.featureHighlightView.titleColor = titleColor;
  }
}

- (void)setBodyColor:(UIColor *)bodyColor {
  _bodyColor = bodyColor;
  if (self.isViewLoaded) {
    self.featureHighlightView.bodyColor = bodyColor;
  }
}

- (void)setTitleFont:(UIFont *)titleFont {
  _titleFont = titleFont;
  if (self.isViewLoaded) {
    self.featureHighlightView.titleFont = titleFont;
  }
}

- (void)setBodyFont:(UIFont *)bodyFont {
  _bodyFont = bodyFont;
  if (self.isViewLoaded) {
    self.featureHighlightView.bodyFont = bodyFont;
  }
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

- (void)mdc_setLegacyFontScaling:(BOOL)legacyScaling {
  _mdc_legacyFontScaling = legacyScaling;

  if (self.isViewLoaded) {
    self.featureHighlightView.mdc_legacyFontScaling = legacyScaling;
  }
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateFontsForDynamicType];
}

- (void)updateFontsForDynamicType {
  [self.featureHighlightView updateTitleFont];
  [self.featureHighlightView updateBodyFont];
  [self.featureHighlightView layoutIfNeeded];
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

#pragma mark - UIAccessibility

- (void)setAccessibilityHint:(NSString *)accessibilityHint {
  _viewAccessiblityHint = accessibilityHint;
  if (self.isViewLoaded) {
    self.featureHighlightView.accessibilityHint = accessibilityHint;
  }
}

- (NSString *)accessibilityHint {
  return _viewAccessiblityHint;
}

+ (NSString *)dismissAccessibilityHint {
  NSString *key =
      kMaterialFeatureHighlightStringTable[kStr_MaterialFeatureHighlightDismissAccessibilityHint];
  NSString *localizedString = NSLocalizedStringFromTableInBundle(
      key, kMaterialFeatureHighlightStringsTableName, [self bundle], @"Double-tap to dismiss.");
  return localizedString;
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

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialFeatureHighlightBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCFeatureHighlightView class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

@end
