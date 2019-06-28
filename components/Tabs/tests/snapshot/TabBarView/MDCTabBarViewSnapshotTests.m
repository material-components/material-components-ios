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

static NSString *const kItemTitleShort1Latin = @"Quando";
static NSString *const kItemTitleShort2Latin = @"No";
static NSString *const kItemTitleShort3Latin = @"Facer";

static NSString *const kItemTitleLong1Latin =
    @"Quando volumus maluisset cum ei, ad zril quodsi cum.";
static NSString *const kItemTitleLong2Latin = @"No quis modo nam, sea ea dicit tollit.";
static NSString *const kItemTitleLong3Latin =
    @"Facer maluisset torquatos ad has, ad vix audiam assueverit mediocritatem.";

static NSString *const kItemTitleShort1Arabic = @"عل";
static NSString *const kItemTitleShort2Arabic = @"قد";
static NSString *const kItemTitleShort3Arabic = @"وتم";

static NSString *const kItemTitleLong1Arabic =
    @"عل أخذ استطاعوا الانجليزية. قد وحتّى بزمام التبرعات مكن.";
static NSString *const kItemTitleLong2Arabic =
    @"وتم عل والقرى إتفاقية, عن هذا وباءت الغالي وفرنسا.";
static NSString *const kItemTitleLong3Arabic = @"تحت أي قدما وإقامة. ودول بشرية اليابانية لان ما.";

@interface MDCTabBarViewSnapshotTests : MDCSnapshotTestCase

/** The view being snapshotted. */
@property(nonatomic, strong) MDCTabBarView *tabBarView;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon1;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon2;

/** A typically-sized icon image. */
@property(nonatomic, strong) UIImage *typicalIcon3;

/** A tab bar item with a title and image. */
@property(nonatomic, strong) UITabBarItem *item1;

/** A tab bar item with a title and image. */
@property(nonatomic, strong) UITabBarItem *item2;

/** A tab bar item with a title and image. */
@property(nonatomic, strong) UITabBarItem *item3;

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

  self.item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Latin
                                             image:self.typicalIcon1
                                               tag:0];
  self.item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Latin
                                             image:self.typicalIcon2
                                               tag:1];
  self.item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Latin
                                             image:self.typicalIcon3
                                               tag:2];
}

- (void)tearDown {
  self.item1 = nil;
  self.item2 = nil;
  self.item3 = nil;
  self.typicalIcon1 = nil;
  self.typicalIcon2 = nil;
  self.typicalIcon3 = nil;
  self.tabBarView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)changeToLatinStringsWithLongTitles:(BOOL)useLongTitles {
  if (useLongTitles) {
    self.item1.title = kItemTitleLong1Latin;
    self.item2.title = kItemTitleLong2Latin;
    self.item3.title = kItemTitleLong3Latin;
  } else {
    self.item1.title = kItemTitleShort1Latin;
    self.item2.title = kItemTitleShort2Latin;
    self.item3.title = kItemTitleShort3Latin;
  }
}

- (void)changeToArabicStringsWithLongTitles:(BOOL)useLongTitles {
  if (useLongTitles) {
    self.item1.title = kItemTitleLong1Arabic;
    self.item2.title = kItemTitleLong2Arabic;
    self.item3.title = kItemTitleLong3Arabic;
  } else {
    self.item1.title = kItemTitleShort1Arabic;
    self.item2.title = kItemTitleShort2Arabic;
    self.item3.title = kItemTitleShort3Arabic;
  }
}

