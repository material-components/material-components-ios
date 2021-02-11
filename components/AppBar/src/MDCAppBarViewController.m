// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCAppBarViewController.h"

#import "MDCAppBarContainerViewController.h"

#import "private/MaterialAppBarStrings.h"
#import "private/MaterialAppBarStrings_table.h"
#import "MDCAppBarViewControllerAccessibilityPerformEscapeDelegate.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialHeaderStackView.h"
#import "MaterialNavigationBar.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialUIMetrics.h"
#import <MDFInternationalization/MDFInternationalization.h>

static NSString *const kBarStackKey = @"barStack";

// The Bundle for string resources.
static NSString *const kMaterialAppBarBundle = @"MaterialAppBar.bundle";

@implementation MDCAppBarViewController {
  NSLayoutConstraint *_verticalConstraint;
  NSLayoutConstraint *_topSafeAreaConstraint;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self MDCAppBarViewController_commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self MDCAppBarViewController_commonInit];
  }
  return self;
}

- (void)MDCAppBarViewController_commonInit {
  // Shadow layer
  __weak MDCAppBarViewController *weakSelf = self;
  MDCFlexibleHeaderShadowIntensityChangeBlock intensityBlock =
      ^(CALayer *_Nonnull shadowLayer, CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        weakSelf.headerView.elevation = elevation;
        [(MDCShadowLayer *)shadowLayer setElevation:elevation];
      };
  [self.headerView setShadowLayer:[MDCShadowLayer layer] intensityDidChangeBlock:intensityBlock];

  [self.headerView forwardTouchEventsForView:self.headerStackView];
  [self.headerView forwardTouchEventsForView:self.navigationBar];

  self.headerStackView.translatesAutoresizingMaskIntoConstraints = NO;
  self.headerStackView.topBar = self.navigationBar;
}

#pragma mark - Properties

- (MDCHeaderStackView *)headerStackView {
  // Removed call to loadView here as we should never be calling it manually.
  // It previously replaced loadViewIfNeeded call that is only iOS 9.0+ to
  // make backwards compatible.
  // Underlying issue is you need view loaded before accessing. Below change will accomplish that
  // by calling for view.bounds initializing the stack view
  if (!_headerStackView) {
    _headerStackView = [[MDCHeaderStackView alloc] initWithFrame:CGRectZero];
  }
  return _headerStackView;
}

- (MDCNavigationBar *)navigationBar {
  if (!_navigationBar) {
    _navigationBar = [[MDCNavigationBar alloc] init];
  }
  return _navigationBar;
}

- (UIBarButtonItem *)backButtonItem {
  UIViewController *parent = self.parentViewController;
  UINavigationController *navigationController = parent.navigationController;

  NSArray<UIViewController *> *viewControllerStack = navigationController.viewControllers;

  // This will be zero if there is no navigation controller, so a view controller which is not
  // inside a navigation controller will be treated the same as a view controller at the root of a
  // navigation controller
  NSUInteger index = [viewControllerStack indexOfObject:parent];

  UIViewController *iterator = parent;

  // In complex cases it might actually be a parent of @c fhvParent which is on the nav stack.
  while (index == NSNotFound && iterator && ![iterator isEqual:navigationController]) {
    iterator = iterator.parentViewController;
    index = [viewControllerStack indexOfObject:iterator];
  }

  if (index == NSNotFound) {
    NSCAssert(NO, @"View controller not present in its own navigation controller.");
    // This is not something which should ever happen, but just in case.
    return nil;
  }
  if (index == 0) {
    // The view controller is at the root of a navigation stack (or not in one).
    return nil;
  }
  UIViewController *previousViewControler = navigationController.viewControllers[index - 1];
  if ([previousViewControler isKindOfClass:[MDCAppBarContainerViewController class]]) {
    // Special case: if the previous view controller is a container controller, use its content
    // view controller.
    MDCAppBarContainerViewController *chvc =
        (MDCAppBarContainerViewController *)previousViewControler;
    previousViewControler = chvc.contentViewController;
  }
  UIBarButtonItem *backBarButtonItem = previousViewControler.navigationItem.backBarButtonItem;
  if (!backBarButtonItem) {
    UIImage *backButtonImage = [MDCIcons imageFor_ic_arrow_back];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (self.navigationBar.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      backButtonImage = [backButtonImage mdf_imageWithHorizontallyFlippedOrientation];
    }
    backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(didTapBackButton:)];
  }
  backBarButtonItem.accessibilityIdentifier = @"back_bar_button";
  NSString *key = kMaterialAppBarStringTable[kStr_MaterialAppBarBackButtonAccessibilityLabel];
  backBarButtonItem.accessibilityLabel = NSLocalizedStringFromTableInBundle(
      key, kMaterialAppBarStringsTableName, [[self class] bundle], @"Back");
  return backBarButtonItem;
}

- (void)setShouldAdjustHeightBasedOnHeaderStackView:(BOOL)shouldAdjustHeightBasedOnHeaderStackView {
  _shouldAdjustHeightBasedOnHeaderStackView = shouldAdjustHeightBasedOnHeaderStackView;
  if (shouldAdjustHeightBasedOnHeaderStackView) {
    self.headerView.minMaxHeightIncludesSafeArea = NO;
    [self adjustHeightBasedOnHeaderStackView];
  }
}

