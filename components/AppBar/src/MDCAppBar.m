/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCAppBar.h"

#import "MDCAppBarContainerViewController.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "MaterialApplication.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"
#import "MaterialUIMetrics.h"
#import "private/MaterialAppBarStrings.h"
#import "private/MaterialAppBarStrings_table.h"

static NSString *const kBarStackKey = @"barStack";
static NSString *const kStatusBarHeightKey = @"statusBarHeight";
static NSString *const MDCAppBarHeaderViewControllerKey = @"MDCAppBarHeaderViewControllerKey";
static NSString *const MDCAppBarNavigationBarKey = @"MDCAppBarNavigationBarKey";
static NSString *const MDCAppBarHeaderStackViewKey = @"MDCAppBarHeaderStackViewKey";

// The Bundle for string resources.
static NSString *const kMaterialAppBarBundle = @"MaterialAppBar.bundle";

@implementation MDCAppBarTextColorAccessibilityMutator

- (void)mutate:(nonnull MDCAppBar *)appBar {
  // Determine what is the appropriate background color
  // Because navigation bar renders above headerview, it takes presedence
  UIColor *backgroundColor = appBar.navigationBar.backgroundColor ?:
      appBar.headerViewController.headerView.backgroundColor;
  if (!backgroundColor) {
    return;
  }

  // Update title label color based on navigationBar/headerView backgroundColor
  NSMutableDictionary *textAttr =
      [NSMutableDictionary dictionaryWithDictionary:[appBar.navigationBar titleTextAttributes]];
  MDFTextAccessibilityOptions options = 0;
  BOOL isLarge =
      [MDCTypography isLargeForContrastRatios:[textAttr objectForKey:NSFontAttributeName]];
  if (isLarge) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }
  UIColor *textColor =
      [MDFTextAccessibility textColorOnBackgroundColor:backgroundColor
                                       targetTextAlpha:1.0
                                                  options:options];

  [textAttr setObject:textColor forKey:NSForegroundColorAttributeName];
  [appBar.navigationBar setTitleTextAttributes:textAttr];

  // Update button's tint color based on navigationBar backgroundColor
  appBar.navigationBar.tintColor = textColor;
}

@end

@class MDCAppBarViewController;

@interface MDCAppBar ()

@property(nonatomic, strong) MDCAppBarViewController *appBarController;

@end

@interface MDCAppBarViewController : UIViewController

@property(nonatomic, strong) MDCHeaderStackView *headerStackView;
@property(nonatomic, strong) MDCNavigationBar *navigationBar;

@end

@implementation MDCAppBar

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCAppBarInit];
    [self commonMDCAppBarViewSetup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCAppBarInit];
    if ([aDecoder containsValueForKey:MDCAppBarHeaderViewControllerKey]) {
      _headerViewController = [aDecoder decodeObjectOfClass:[MDCFlexibleHeaderViewController class]
                                                     forKey:MDCAppBarHeaderViewControllerKey];
    }

    if ([aDecoder containsValueForKey:MDCAppBarNavigationBarKey]) {
      _navigationBar = [aDecoder decodeObjectOfClass:[MDCNavigationBar class]
                                              forKey:MDCAppBarNavigationBarKey];
      _appBarController.navigationBar = _navigationBar;
    }

    if ([aDecoder containsValueForKey:MDCAppBarHeaderStackViewKey]) {
      _headerStackView = [aDecoder decodeObjectOfClass:[MDCHeaderStackView class]
                                              forKey:MDCAppBarHeaderStackViewKey];
      _appBarController.headerStackView = _headerStackView;
    }

    [self commonMDCAppBarViewSetup];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.headerViewController forKey:MDCAppBarHeaderViewControllerKey];
  [aCoder encodeObject:self.navigationBar forKey:MDCAppBarNavigationBarKey];
  [aCoder encodeObject:self.headerStackView forKey:MDCAppBarHeaderStackViewKey];
}

- (void)commonMDCAppBarInit {
  _headerViewController = [[MDCFlexibleHeaderViewController alloc] init];

  // Shadow layer
  MDCFlexibleHeaderView *headerView = _headerViewController.headerView;
  MDCFlexibleHeaderShadowIntensityChangeBlock intensityBlock =
      ^(CALayer *_Nonnull shadowLayer, CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        [(MDCShadowLayer *)shadowLayer setElevation:elevation];
      };
  [headerView setShadowLayer:[MDCShadowLayer layer] intensityDidChangeBlock:intensityBlock];
  _appBarController = [[MDCAppBarViewController alloc] init];
  _headerStackView = _appBarController.headerStackView;
  _navigationBar = _appBarController.navigationBar;
}

