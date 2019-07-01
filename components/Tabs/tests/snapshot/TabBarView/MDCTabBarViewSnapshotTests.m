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

/** The typical size of an image in a Tab bar. */
static const CGSize kTypicalImageSize = (CGSize){24, 24};

/** The expected height of titles-only or icons-only Tabs. */
static const CGFloat kExpectedHeightTitlesOrIconsOnly = 48;

/** The expected height of Tabs with titles and icons. */
static const CGFloat kExpectedHeightTitlesAndIcons = 72;

/** The minimum width of a tab bar item. */
static const CGFloat kMinItemWidth = 90;

/** The maximum width of a tab bar item. */
static const CGFloat kMaxItemWidth = 360;

/** A test class that allows setting safe area insets. */
@interface MDCTabBarViewSnapshotTestsSuperview : UIView
/** Allows overriding the safe area insets. */
@property(nonatomic, assign) UIEdgeInsets customSafeAreaInsets;
@end

@implementation MDCTabBarViewSnapshotTestsSuperview

- (void)setCustomSafeAreaInsets:(UIEdgeInsets)customSafeAreaInsets {
  _customSafeAreaInsets = customSafeAreaInsets;
  if (@available(iOS 11.0, *)) {
    [self safeAreaInsetsDidChange];
  }
}

- (UIEdgeInsets)safeAreaInsets {
  return _customSafeAreaInsets;
}

@end

@interface MDCTabBarViewSnapshotTests : MDCSnapshotTestCase

/** The view being snapshotted. */
@property(nonatomic, strong) MDCTabBarView *tabBarView;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon1;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon2;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon3;

@end