- (void)setInferTopSafeAreaInsetFromViewController:(BOOL)inferTopSafeAreaInsetFromViewController {
  [super setInferTopSafeAreaInsetFromViewController:inferTopSafeAreaInsetFromViewController];

  if (inferTopSafeAreaInsetFromViewController) {
    self.topLayoutGuideAdjustmentEnabled = YES;
  }

  _verticalConstraint.active = !self.inferTopSafeAreaInsetFromViewController;
  _topSafeAreaConstraint.active = self.inferTopSafeAreaInsetFromViewController;
}

- (void)setHeaderStackViewOffset:(CGFloat)headerStackViewOffset {
  _headerStackViewOffset = headerStackViewOffset;
  _verticalConstraint.constant = [self verticalContraintLength];
  _topSafeAreaConstraint.constant = [self topSafeAreaContraintLength];
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialAppBarBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCAppBar class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.headerStackView];

  // Bar stack expands vertically, but has a margin above it for the status bar.
  NSArray<NSLayoutConstraint *> *horizontalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[%@]|", kBarStackKey]
                          options:0
                          metrics:nil
                            views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:horizontalConstraints];

  CGFloat topMargin = [self verticalContraintLength];
  _verticalConstraint = [NSLayoutConstraint constraintWithItem:self.headerStackView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:topMargin];
  _verticalConstraint.active = !self.inferTopSafeAreaInsetFromViewController;

  _topSafeAreaConstraint =
      [NSLayoutConstraint constraintWithItem:self.headerStackView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.headerView.topSafeAreaGuide
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:[self topSafeAreaContraintLength]];
  _topSafeAreaConstraint.active = self.inferTopSafeAreaInsetFromViewController;

  [NSLayoutConstraint constraintWithItem:self.headerStackView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:0]
      .active = YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  UIBarButtonItem *backBarButtonItem = [self backButtonItem];
  if (backBarButtonItem && !self.navigationBar.backItem) {
    self.navigationBar.backItem = backBarButtonItem;
  }
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  if (@available(iOS 11.0, *)) {
    // We only update the top inset on iOS 11 because previously we were not adjusting the header
    // height to make it smaller when the status bar is hidden.
    _verticalConstraint.constant = [self verticalContraintLength];
  }

  if (self.shouldAdjustHeightBasedOnHeaderStackView) {
    [self adjustHeightBasedOnHeaderStackView];
  }
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];

  [self.navigationBar observeNavigationItem:parent.navigationItem];

  CGRect frame = self.view.frame;
  frame.size.width = CGRectGetWidth(parent.view.bounds);
  self.view.frame = frame;
}

#pragma mark - UIAccessibility

- (BOOL)accessibilityPerformEscape {
  if (self.accessibilityPerformEscapeDelegate) {
    return [self.accessibilityPerformEscapeDelegate
        appBarViewControllerAccessibilityPerformEscape:self];
  }

  // Fall-back behavior.
  [self dismissSelf];
  return YES;
}

#pragma mark User actions

- (void)didTapBackButton:(__unused id)sender {
  [self dismissSelf];
}

- (void)dismissSelf {
  UIViewController *pvc = self.parentViewController;
  if (pvc.navigationController && pvc.navigationController.viewControllers.count > 1) {
    [pvc.navigationController popViewControllerAnimated:YES];
  } else {
    [pvc dismissViewControllerAnimated:YES completion:nil];
  }
}

#pragma mark - Private

- (CGFloat)verticalContraintLength {
  return MDCDeviceTopSafeAreaInset() + _headerStackViewOffset;
}

- (CGFloat)topSafeAreaContraintLength {
  return _headerStackViewOffset;
}

- (void)adjustHeightBasedOnHeaderStackView {
  CGFloat heightSum = 0;
  heightSum += [self.headerStackView.topBar sizeThatFits:self.view.bounds.size].height;
  heightSum += [self.headerStackView.bottomBar sizeThatFits:self.view.bounds.size].height;
  heightSum += _headerStackViewOffset;
  self.headerView.minimumHeight = heightSum;
  self.headerView.maximumHeight = heightSum;
}

@end

#pragma mark - To be deprecated

@implementation MDCAppBar

- (instancetype)init {
  self = [super init];
  if (self) {
    _appBarViewController = [[MDCAppBarViewController alloc] init];
  }
  return self;
}

- (MDCFlexibleHeaderViewController *)headerViewController {
  return self.appBarViewController;
}

- (MDCHeaderStackView *)headerStackView {
  return self.appBarViewController.headerStackView;
}

- (MDCNavigationBar *)navigationBar {
  return self.appBarViewController.navigationBar;
}

- (void)addSubviewsToParent {
  MDCAppBarViewController *abvc = self.appBarViewController;
  NSAssert(abvc.parentViewController,
           @"appBarViewController does not have a parentViewController. "
           @"Use [self addChildViewController:appBar.appBarViewController]. "
           @"This warning only appears in DEBUG builds");
  if (abvc.view.superview == abvc.parentViewController.view) {
    return;
  }

  // Enforce the header's desire to fully cover the width of its parent view.
  CGRect frame = abvc.view.frame;
  frame.origin.x = 0;
  frame.size.width = abvc.parentViewController.view.bounds.size.width;
  abvc.view.frame = frame;

  [abvc.parentViewController.view addSubview:abvc.view];
  [abvc didMoveToParentViewController:abvc.parentViewController];
}

- (void)setInferTopSafeAreaInsetFromViewController:(BOOL)inferTopSafeAreaInsetFromViewController {
  self.appBarViewController.inferTopSafeAreaInsetFromViewController =
      inferTopSafeAreaInsetFromViewController;
}

- (BOOL)inferTopSafeAreaInsetFromViewController {
  return self.appBarViewController.inferTopSafeAreaInsetFromViewController;
}

@end
