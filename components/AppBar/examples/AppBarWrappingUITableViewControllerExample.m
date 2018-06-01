/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"

@interface AppBarWrappingUITableViewControllerExample : UIViewController <UITableViewDataSource>

@property(nonatomic, strong) MDCAppBarContainerViewController *appBarContainerViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation AppBarWrappingUITableViewControllerExample

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _colorScheme = [[MDCSemanticColorScheme alloc] init];
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

  tableViewController.tableView.dataSource = self;
  tableViewController.tableView.delegate =
      self.appBarContainerViewController.appBar.headerViewController;
  [tableViewController.tableView registerClass:[UITableViewCell class]
                        forCellReuseIdentifier:@"cell"];

  self.appBarContainerViewController.appBar.headerViewController.headerView.trackingScrollView =
      tableViewController.tableView;

  [MDCAppBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toAppBar:self.appBarContainerViewController.appBar];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                                          toAppBar:self.appBarContainerViewController.appBar];

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

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Wrapped table view" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

@end
