// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomSheetController.h"

#import "MDCBottomSheetControllerDelegate.h"
#import "MDCBottomSheetPresentationController.h"
#import "MDCBottomSheetPresentationControllerDelegate.h"
#import "MDCBottomSheetTransitionController.h"
#import "UIViewController+MaterialBottomSheet.h"
#import "MaterialMath.h"

@interface MDCBottomSheetController () <MDCBottomSheetPresentationControllerDelegate>
@property(nonatomic, readonly, strong) MDCShapedView *view;
@end

@implementation MDCBottomSheetController {
  MDCBottomSheetTransitionController *_transitionController;
  NSMutableDictionary<NSNumber *, id<MDCShapeGenerating>> *_shapeGenerators;
}

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;
@dynamic view;

- (void)loadView {
  self.view = [[MDCShapedView alloc] initWithFrame:CGRectZero];
  self.view.elevation = self.elevation;
}

- (nonnull instancetype)initWithContentViewController:
    (nonnull UIViewController *)contentViewController {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _contentViewController = contentViewController;
    _transitionController = [[MDCBottomSheetTransitionController alloc] init];
    _transitionController.dismissOnBackgroundTap = YES;
    _transitionController.dismissOnDraggingDownSheet = YES;
    super.transitioningDelegate = _transitionController;
    super.modalPresentationStyle = UIModalPresentationCustom;
    _shapeGenerators = [NSMutableDictionary dictionary];
    if (UIAccessibilityIsVoiceOverRunning()) {
      _state = MDCSheetStateExtended;
    } else {
      _state = MDCSheetStatePreferred;
    }
    _elevation = MDCShadowElevationModalBottomSheet;
    _mdc_overrideBaseElevation = -1;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.preservesSuperviewLayoutMargins = YES;
  if (self.contentViewController) {
    self.contentViewController.view.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.contentViewController];
    [self.view addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.mdc_bottomSheetPresentationController.delegate = self;
#pragma clang diagnostic pop

  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap =
      _transitionController.dismissOnBackgroundTap;
  self.mdc_bottomSheetPresentationController.dismissOnDraggingDownSheet =
      _transitionController.dismissOnDraggingDownSheet;

  self.contentViewController.view.frame = self.view.bounds;
  [self.contentViewController.view layoutIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  if (self.shouldFlashScrollIndicatorsOnAppearance) {
    [self.trackingScrollView flashScrollIndicators];
  }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.contentViewController.supportedInterfaceOrientations;
}

- (BOOL)accessibilityPerformEscape {
  if (!self.dismissOnBackgroundTap) {
    return NO;
  }
  __weak MDCBottomSheetController *weakSelf = self;
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             __strong MDCBottomSheetController *strongSelf = weakSelf;
                             if ([strongSelf.delegate
                                     respondsToSelector:@selector
                                     (bottomSheetControllerDidDismissBottomSheet:)]) {
                               [strongSelf.delegate
                                   bottomSheetControllerDidDismissBottomSheet:strongSelf];
                             }
                           }];
  return YES;
}

- (CGSize)preferredContentSize {
  return self.contentViewController.preferredContentSize;
}

- (void)setPreferredContentSize:(CGSize)preferredContentSize {
  self.contentViewController.preferredContentSize = preferredContentSize;
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];
  // Informing the presentation controller of the change in preferred content size needs to be done
  // directly since the MDCBottomSheetController's preferredContentSize property is backed by
  // contentViewController's preferredContentSize. Therefore |[super setPreferredContentSize:]| is
  // never called, and UIKit never calls |preferredContentSizeDidChangeForChildContentContainer:|
  // on the presentation controller.
  [self.presentationController preferredContentSizeDidChangeForChildContentContainer:self];
}

- (UIScrollView *)trackingScrollView {
  return _transitionController.trackingScrollView;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _transitionController.trackingScrollView = trackingScrollView;
}

- (BOOL)dismissOnBackgroundTap {
  return _transitionController.dismissOnBackgroundTap;
}

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _transitionController.dismissOnBackgroundTap = dismissOnBackgroundTap;
  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap = dismissOnBackgroundTap;
}

- (BOOL)dismissOnDraggingDownSheet {
  return _transitionController.dismissOnDraggingDownSheet;
}

