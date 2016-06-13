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

@interface AppBarTypicalUseExample : UITableViewController

// Step 1: Create an App Bar.
@property(nonatomic, strong) MDCAppBar *appBar;

@end

@implementation AppBarTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"App Bar";

    // Step 2: Initialize the App Bar and add the headerViewController as a child.
    _appBar = [[MDCAppBar alloc] init];
    [self addChildViewController:_appBar.headerViewController];

    // Optional: Change the App Bar's background color and tint color.
    UIColor *color = [UIColor colorWithRed:(CGFloat)0x03 / (CGFloat)255
                                     green:(CGFloat)0xA9 / (CGFloat)255
                                      blue:(CGFloat)0xF4 / (CGFloat)255
                                     alpha:1];
    _appBar.headerViewController.headerView.backgroundColor = color;
    _appBar.navigationBar.tintColor = [UIColor whiteColor];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Recommended step: Set the tracking scroll view.
  self.appBar.headerViewController.headerView.trackingScrollView = self.tableView;

  // Choice: If you do not need to implement any delegate methods and you are not using a
  //         collection view, you can use the headerViewController as the delegate.
  // Alternative: See AppBarDelegateForwardingExample.
  self.tableView.delegate = self.appBar.headerViewController;

  // Step 3: Register the App Bar views.
  [self.appBar addSubviewsToParent];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;
}

// Optional step: If you allow the header view to hide the status bar you must implement this
//                method and return the headerViewController.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBar.headerViewController;
}

// Optional step: The Header View Controller does basic inspection of the header view's background
//                color to identify whether the status bar should be light or dark-themed.
- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBar.headerViewController;
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
  return @[ @"App Bar", @"App Bar" ];
}

+ (NSString *)catalogDescription {
  return @"The App Bar is a flexible navigation bar designed to provide a typical Material Design"
          " navigation experience.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
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
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.layoutMargins = UIEdgeInsetsZero;
  return cell;
}

@end
