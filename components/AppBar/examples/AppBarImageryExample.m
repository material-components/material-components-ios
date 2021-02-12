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
#import "MaterialAppBar.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialNavigationBar.h"
#import "MaterialColorScheme.h"

@interface AppBarImageryExample : UITableViewController
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation AppBarImageryExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  self = [super init];
  if (self) {
    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

    _appBarViewController = [[MDCAppBarViewController alloc] init];

    // Behavioral flags.
    _appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
    _appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

    self.title = @"Imagery";

    [self addChildViewController:_appBarViewController];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create our custom image view and add it to the header view.
  UIImageView *imageView = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"mdc_theme"
                                             inBundle:[NSBundle bundleForClass:[AppBarImageryExample
                                                                                   class]]
                        compatibleWithTraitCollection:nil]];
  imageView.frame = self.appBarViewController.headerView.bounds;

  // Ensure that the image view resizes in reaction to the header view bounds changing.
  imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  // Ensure that the image view is below other App Bar views (headerStackView).
  [self.appBarViewController.headerView insertSubview:imageView atIndex:0];

  // Scales up the image while the header is over-extending.
  imageView.contentMode = UIViewContentModeScaleAspectFill;

  // The header view does not clip to bounds by default so we ensure that the image is clipped.
  imageView.clipsToBounds = YES;

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];

  // Make sure navigation bar background color is clear so the image view is visible.
  self.appBarViewController.navigationBar.backgroundColor = [UIColor clearColor];

  // Allow the header to show more of the image.
  self.appBarViewController.headerView.maximumHeight = 300;

  // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
  self.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  // Typical use
  self.appBarViewController.headerView.trackingScrollView = self.tableView;

  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

@end

@implementation AppBarImageryExample (TypicalUse)

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarImageryExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  // clang-format off
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"Imagery" ],
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

@implementation AppBarImageryExample (UITableViewDataSource)

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
  return cell;
}

@end
