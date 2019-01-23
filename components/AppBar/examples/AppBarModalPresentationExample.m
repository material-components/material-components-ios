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

@interface AppBarModalPresentationExamplePresented : UITableViewController
@property(strong, nonatomic) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation AppBarModalPresentationExamplePresented

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    // Initialize the App Bar and add the headerViewController as a child.
    _appBarViewController = [[MDCAppBarViewController alloc] init];

    // Behavioral flags.
    _appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
    _appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

    [self addChildViewController:_appBarViewController];

    // Set presentation style
    [self setModalPresentationStyle:UIModalPresentationFormSheet];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];

    // Set preferred content size
    self.preferredContentSize = CGSizeMake(250, 500);

    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];

  // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
  self.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  self.appBarViewController.headerView.trackingScrollView = self.tableView;
  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];

  // Add optional navigation items
  self.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Dismiss"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(dismissSelf)];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Touch"
                                       style:UIBarButtonItemStyleDone
                                      target:nil
                                      action:nil];
}

- (void)dismissSelf {
  [self dismissViewControllerAnimated:YES completion:nil];
}

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
  return cell;
}

@end

// The below code class duplicates AppBarTypicalUseExample to present
// AppBarModalPresentationExamplePresented

@interface AppBarModalPresentationExample : UITableViewController
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation AppBarModalPresentationExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.delegate = self;

  self.appBarViewController.headerView.trackingScrollView = self.tableView;
  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Detail"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(presentModal)];

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)presentModal {
  AppBarModalPresentationExamplePresented *modalVC =
      [[AppBarModalPresentationExamplePresented alloc] init];
  [self presentViewController:modalVC
                     animated:YES
                   completion:^{
                   }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  MDCFlexibleHeaderView *headerView = self.appBarViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  MDCFlexibleHeaderView *headerView = self.appBarViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

@end

@implementation AppBarModalPresentationExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"Modal Presentation" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation AppBarModalPresentationExample (TypicalUse)

- (id)init {
  self = [super init];
  if (self) {
    _appBarViewController = [[MDCAppBarViewController alloc] init];
    [self addChildViewController:_appBarViewController];

    self.title = @"Modal Presentation";
  }
  return self;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBarViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBarViewController;
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation AppBarModalPresentationExample (UITableViewDataSource)

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
  return cell;
}

@end