- (void)changeViewToRTL:(UIView *)view {
  for (UIView *subview in view.subviews) {
    if ([view isKindOfClass:[UIImageView class]]) {
      continue;
    }
    [self changeViewToRTL:subview];
  }
  view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - UITabBarItem properties

- (void)testItemsWithOnlyTitlesLTRLatin {
  // Given
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyTitlesRTLArabic {
  // Given
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;

  // When
  [self changeToArabicStringsWithLongTitles:NO];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyImagesLTR {
  // Given
  self.item1.title = nil;
  self.item2.title = nil;
  self.item3.title = nil;

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithOnlyImagesRTL {
  // Given
  self.item1.title = nil;
  self.item2.title = nil;
  self.item3.title = nil;

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithTitlesAndImagesLTRLatin {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithTitlesAndImagesRTLArabic {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);

  // When
  [self changeToArabicStringsWithLongTitles:NO];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithMixedTitlesAndImagesLTRLatin {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  self.item1.image = nil;
  self.item2.title = nil;

  // When
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testItemsWithMixedTitlesAndImagesRTLArabic {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.image = nil;
  self.item2.title = nil;

  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Selection

- (void)testChangingSelectedItemIgnoresSelectedImage {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  self.item1.image = self.typicalIcon1;
  self.item1.selectedImage = self.typicalIcon2;
  self.item2.image = self.typicalIcon2;
  self.item3.image = self.typicalIcon1;
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
  self.tabBarView.selectedItem = self.item2;

  // When
  self.tabBarView.selectedItem = self.item1;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSelectedItemInitiallyVisibleLTRLatin {
  // Given
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (CGFloat)1.5, kExpectedHeightTitlesOrIconsOnly);
  [self changeToLatinStringsWithLongTitles:YES];
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];

  // When
  self.tabBarView.selectedItem = self.item3;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSelectedItemInitiallyVisibleRTLArabic {
  // Given
  self.tabBarView.bounds =
      CGRectMake(0, 0, kMinItemWidth * (CGFloat)1.5, kExpectedHeightTitlesOrIconsOnly);
  [self changeToArabicStringsWithLongTitles:YES];
  self.item1.image = nil;
  self.item2.image = nil;
  self.item3.image = nil;
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.selectedItem = self.item3;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

  // When
  item2.selectedImage = self.typicalIcon2;

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSettingBoundsTooNarrowWithItemsLessThanMinimumWidthResultsInScrollableLayoutLTRLatin {
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

- (void)testSettingBoundsTooNarrowWithItemsLessThanMinimumWidthResultsInScrollableLayoutRTLArabic {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Arabic image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Arabic image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Arabic image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Arabic image:nil tag:8];

  // When
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.items = @[ item1, item2, item3, item4, item5, item6 ];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testSettingBoundsToIntrinsicContentSizeResultsInJustifiedLayoutLTRLatin {
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

- (void)testSettingBoundsToIntrinsicContentSizeResultsInJustifiedLayoutRTLArabic {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Arabic image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Arabic image:nil tag:5];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Arabic image:nil tag:6];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Arabic image:nil tag:7];
  UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort3Arabic image:nil tag:8];

  // When
  [self changeViewToRTL:self.tabBarView];
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

#pragma mark - MDCTabBarView Properties

- (void)testSetTitleColorForExplicitItemStates {
  // Given
  self.tabBarView.bounds = CGRectMake(0, 0, 360, kExpectedHeightTitlesAndIcons);
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"One" image:self.typicalIcon1 tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Two" image:self.typicalIcon2 tag:2];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Three" image:self.typicalIcon3 tag:3];
  self.tabBarView.items = @[ item1, item2, item3 ];
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

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
  self.tabBarView.selectedItem = item2;

  // When
  [self.tabBarView setImageTintColor:nil forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:nil forState:UIControlStateSelected];

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
  self.tabBarView.selectedItem = item2;
  [self.tabBarView setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
  [self.tabBarView setImageTintColor:UIColor.redColor forState:UIControlStateNormal];
  [self.tabBarView setTitleColor:UIColor.brownColor forState:UIControlStateSelected];
  [self.tabBarView setImageTintColor:UIColor.blueColor forState:UIControlStateSelected];

  // When
  self.tabBarView.selectedItem = item3;

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
