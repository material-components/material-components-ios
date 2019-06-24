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

static const CGFloat kWidthWide = 1600;
static const CGFloat kWidthNarrow = 240;
static const CGFloat kHeightTall = 120;
static const CGFloat kHeightShort = 48;


@interface MDCTabBarViewSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCTabBarView *tabBar;
@end

@implementation MDCTabBarViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  self.recordMode = YES;

  self.tabBar = [[MDCTabBarView alloc] init];

  CGSize imageSize = CGSizeMake(24, 24);
  self.tabBar.items =
  @[ self.tabItem1, self.tabItem2, self.tabItem3, self.tabItem4, self.tabItem5 ];
}


#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests


- (void)testTabBarFixedSize {
  // Given
  MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];
  tabBarView.bounds = CGRectMake(0, 0, 120, 56);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  tabBarView.backgroundColor = UIColor.blueColor;

  // Then
  [self generateSnapshotAndVerifyForView:tabBarView];
}

#pragma mark - Extreme sizes

- (void)testJustifiedUnspecifiedAlwaysFiveItemsNarrowWidthShortHeightLTR {
  // When
  self.tabBar.selectedItem = self.tabItem2;
  self.tabBar.frame = CGRectMake(0, 0, kWidthNarrow, kHeightShort);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsNarrowWidthShortHeightRTL {
  // When
  self.tabBar.selectedItem = self.tabItem2;
  self.tabBar.frame = CGRectMake(0, 0, kWidthNarrow, kHeightShort);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsWideWidthTallHeightLTR {
  // When
  self.tabBar.selectedItem = self.tabItem2;
  self.tabBar.frame = CGRectMake(0, 0, kWidthWide, kHeightTall);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsWideWidthTallHeightRTL {
  // When
  self.tabBar.selectedItem = self.tabItem2;
  self.tabBar.frame = CGRectMake(0, 0, kWidthWide, kHeightTall);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

#pragma mark - Layout Adjustments

//- (void)testTitlePositionAdjustmentJustifiedAdjacentCompactLTR {
//  // Given
//  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
//  [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
//  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;
//  self.tabBar.titleVisibility = MDCBottomtabBarTitleVisibilityAlways;
//  self.tabBar.alignment = MDCBottomtabBarAlignmentJustifiedAdjacentTitles;
//  self.tabBar.selectedItem = self.tabItem2;
//  self.tabBar.traitCollectionOverride = traitCollection;
//  CGSize fitSize = [self.tabBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
//  self.tabBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
//  [self performInkTouchOnBar:self.tabBar item:self.tabItem1];
//
//  // When
//  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
//  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);
//
//  // Then
//  [self generateSnapshotAndVerifyForView:self.tabBar];
//}

//- (void)testTitlePositionAdjustmentJustifiedAdjacentCompactRTL {
//  // Given
//  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
//  [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
//  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;
//  self.tabBar.titleVisibility = MDCBottomtabBarTitleVisibilityAlways;
//  self.tabBar.alignment = MDCBottomtabBarAlignmentJustifiedAdjacentTitles;
//  self.tabBar.selectedItem = self.tabItem2;
//  self.tabBar.traitCollectionOverride = traitCollection;
//  CGSize fitSize = [self.tabBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
//  self.tabBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
//  [self performInkTouchOnBar:self.tabBar item:self.tabItem1];
//  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];
//
//  // When
//  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
//  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);
//
//  // Then
//  [self generateSnapshotAndVerifyForView:self.tabBar];
//}

//- (void)testTitlePositionAdjustmentJustifiedAdjacentRegularLTR {
//  // Given
//  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
//  [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
//  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;
//  self.tabBar.titleVisibility = MDCBottomtabBarTitleVisibilityAlways;
//  self.tabBar.alignment = MDCBottomtabBarAlignmentJustifiedAdjacentTitles;
//  self.tabBar.selectedItem = self.tabItem2;
//  self.tabBar.traitCollectionOverride = traitCollection;
//  CGSize fitSize = [self.tabBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
//  self.tabBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
//  [self performInkTouchOnBar:self.tabBar item:self.tabItem1];
//
//  // When
//  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
//  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);
//
//  // Then
//  [self generateSnapshotAndVerifyForView:self.tabBar];
//}

//- (void)testTitlePositionAdjustmentJustifiedAdjacentRegularRTL {
//  // Given
//  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
//  [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
//  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;
//  self.tabBar.titleVisibility = MDCBottomtabBarTitleVisibilityAlways;
//  self.tabBar.alignment = MDCBottomtabBarAlignmentJustifiedAdjacentTitles;
//  self.tabBar.selectedItem = self.tabItem2;
//  self.tabBar.traitCollectionOverride = traitCollection;
//  CGSize fitSize = [self.tabBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
//  self.tabBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
//  [self performInkTouchOnBar:self.tabBar item:self.tabItem1];
//  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];
//
//  // When
//  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
//  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);
//
//  // Then
//  [self generateSnapshotAndVerifyForView:self.tabBar];
//}



@end
