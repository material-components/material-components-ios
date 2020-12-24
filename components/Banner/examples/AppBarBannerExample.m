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
#import "MaterialBanner+Theming.h"
#import "MaterialBanner.h"
#import "MaterialContainerScheme.h"

@interface AppBarBannerExample : UITableViewController

@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCBannerView *banner;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation AppBarBannerExample

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

    self.title = @"Banner";
    [self addChildViewController:_appBarViewController];
  }
  return self;
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
  self.appBarViewController.headerStackView.bottomBar = nil;
  self.banner = nil;
}

- (void)showBanner {
  self.banner = [[MDCBannerView alloc] init];
  [self.banner applyThemeWithScheme:_containerScheme];
  self.banner.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
  self.banner.textView.text = @"This banner has been set as bottomBar of this AppBar.";
  [self.banner.leadingButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [self.banner.leadingButton addTarget:self
                                action:@selector(dismissBanner)
                      forControlEvents:UIControlEventTouchUpInside];
  self.banner.trailingButton.hidden = YES;
  self.appBarViewController.headerStackView.bottomBar = self.banner;

  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.banner);
}

@end

@implementation AppBarBannerExample (TypicalUse)

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarBannerExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  // clang-format off
  return @{
    @"breadcrumbs" : @[ @"Banner", @"App Bar + Banner" ],
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

@implementation AppBarBannerExample (UITableViewDataSource)

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
