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

@interface BottomAppBarExampleTableViewController ()
@property(nonatomic, strong) UISwitch *fabVisibilitySwitch;
@end

@implementation BottomAppBarTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom App Bar", @"Bottom App Bar" ];
}

+ (NSString *)catalogDescription {
  return @"A bottom app bar displays navigation and key actions at the bottom of the screen.";
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
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    NSArray<NSString *> *listItems = @[ @"Leading Floating Button",
                                        @"Center Floating Button",
                                        @"Trailing Floating Button",
                                        @"Primary Elevation Floating Button",
                                        @"Secondary Elevation Floating Button",
                                        @"Visible FAB" ];
    _listItems = listItems;
  }
  return self;
}

- (void)dealloc {
  [self.fabVisibilitySwitch removeTarget:self
                                  action:@selector(didTapFABVisibilitySwitch:)
                        forControlEvents:UIControlEventAllEvents];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.fabVisibilitySwitch = [[UISwitch alloc] init];
  self.fabVisibilitySwitch.on = !self.bottomBarView.floatingButtonHidden;
  [self.fabVisibilitySwitch addTarget:self
                               action:@selector(didTapFABVisibilitySwitch:)
                     forControlEvents:UIControlEventValueChanged];


  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  cell.layoutMargins = UIEdgeInsetsZero;
  cell.textLabel.text = self.listItems[indexPath.item];
  [self.fabVisibilitySwitch removeFromSuperview];
  if (indexPath.row == (NSInteger)(self.listItems.count - 1)) {
    cell.accessoryView = self.fabVisibilitySwitch;
  } else {
    cell.accessoryView = nil;
  }
  return cell;
}

- (void)didTapFABVisibilitySwitch:(UISwitch *)sender {
  [self.bottomBarView setFloatingButtonHidden:!sender.isOn animated:YES];
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
      break;
    default:
      break;
  }
}

@end
