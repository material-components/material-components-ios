/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCAppBar.h"

#import "MDCAppBarContainerViewController.h"

#import "MaterialFlexibleHeader.h"
#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static NSString *const kBarStackKey = @"barStack";
static NSString *const kStatusBarHeightKey = @"statusBarHeight";
static const CGFloat kStatusBarHeight = 20;

@interface MDCAppBarViewController : UIViewController

@property(nonatomic, strong) MDCHeaderStackView *headerStackView;
@property(nonatomic, strong) MDCNavigationBar *navigationBar;

@end

@implementation MDCAppBar

- (instancetype)init {
  self = [super init];
  if (self) {
    _headerViewController = [[MDCFlexibleHeaderViewController alloc] init];

    MDCFlexibleHeaderView *headerView = _headerViewController.headerView;

    // Shadow layer

    MDCFlexibleHeaderShadowIntensityChangeBlock intensityBlock =
        ^(CALayer *_Nonnull shadowLayer, CGFloat intensity) {
          CGFloat elevation = MDCShadowElevationAppBar * intensity;
          [(MDCShadowLayer *)shadowLayer setElevation:elevation];
        };
    [headerView setShadowLayer:[MDCShadowLayer layer] intensityDidChangeBlock:intensityBlock];

    // Header stack view + navigation bar
    MDCAppBarViewController *appBarViewController = [[MDCAppBarViewController alloc] init];
    [_headerViewController addChildViewController:appBarViewController];
    appBarViewController.view.frame = _headerViewController.view.bounds;
    [_headerViewController.view addSubview:appBarViewController.view];
    [appBarViewController didMoveToParentViewController:_headerViewController];

    [headerView forwardTouchEventsForView:appBarViewController.headerStackView];
    [headerView forwardTouchEventsForView:appBarViewController.navigationBar];

    _headerStackView = appBarViewController.headerStackView;
    _navigationBar = appBarViewController.navigationBar;
  }
  return self;
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

@end

@implementation MDCAppBarViewController

- (MDCHeaderStackView *)headerStackView {
  if (![self isViewLoaded]) {
    [self loadView];
  }
  return _headerStackView;
}

- (MDCNavigationBar *)navigationBar {
  if (![self isViewLoaded]) {
    [self loadView];
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

  NSArray *viewControllerStack = navigationController.viewControllers;

  // This will be zero if there is no navigation controller, so a view controller which is not
  // inside a navigation controller will be treated the same as a view controller at the root of a
  // navigation controller
  NSUInteger index = [viewControllerStack indexOfObject:fhvParent];

  UIViewController *iterator = fhvParent;

  // In complex cases it might actually be a parent of |fhvParent| which is on the nav stack.
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
    UIImage *backButtonImage = [UIImage imageWithContentsOfFile:[MDCIcons pathFor_ic_arrow_back]];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (self.navigationBar.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
#if defined(__IPHONE_9_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
      if ([backButtonImage
              respondsToSelector:@selector(imageFlippedForRightToLeftLayoutDirection)]) {
        backButtonImage = [backButtonImage imageFlippedForRightToLeftLayoutDirection];
      }
#else
      backButtonImage = [UIImage imageWithCGImage:backButtonImage.CGImage
                                            scale:backButtonImage.scale
                                      orientation:UIImageOrientationUpMirrored];
#endif
    }
    backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(didTapBackButton:)];
  }
  backBarButtonItem.accessibilityIdentifier = @"back_bar_button";
  return backBarButtonItem;
}

+ (NSBundle *)baseBundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // We may not be included by the main bundle, but rather by an embedded framework, so figure out
    // to which bundle our code is compiled, and use that as the starting point for bundle loading.
    bundle = [NSBundle bundleForClass:[self class]];
  });

  return bundle;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.headerStackView = [[MDCHeaderStackView alloc] initWithFrame:self.view.bounds];
  self.headerStackView.translatesAutoresizingMaskIntoConstraints = NO;

  self.navigationBar = [[MDCNavigationBar alloc] init];
  self.headerStackView.topBar = self.navigationBar;

  [self.view addSubview:self.headerStackView];

  // Bar stack expands vertically, but has a margin above it for the status bar.

  NSArray *horizontalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[%@]|", kBarStackKey]
                          options:0
                          metrics:nil
                            views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:horizontalConstraints];

  NSArray *verticalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%@-[%@]|", kStatusBarHeightKey,
                                                             kBarStackKey]
                          options:0
                          metrics:@{
                            kStatusBarHeightKey : @(kStatusBarHeight)
                          }
                            views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:verticalConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  UIBarButtonItem *backBarButtonItem = [self backButtonItem];
  if (backBarButtonItem && !self.navigationBar.backItem) {
    self.navigationBar.backItem = backBarButtonItem;
  }
}

#pragma mark User actions

- (void)didTapBackButton:(id)sender {
  UIViewController *pvc = self.flexibleHeaderParentViewController;
  if (pvc.navigationController && pvc.navigationController.viewControllers.count > 1) {
    [pvc.navigationController popViewControllerAnimated:YES];
  } else {
    [pvc dismissViewControllerAnimated:YES completion:nil];
  }
}

@end
