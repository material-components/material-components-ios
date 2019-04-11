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

#import "MaterialContainerScheme.h"
#import "MaterialTabs+Theming.h"
#import "MaterialTabs.h"

static NSString *const kItemTitle1 = @"Item 1";
static NSString *const kItemTitle2 = @"Item 2";
static NSString *const kItemTitle3 = @"Item 3";
static NSString *const kItemBadgeValue = @"Badge";

/** Snapshot tests for MDCTabBar rendering .*/
@interface MDCTabBar_MaterialThemingSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCTabBar *tabBar;
@property(nonatomic, strong) UITabBarItem *item1;
@property(nonatomic, strong) UITabBarItem *item2;
@property(nonatomic, strong) UITabBarItem *item3;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@end

@implementation MDCTabBar_MaterialThemingSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  CGSize imageSize = CGSizeMake(24, 24);
  self.tabBar = [[MDCTabBar alloc] init];
  self.item1 = [[UITabBarItem alloc]
      initWithTitle:kItemTitle1
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleCheckerboard]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:1];
  self.item2 = [[UITabBarItem alloc]
      initWithTitle:kItemTitle2
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:2];
  self.item3 = [[UITabBarItem alloc]
      initWithTitle:kItemTitle3
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleFramedX]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:3];
  self.item3.badgeValue = kItemBadgeValue;
  self.tabBar.items = @[ self.item1, self.item2, self.item3 ];

  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.tabBar = nil;
  self.item1 = nil;
  self.item2 = nil;
  self.item3 = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Theme tests

- (void)testTabBarPrimaryTheme {
  // When
  [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];
  self.tabBar.frame = CGRectMake(0, 0, 250, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarSurfaceVariantTheme {
  // When
  [self.tabBar applySurfaceThemeWithScheme:self.containerScheme];
  self.tabBar.frame = CGRectMake(0, 0, 250, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarPrimaryThemeWithImage {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];
  self.tabBar.frame = CGRectMake(0, 0, 300, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarSurfaceVariantThemeWithImage {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  [self.tabBar applySurfaceThemeWithScheme:self.containerScheme];
  self.tabBar.frame = CGRectMake(0, 0, 300, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

@end
