// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

@interface AppBarWrappingUITableViewControllerExample : UIViewController <UITableViewDataSource>

@property(nonatomic, strong) MDCAppBarContainerViewController *appBarContainerViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation AppBarWrappingUITableViewControllerExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarContainerViewController.appBarViewController.headerView.trackingScrollView = nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UITableViewController *tableViewController =
      [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
  tableViewController.title = @"Wrapped table view";
  self.appBarContainerViewController =
      [[MDCAppBarContainerViewController alloc] initWithContentViewController:tableViewController];

  // Behavioral flags.
  MDCAppBarViewController *appBarViewController =
      self.appBarContainerViewController.appBarViewController;
  appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
  appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;
  self.appBarContainerViewController.topLayoutGuideAdjustmentEnabled = YES;

  tableViewController.tableView.dataSource = self;
  [tableViewController.tableView registerClass:[UITableViewCell class]
                        forCellReuseIdentifier:@"cell"];

  MDCFlexibleHeaderView *headerView =
      self.appBarContainerViewController.appBarViewController.headerView;

  // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
  headerView.observesTrackingScrollViewScrollEvents = YES;

  headerView.trackingScrollView = tableViewController.tableView;

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarContainerViewController.appBarViewController];
  [MDCAppBarTypographyThemer
       applyTypographyScheme:self.typographyScheme
      toAppBarViewController:self.appBarContainerViewController.appBarViewController];

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  [self addChildViewController:self.appBarContainerViewController];
  self.appBarContainerViewController.view.frame = self.view.bounds;
  [self.view addSubview:self.appBarContainerViewController.view];
  [self.appBarContainerViewController didMoveToParentViewController:self];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBarContainerViewController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                          forIndexPath:indexPath];
  cell.textLabel.text = [@(indexPath.row) description];
  return cell;
}

@end

@implementation AppBarWrappingUITableViewControllerExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"Wrapped table view" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
