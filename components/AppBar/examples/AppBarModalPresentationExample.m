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

#import <UIKit/UIKit.h>

#import "MaterialAppBar.h"

@interface AppBarModalPresentationExamplePresented : UITableViewController
@property(strong, nonatomic) MDCAppBar *appBar;
@end

@implementation AppBarModalPresentationExamplePresented

- (instancetype)init {
  self = [super init];
  if (self) {
    // Initialize the App Bar and add the headerViewController as a child.
    _appBar = [[MDCAppBar alloc] init];
    [self addChildViewController:_appBar.headerViewController];

    // Optional: Change the App Bar's background color and tint color.
    UIColor *color = [UIColor colorWithWhite:0.2 alpha:1];
    _appBar.headerViewController.headerView.backgroundColor = color;
    MDCAppBarTextColorAccessibilityMutator *mutator =
        [[MDCAppBarTextColorAccessibilityMutator alloc] init];
    [mutator mutate:_appBar];

    // Set presentation style
    [self setModalPresentationStyle:UIModalPresentationFormSheet];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];

    // Set preferred content size
    self.preferredContentSize = CGSizeMake(250, 500);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // UITableViewController's tableView.delegate is self by default. We're setting it here for
  // emphasis.
  self.tableView.delegate = self;

  self.appBar.headerViewController.headerView.trackingScrollView = self.tableView;
  [self.appBar addSubviewsToParent];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;

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

#pragma mark - UIScrollViewDelegate

// The following four methods must be forwarded to the tracking scroll view in order to implement
// the Flexible Header's behavior.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.layoutMargins = UIEdgeInsetsZero;
  return cell;
}

@end

// The below code class duplicates AppBarTypicalUseExample to present
// AppBarModalPresentationExamplePresented

@interface AppBarModalPresentationExample : UITableViewController
@property(nonatomic, strong) MDCAppBar *appBar;
@end

@implementation AppBarModalPresentationExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.delegate = self;

  self.appBar.headerViewController.headerView.trackingScrollView = self.tableView;
  [self.appBar addSubviewsToParent];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Detail"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(presentModal)];
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
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  MDCFlexibleHeaderView *headerView = self.appBar.headerViewController.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

@end

@implementation AppBarModalPresentationExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Modal Presentation" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation AppBarModalPresentationExample (TypicalUse)

- (id)init {
  self = [super init];
  if (self) {
    _appBar = [[MDCAppBar alloc] init];
    _appBar.navigationBar.tintColor = [UIColor whiteColor];
    _appBar.navigationBar.titleTextAttributes =
        @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self addChildViewController:_appBar.headerViewController];

    self.title = @"Modal Presentation";

    UIColor *color = [UIColor colorWithWhite:0.2 alpha:1];
    _appBar.headerViewController.headerView.backgroundColor = color;
    MDCAppBarTextColorAccessibilityMutator *mutator =
        [[MDCAppBarTextColorAccessibilityMutator alloc] init];
    [mutator mutate:_appBar];
  }
  return self;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBar.headerViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBar.headerViewController;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.layoutMargins = UIEdgeInsetsZero;
  return cell;
}

@end