- (void)setDismissOnDraggingDownSheet:(BOOL)dismissOnDraggingDownSheet {
  _transitionController.dismissOnDraggingDownSheet = dismissOnDraggingDownSheet;
  self.mdc_bottomSheetPresentationController.dismissOnDraggingDownSheet =
      dismissOnDraggingDownSheet;
}

- (void)bottomSheetWillChangeState:(MDCBottomSheetPresentationController *)bottomSheet
                        sheetState:(MDCSheetState)sheetState {
  _state = sheetState;
  [self updateShapeGenerator];
  if ([self.delegate respondsToSelector:@selector(bottomSheetControllerStateChanged:state:)]) {
    [self.delegate bottomSheetControllerStateChanged:self state:sheetState];
  }
}

- (void)bottomSheetDidChangeYOffset:(nonnull MDCBottomSheetPresentationController *)bottomSheet
                            yOffset:(CGFloat)yOffset {
  if ([self.delegate respondsToSelector:@selector(bottomSheetControllerDidChangeYOffset:
                                                                                yOffset:)]) {
    [self.delegate bottomSheetControllerDidChangeYOffset:self yOffset:yOffset];
  }
}

- (id<MDCShapeGenerating>)shapeGeneratorForState:(MDCSheetState)state {
  id<MDCShapeGenerating> shapeGenerator = _shapeGenerators[@(state)];
  if (state != MDCSheetStateClosed && shapeGenerator == nil) {
    shapeGenerator = _shapeGenerators[@(MDCSheetStateClosed)];
  }
  if (shapeGenerator != nil) {
    return shapeGenerator;
  }
  return nil;
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator forState:(MDCSheetState)state {
  _shapeGenerators[@(state)] = shapeGenerator;

  [self updateShapeGenerator];
}

- (void)updateShapeGenerator {
  id<MDCShapeGenerating> shapeGenerator = [self shapeGeneratorForState:_state];
  if (self.view.shapeGenerator != shapeGenerator) {
    self.view.shapeGenerator = shapeGenerator;
    if (shapeGenerator != nil) {
      self.contentViewController.view.layer.mask =
          ((MDCShapedShadowLayer *)self.view.layer).shapeLayer;
    } else {
      self.contentViewController.view.layer.mask = nil;
    }
  }
}

- (void)setElevation:(MDCShadowElevation)elevation {
  if (MDCCGFloatEqual(elevation, _elevation)) {
    return;
  }

  _elevation = elevation;
  self.view.elevation = elevation;
  [self.view mdc_elevationDidChange];
}

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:
    (__unused id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCBottomSheetController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCBottomSheetController.modalPresentationStyle cannot be changed.");
  return;
}

- (void)setScrimColor:(UIColor *)scrimColor {
  _transitionController.scrimColor = scrimColor;
}

- (UIColor *)scrimColor {
  return _transitionController.scrimColor;
}

- (void)setIsScrimAccessibilityElement:(BOOL)isScrimAccessibilityElement {
  _transitionController.isScrimAccessibilityElement = isScrimAccessibilityElement;
}

- (BOOL)isScrimAccessibilityElement {
  return _transitionController.isScrimAccessibilityElement;
}

- (void)setScrimAccessibilityLabel:(NSString *)scrimAccessibilityLabel {
  _transitionController.scrimAccessibilityLabel = scrimAccessibilityLabel;
}

- (NSString *)scrimAccessibilityLabel {
  return _transitionController.scrimAccessibilityLabel;
}

- (void)setScrimAccessibilityHint:(NSString *)scrimAccessibilityHint {
  _transitionController.scrimAccessibilityHint = scrimAccessibilityHint;
}

- (NSString *)scrimAccessibilityHint {
  return _transitionController.scrimAccessibilityHint;
}

- (void)setScrimAccessibilityTraits:(UIAccessibilityTraits)scrimAccessibilityTraits {
  _transitionController.scrimAccessibilityTraits = scrimAccessibilityTraits;
}

- (UIAccessibilityTraits)scrimAccessibilityTraits {
  return _transitionController.scrimAccessibilityTraits;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull __unused MDCBottomSheetPresentationController *)bottomSheet {
#pragma clang diagnostic pop
  if ([self.delegate respondsToSelector:@selector(bottomSheetControllerDidDismissBottomSheet:)]) {
    [self.delegate bottomSheetControllerDidDismissBottomSheet:self];
  }
}

@end
