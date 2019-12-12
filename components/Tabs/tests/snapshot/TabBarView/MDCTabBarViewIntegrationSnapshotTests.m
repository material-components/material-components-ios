// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import "MDCTabBarView.h"
#import "MaterialAppBar.h"
#import "MaterialHeaderStackView.h"

/** Snapshot tests for MDCTabBarView when integrating with other components. */
@interface MDCTabBarViewIntegrationSnapshotTests : MDCSnapshotTestCase

/** The tab bar being tested and integrated. */
@property(nonatomic, strong) MDCTabBarView *tabBarView;

@end

@implementation MDCTabBarViewIntegrationSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.tabBarView = [[MDCTabBarView alloc] init];

  UIImage *typicalIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                             withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:typicalIcon tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:typicalIcon tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:typicalIcon tag:2];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item3 animated:NO];
}

- (void)tearDown {
  self.tabBarView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - MDCHeaderStackView Integration

- (void)testTabBarViewInHeaderStackViewBottomBarWithWidthLessThanIntrinsicContentSize {
  // Given
  MDCHeaderStackView *headerStackView = [[MDCHeaderStackView alloc] init];
  headerStackView.backgroundColor = UIColor.orangeColor;
  CGSize tabBarViewIntrinsicContentSize = self.tabBarView.intrinsicContentSize;

  // When
  headerStackView.bottomBar = self.tabBarView;
  headerStackView.bounds = CGRectMake(0, 0, tabBarViewIntrinsicContentSize.width - 50,
                                      tabBarViewIntrinsicContentSize.height + 50);
  [headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:headerStackView];
}

- (void)testTabBarViewInHeaderStackViewBottomBarWithWidthEqualToIntrinsicContentSize {
  // Given
  MDCHeaderStackView *headerStackView = [[MDCHeaderStackView alloc] init];
  headerStackView.backgroundColor = UIColor.orangeColor;
  CGSize tabBarViewIntrinsicContentSize = self.tabBarView.intrinsicContentSize;

  // When
  headerStackView.bottomBar = self.tabBarView;
  headerStackView.bounds = CGRectMake(0, 0, tabBarViewIntrinsicContentSize.width,
                                      tabBarViewIntrinsicContentSize.height + 50);
  [headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:headerStackView];
}

- (void)testTabBarViewInHeaderStackViewBottomBarWithWidthGreaterThanIntrinsicContentSize {
  // Given
  MDCHeaderStackView *headerStackView = [[MDCHeaderStackView alloc] init];
  headerStackView.backgroundColor = UIColor.orangeColor;
  CGSize tabBarViewIntrinsicContentSize = self.tabBarView.intrinsicContentSize;

  // When
  headerStackView.bottomBar = self.tabBarView;
  headerStackView.bounds = CGRectMake(0, 0, tabBarViewIntrinsicContentSize.width + 50,
                                      tabBarViewIntrinsicContentSize.height + 50);
  [headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:headerStackView];
}

#pragma mark - MDCAppBarViewController Integration

- (void)testTabBarViewInAppBarViewBottomBarWithWidthLessThanIntrinsicContentSize {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  appBarController.navigationBar.title = @"TabBarView";
  appBarController.headerView.minimumHeight = 120;
  appBarController.headerView.backgroundColor = UIColor.orangeColor;
  CGSize tabBarViewIntrinsicContentSize = self.tabBarView.intrinsicContentSize;

  // When
  appBarController.headerStackView.bottomBar = self.tabBarView;
  appBarController.view.bounds = CGRectMake(0, 0, tabBarViewIntrinsicContentSize.width - 50,
                                            tabBarViewIntrinsicContentSize.height + 50);
  [appBarController.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:appBarController.view];
}

- (void)testTabBarViewInAppBarViewBottomBarWithWidthEqualToIntrinsicContentSize {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  appBarController.navigationBar.title = @"TabBarView";
  appBarController.headerView.minimumHeight = 120;
  appBarController.headerView.backgroundColor = UIColor.orangeColor;
  CGSize tabBarViewIntrinsicContentSize = self.tabBarView.intrinsicContentSize;

  // When
  appBarController.headerStackView.bottomBar = self.tabBarView;
  appBarController.view.bounds = CGRectMake(0, 0, tabBarViewIntrinsicContentSize.width,
                                            tabBarViewIntrinsicContentSize.height + 50);
  [appBarController.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:appBarController.view];
}

- (void)testTabBarViewInAppBarViewBottomBarWithWidthGreaterThanIntrinsicContentSize {
  // Given
  MDCAppBarViewController *appBarController = [[MDCAppBarViewController alloc] init];
  appBarController.navigationBar.title = @"TabBarView";
  appBarController.headerView.minimumHeight = 120;
  appBarController.headerView.backgroundColor = UIColor.orangeColor;
  CGSize tabBarViewIntrinsicContentSize = self.tabBarView.intrinsicContentSize;

  // When
  appBarController.headerStackView.bottomBar = self.tabBarView;
  appBarController.view.bounds = CGRectMake(0, 0, tabBarViewIntrinsicContentSize.width + 50,
                                            tabBarViewIntrinsicContentSize.height + 50);
  [appBarController.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:appBarController.view];
}

@end
