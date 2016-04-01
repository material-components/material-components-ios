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

#import <UIKit/UIKit.h>

#import "MaterialAppBar.h"

// Step 1: Your view controller must conform to MDCAppBarParenting.
@interface AppBarTypicalUseExample : UITableViewController <MDCAppBarParenting>
@end

@implementation AppBarTypicalUseExample

// Step 2: Synthesize the required properties.
@synthesize navigationBar;
@synthesize headerStackView;
@synthesize headerViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Typical use";

    // Step 3: Initialize the App Bar's parent.
    MDCAppBarPrepareParent(self);

    UIColor *color = [UIColor colorWithRed:(CGFloat)0x39 / (CGFloat)255
                                     green:(CGFloat)0xA4 / (CGFloat)255
                                      blue:(CGFloat)0xDD / (CGFloat)255
                                     alpha:1];
    self.headerViewController.headerView.backgroundColor = color;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Recommended step: Set the tracking scroll view.
  self.headerViewController.headerView.trackingScrollView = self.tableView;

  // Optional step: If you do not need to implement any delegate methods, you can use the
  //                headerViewController as the delegate.
  self.tableView.delegate = self.headerViewController;

  // Step 4: Register the App Bar views.
  MDCAppBarAddViews(self);
}

// Optional step: If you allow the header view to hide the status bar you must implement this
//                method and return the headerViewController.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.headerViewController;
}

// Optional step: The Header View Controller does basic inspection of the header view's background
//                color to identify whether the status bar should be light or dark-themed.
- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.headerViewController;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // We don't know whether the navigation bar will be visible within the Catalog by Convention, so
  // we always hide the navigation bar when we're about to appear.
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Typical use" ];
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
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
  return cell;
}

@end