- (void)commonMDCAppBarViewSetup {
  [_headerViewController addChildViewController:_appBarController];
  _appBarController.view.frame = _headerViewController.view.bounds;
  [_headerViewController.view addSubview:_appBarController.view];
  [_appBarController didMoveToParentViewController:_headerViewController];

  [_headerViewController.headerView forwardTouchEventsForView:_appBarController.headerStackView];
  [_headerViewController.headerView forwardTouchEventsForView:_appBarController.navigationBar];
}

- (void)addHeaderViewControllerToParentViewController:
        (nonnull UIViewController *)parentViewController {
  [parentViewController addChildViewController:_headerViewController];
}

- (void)addSubviewsToParent {
  MDCFlexibleHeaderViewController *fhvc = self.headerViewController;
  NSAssert(fhvc.parentViewController,
           @"headerViewController does not have a parentViewController. "
           @"Use [self addChildViewController:appBar.headerViewController]. "
           @"This warning only appears in DEBUG builds");
  if (fhvc.view.superview == fhvc.parentViewController.view) {
    return;
  }

  // Enforce the header's desire to fully cover the width of its parent view.
  CGRect frame = fhvc.view.frame;
  frame.origin.x = 0;
  frame.size.width = fhvc.parentViewController.view.bounds.size.width;
  fhvc.view.frame = frame;

  [fhvc.parentViewController.view addSubview:fhvc.view];
  [fhvc didMoveToParentViewController:fhvc.parentViewController];

  [self.navigationBar observeNavigationItem:fhvc.parentViewController.navigationItem];
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
  return YES;
}

@end

@implementation MDCAppBarViewController {
  NSLayoutConstraint *_verticalConstraint;
}

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

- (UIViewController *)flexibleHeaderParentViewController {
  NSAssert([self.parentViewController isKindOfClass:[MDCFlexibleHeaderViewController class]],
           @"Expected the parent of %@ to be a type of %@", NSStringFromClass([self class]),
           NSStringFromClass([MDCFlexibleHeaderViewController class]));
  return self.parentViewController.parentViewController;
}

- (UIBarButtonItem *)backButtonItem {
  UIViewController *fhvParent = self.flexibleHeaderParentViewController;
  UINavigationController *navigationController = fhvParent.navigationController;

  NSArray<UIViewController *> *viewControllerStack = navigationController.viewControllers;

  // This will be zero if there is no navigation controller, so a view controller which is not
  // inside a navigation controller will be treated the same as a view controller at the root of a
  // navigation controller
  NSUInteger index = [viewControllerStack indexOfObject:fhvParent];

  UIViewController *iterator = fhvParent;

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
  NSString *key =
      kMaterialAppBarStringTable[kStr_MaterialAppBarBackButtonAccessibilityLabel];
  backBarButtonItem.accessibilityLabel =
      NSLocalizedStringFromTableInBundle(key,
                                         kMaterialAppBarStringsTableName,
                                         [[self class] bundle],
                                         @"Back");
  return backBarButtonItem;
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
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle)resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.headerStackView.translatesAutoresizingMaskIntoConstraints = NO;
  self.headerStackView.topBar = self.navigationBar;

  [self.view addSubview:self.headerStackView];

  // Bar stack expands vertically, but has a margin above it for the status bar.
  NSArray<NSLayoutConstraint *> *horizontalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[%@]|", kBarStackKey]
                          options:0
                          metrics:nil
                            views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:horizontalConstraints];

  CGFloat topMargin = MDCDeviceTopSafeAreaInset();
  _verticalConstraint = [NSLayoutConstraint constraintWithItem:self.headerStackView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:topMargin];
  _verticalConstraint.active = YES;

  [NSLayoutConstraint constraintWithItem:self.headerStackView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:0].active = YES;
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

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    // We only update the top inset on iOS 11 because previously we were not adjusting the header
    // height to make it smaller when the status bar is hidden.
    _verticalConstraint.constant = MDCDeviceTopSafeAreaInset();
  }
#endif
}

- (BOOL)accessibilityPerformEscape {
  [self dismissSelf];
  return YES;
}

#pragma mark User actions

- (void)didTapBackButton:(__unused id)sender {
  [self dismissSelf];
}

- (void)dismissSelf {
  UIViewController *pvc = self.flexibleHeaderParentViewController;
  if (pvc.navigationController && pvc.navigationController.viewControllers.count > 1) {
    [pvc.navigationController popViewControllerAnimated:YES];
  } else {
    [pvc dismissViewControllerAnimated:YES completion:nil];
  }
}

@end
