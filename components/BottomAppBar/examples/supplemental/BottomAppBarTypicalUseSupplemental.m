/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "BottomAppBarTypicalUseSupplemental.h"

@implementation BottomAppBarTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom App Bar", @"Bottom App Bar" ];
}

+ (NSString *)catalogDescription {
  return @"The bottom app bar is a bar docked at the bottom of the screen that has a floating "
         @"action button and can provide navigation.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation BottomAppBarTypicalUseExample (Supplemental)

- (void)setupExampleTableLayout {
  BottomAppBarExampleTableViewController *tableView =
      [[BottomAppBarExampleTableViewController alloc] initWithNibName:nil bundle:nil];
  tableView.bottomBarView = self.bottomBarView;
  self.viewController = tableView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation BottomAppBarExampleTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    NSArray<NSString *> *listItems = @[ @"Leading Floating Button",
                                        @"Center Floating Button",
                                        @"Trailing Floating Button",
                                        @"Primary Elevation Floating Button",
                                        @"Secondary Elevation Floating Button",
                                        @"Toggle Floating Button Visibility" ];
    _listItems = listItems;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.listItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.layoutMargins = UIEdgeInsetsZero;
  cell.textLabel.text = self.listItems[indexPath.item];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.item) {
    case 0:
      [self.bottomBarView setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionLeading
                                           animated:YES];
      break;
    case 1:
      [self.bottomBarView setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionCenter
                                           animated:YES];
      break;
    case 2:
      [self.bottomBarView setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionTrailing
                                           animated:YES];
      break;
    case 3:
      [self.bottomBarView setFloatingButtonElevation:MDCBottomAppBarFloatingButtonElevationPrimary
                                            animated:YES];
      break;
    case 4:
      [self.bottomBarView setFloatingButtonElevation:MDCBottomAppBarFloatingButtonElevationSecondary
                                            animated:YES];
      break;
    case 5:
      [self.bottomBarView setFloatingButtonHidden:!self.bottomBarView.floatingButtonHidden
                                         animated:YES];
      break;
    default:
      break;
  }
}

@end
