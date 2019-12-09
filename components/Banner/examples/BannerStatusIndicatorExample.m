// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialAppBar+Theming.h"
#import "MaterialAppBar.h"
#import "MaterialApplication.h"
#import "MaterialBanner+Theming.h"
#import "MaterialBanner.h"
#import "MaterialContainerScheme.h"
#import "MaterialOverlayWindow.h"

@interface BannerStatusIndicatorExample : UITableViewController <MDCFlexibleHeaderSafeAreaDelegate>

@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCBannerView *banner;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation BannerStatusIndicatorExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
    _appBarViewController = [[MDCAppBarViewController alloc] init];
    [_appBarViewController applyPrimaryThemeWithScheme:_containerScheme];

    // Behavioral flags.
    _appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
    _appBarViewController.headerView.sharedWithManyScrollViews = YES;
    _appBarViewController.headerView.canOverExtend = NO;
    _appBarViewController.shouldAdjustHeightBasedOnHeaderStackView = YES;
    _appBarViewController.safeAreaDelegate = self;

    self.title = @"Banner";
    [self addChildViewController:_appBarViewController];
  }
  return self;
}

#pragma mark - UIViewController

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize bannerViewSize = [self.banner sizeThatFits:self.view.bounds.size];

  CGFloat yOrigin = 0.0f;
  if (@available(iOS 11.0, *)) {
    UIViewController *topViewController = [self topViewController];
    yOrigin = topViewController.view.safeAreaInsets.top;
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(bannerViewSize.height, 0, 0, 0);
  } else {
    // Using Banner as a status indicator is only support on iOS 11.0 and above.
  }

  self.banner.frame = CGRectMake(0.0f, yOrigin, bannerViewSize.width, bannerViewSize.height);
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.appBarViewController.headerView.trackingScrollView = self.tableView;
  self.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;
  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Banner"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(showBanner)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBarViewController;
}

- (void)dismissBanner {
  [self.banner removeFromSuperview];
  self.banner = nil;
  [self.view setNeedsLayout];
}

- (void)showBanner {
  if (self.banner) {
    return;
  }
  self.banner = [[MDCBannerView alloc] init];
  [self.banner applyThemeWithScheme:_containerScheme];
  self.banner.textView.text = @"Global Banner Status Indicator";
  self.banner.textView.textAlignment = NSTextAlignmentCenter;
  self.banner.layoutMargins = UIEdgeInsetsZero;
  self.banner.textView.selectable = NO;
  self.banner.leadingButton.hidden = YES;
  self.banner.trailingButton.hidden = YES;

  UIViewController *topViewController = [self topViewController];
  [topViewController.view addSubview:self.banner];
  [self.view setNeedsLayout];

  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBanner)];
  [self.banner addGestureRecognizer:tapGestureRecognizer];

  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.banner);
}

- (UIViewController *)topViewController {
  UIViewController *topViewController = [[self overlayWindow] rootViewController];
  while ([topViewController presentedViewController]) {
    topViewController = [topViewController presentedViewController];
  }
  return topViewController;
}

- (UIWindow *)overlayWindow {
  UIApplication *application = [UIApplication mdc_safeSharedApplication];

  for (UIWindow *window in application.windows) {
    if ([window isKindOfClass:[MDCOverlayWindow class]]) {
      return window;
    }
  }

  if ([application.delegate respondsToSelector:@selector(window)]) {
    id potentialWindow = application.delegate.window;
    if (potentialWindow != nil) {
      return potentialWindow;
    }
  }

  return [[UIApplication mdc_safeSharedApplication] keyWindow];
}

#pragma mark - MDCFlexibleHeaderSafeAreaDelegate

- (UIViewController *)flexibleHeaderViewControllerTopSafeAreaInsetViewController:
    (MDCFlexibleHeaderViewController *)flexibleHeaderViewController {
  return self;
}

@end

@implementation BannerStatusIndicatorExample (TypicalUse)

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation BannerStatusIndicatorExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  // clang-format off
  return @{
    @"breadcrumbs" : @[ @"Banner", @"Banner (Status Indicator)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES
  };
  // clang-format on
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation BannerStatusIndicatorExample (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"cell"];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.text = [@(indexPath.row) stringValue];
  return cell;
}

@end
