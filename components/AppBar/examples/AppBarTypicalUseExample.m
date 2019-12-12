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

#import <UIKit/UIKit.h>

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialAppBar.h"

@interface AppBarTypicalUseExample : UITableViewController

// Step 1: Create an App Bar.
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation AppBarTypicalUseExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"App Bar";

    // Step 2: Initialize the App Bar and add the headerViewController as a child.
    _appBarViewController = [[MDCAppBarViewController alloc] init];

    // Behavioral flags.
    _appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
    _appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

    [self addChildViewController:_appBarViewController];

    _appBarViewController.navigationBar.inkColor = [UIColor colorWithWhite:(CGFloat)0.9
                                                                     alpha:(CGFloat)0.1];

    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:_appBarViewController];

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
  self.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  // Recommended step: Set the tracking scroll view.
  self.appBarViewController.headerView.trackingScrollView = self.tableView;

  // Step 3: Register the App Bar views.
  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                       style:UIBarButtonItemStyleDone
                                      target:nil
                                      action:nil];
}

// Optional step: If you allow the header view to hide the status bar you must implement this
//                method and return the headerViewController.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBarViewController;
}

// Optional step: The Header View Controller does basic inspection of the header view's background
//                color to identify whether the status bar should be light or dark-themed.
- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBarViewController;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"App Bar" ],
    @"description" : @"The top app bar displays information and actions relating to "
                     @"the current view.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation AppBarTypicalUseExample (UITableViewDataSource)

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
  cell.layoutMargins = UIEdgeInsetsZero;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

@end