@implementation MDCTabBarViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.tabBarView = [[MDCTabBarView alloc] init];
  self.tabBarView.barTintColor = UIColor.whiteColor;
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesOrIconsOnly);

  self.typicalIcon1 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.typicalIcon2 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleDiagonalLines]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.typicalIcon3 = [[UIImage mdc_testImageOfSize:kTypicalImageSize
                                          withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)tearDown {
  self.typicalIcon1 = nil;
  self.typicalIcon2 = nil;
  self.typicalIcon3 = nil;
  self.tabBarView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  // Needed so that the stack view can be constrained correctly and then allow any "scrolling" to
  // take place for the selected item to be visible.
  [self.tabBarView layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - UITabBarItem properties

- (void)testItemsWithOnlyTitles {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyImages {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon3 tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithTitlesAndImages {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithMixedTitlesAndImages {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:nil image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Selection

- (void)testChangingSelectedItemIgnoresSelectedImage {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  item1.selectedImage = self.typicalIcon2;
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setSelectedItem:item1 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSelectedItemInitiallyVisible {
  // Given
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (CGFloat)1.5, kExpectedHeightTitlesOrIconsOnly);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Four" image:nil tag:3];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"Five" image:nil tag:4];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"Six" image:nil tag:5];
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];

  // When
  [self.tabBarView setSelectedItem:item5 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Key-Value Observing (KVO)

- (void)testChangingTitleAfterAddingToBar {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item2.title = @"2";

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingImageOfUnselectedItemAfterAddingToBar {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item1.image = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingImageOfSelectedItemAfterAddingToBar {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item2.image = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingSelectedImageOfUnselectedItemAfterAddingToBarDoesNothing {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item1.selectedImage = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingSelectedImageOfSelectedItemAfterAddingToBarDoesNothing {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon1 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon1 tag:5];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  item2.selectedImage = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Layout Sizes

// TODO(https://github.com/material-components/material-components-ios/issues/7717): This golden
// is incorrect due to a suspected bug in MDCTabBarViewItemView.
- (void)testSettingBoundsTooNarrowWithItemsLessThanMinimumWidthResultsInScrollableLayout {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Four" image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"Five" image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"Six" image:nil tag:8];

  // When
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSettingBoundsToIntrinsicContentSizeResultsInJustifiedLayout {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Four" image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"Five" image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"Six" image:nil tag:8];

  // When
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsLargerThanBoundsChangesToScrollableLayout {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (self.tabBarView.items.count - (CGFloat)0.5),
                 kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testVeryLongItemLimitsItemWidthToItemMaximumWhenBoundsTooNarrow {
  // Given
  NSString *longString = @"This is a super long tab bar string. And it should be longer than 360 "
                         @"and wrap to multiple lines.";
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:longString image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  self.tabBarView.bounds = CGRectMake(0, 0, kMaxItemWidth * self.tabBarView.items.count / 2,
                                      kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testVeryLongItemLimitsItemWidthToItemMaximumWhenBoundsAreIntrinsicContentSize {
  // Given
  NSString *longString = @"This is a super long tab bar string. And it should be longer than 360 "
                         @"and wrap to multiple lines.";
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:longString image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:nil tag:5];

  // When
  self.tabBarView.items = @[ item1, item2, item3 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds =
      CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testLayoutBehaviorWhenBoundsExceedsMaximumWidthForNumberOfItems {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];

  // When
  self.tabBarView.items = @[ item1, item2 ];
  self.tabBarView.bounds = CGRectMake(0, 0, kMaxItemWidth * (self.tabBarView.items.count + 1),
                                      kExpectedHeightTitlesOrIconsOnly);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testLayoutBehaviorWhenBoundsExceedsIntrinsicContentSizeAndRemainsLessThanMaximum {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];

  // When
  self.tabBarView.items = @[ item1, item2 ];
  CGSize intrinsicContentSize = self.tabBarView.intrinsicContentSize;
  self.tabBarView.bounds = CGRectMake(
      0, 0, MIN(kMaxItemWidth * self.tabBarView.items.count, intrinsicContentSize.width * 2),
      intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Safe Area Support

- (void)testSafeAreaTopAndLeftInsetsForJustifiedLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(16, 44, 0, 0);
  [self.tabBarView sizeToFit];
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaRightAndBottomInsetsForJustifiedLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(0, 0, 16, 44);
  [self.tabBarView sizeToFit];
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaTopAndLeftInsetsForScrollableLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(16, 44, 0, 0);
  self.tabBarView.bounds = CGRectMake(0, 0, kMinItemWidth * 2.5, kExpectedHeightTitlesOrIconsOnly);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaRightAndBottomInsetsForScrollableLayoutStyle {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"4" image:nil tag:3];
  MDCTabBarViewSnapshotTestsSuperview *superview =
      [[MDCTabBarViewSnapshotTestsSuperview alloc] init];
  [superview addSubview:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4 ];
  [self.tabBarView setSelectedItem:item4 animated:NO];

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(0, 0, 16, 44);
  self.tabBarView.bounds = CGRectMake(0, 0, kMinItemWidth * 2.5, kExpectedHeightTitlesOrIconsOnly);
  superview.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.bounds),
                                CGRectGetHeight(self.tabBarView.bounds));
  self.tabBarView.center =
      CGPointMake(CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds));

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

#pragma mark - MDCTabBarView Properties

- (void)testSetTitleColorForExplicitItemStates {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleColorForNormalStateAppliesToSelectedItem {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  ;

  // When
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleColorExplicitlyToNilRendersSomeDefault {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleColor:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:nil forState:UIControlStateSelected];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetImageTintColorForExplicitItemStates {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setImageTintColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetImageTintColorForNormalStateAppliesToSelectedItem {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setImageTintColor:UIColor.purpleColor forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetImageTintColorExplicitlyToNilUsesTintColor {
  // Given
  self.tabBarView.tintColor = UIColor.orangeColor;
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleFontForExplicitItemStates {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:24] forState:UIControlStateSelected];
  [self.tabBarView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleFontForNormalStateAppliesToSelectedItem {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];

  // When
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSetTitleFontExplicitlyToNilUsesDefaultFont {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:8] forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:[UIFont systemFontOfSize:24] forState:UIControlStateSelected];

  // When
  [self.tabBarView setTitleFont:nil forState:UIControlStateNormal];
  [self.tabBarView setTitleFont:nil forState:UIControlStateSelected];
  [self.tabBarView sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testChangingSelectionUpdatesItemStyle {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  [self.tabBarView setSelectedItem:item2 animated:NO];
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:UIColor.redColor forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setImageTintColor:UIColor.blueColor forState:UIControlStateSelected];

  // When
  [self.tabBarView setSelectedItem:item3 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testBarTintColor {
  // When
  self.tabBarView.barTintColor = UIColor.purpleColor;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}
@end
