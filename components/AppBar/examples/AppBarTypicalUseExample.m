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
#import "MDCAppBarColorThemer.h"

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

    _appBar.headerViewController.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
    [_appBar.headerViewController.headerView hideViewWhenShifted:_appBar.headerStackView];

    _appBar.navigationBar.inkColor = [UIColor colorWithWhite:0.9f alpha:0.1f];

    MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
    [MDCAppBarColorThemer applySemanticColorScheme:colorScheme toAppBar:_appBar];

    _appBar.navigationBar.useFlexibleTopBottomInsets = YES;
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

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                       style:UIBarButtonItemStyleDone
                                      target:nil
                                      action:nil];
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

+ (BOOL)catalogIsPresentable {
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
