// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "BottomAppBarTypicalUseSupplemental.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialAppBar.h"

static NSString *const kCellIdentifier = @"cell";

@interface BottomAppBarExampleTableViewController ()
@property(nonatomic, strong) UISwitch *fabVisibilitySwitch;
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation BottomAppBarTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom App Bar", @"Bottom App Bar" ],
    @"description" : @"A bottom app bar displays navigation and key actions at the "
                     @"bottom of the screen.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
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
  tableView.colorScheme = self.colorScheme;
  tableView.typographyScheme = self.typographyScheme;
  self.viewController = tableView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.viewController;
}

@end

@implementation BottomAppBarExampleTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    NSArray<NSString *> *listItems = @[
      @"Leading Floating Button", @"Center Floating Button", @"Trailing Floating Button",
      @"Primary Elevation Floating Button", @"Secondary Elevation Floating Button", @"Visible FAB"
    ];
    _listItems = listItems;

    self.title = @"Bottom App Bar";

    _appBarViewController = [[MDCAppBarViewController alloc] init];
    [self addChildViewController:_appBarViewController];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:_appBarViewController];
  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];

  self.appBarViewController.headerView.trackingScrollView = self.tableView;

  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];

  self.fabVisibilitySwitch = [[UISwitch alloc] init];
  self.fabVisibilitySwitch.on = !self.bottomBarView.floatingButtonHidden;
  [self.fabVisibilitySwitch addTarget:self
                               action:@selector(didTapFABVisibilitySwitch:)
                     forControlEvents:UIControlEventValueChanged];

  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGRect bottomAppBarFrame = self.bottomBarView.frame;
  UIEdgeInsets contentInset = self.tableView.contentInset;
  contentInset.bottom = bottomAppBarFrame.size.height;
  self.tableView.contentInset = contentInset;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBarViewController;
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
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
      [self.fabVisibilitySwitch setOn:!self.fabVisibilitySwitch.isOn animated:YES];
      [self didTapFABVisibilitySwitch:self.fabVisibilitySwitch];
      break;
    default:
      break;
  }
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
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView
        trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView
        trackingScrollViewWillEndDraggingWithVelocity:velocity
                                  targetContentOffset:targetContentOffset];
  }
}

@end
