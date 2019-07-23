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
#import "MDCTabBarViewItemView.h"

/** The typical size of an image in a Tab bar. */
static const CGSize kTypicalImageSize = (CGSize){24, 24};

/** The expected height of titles-only or icons-only Tabs. */
static const CGFloat kExpectedHeightTitlesOrIconsOnly = 48;

/** The expected height of Tabs with titles and icons. */
static const CGFloat kExpectedHeightTitlesAndIcons = 72;

/** The leading inset for scrollable tabs. */
static const CGFloat kLeadingInsetForScrollableTabs = 52;

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

/** Exposing some internal properties to aid in testing. */
@interface MDCTabBarView (SnapshotTesting)
@property(nonnull, nonatomic, copy) NSArray<UIView *> *itemViews;
@end

@interface MDCTabBarViewLayoutStyleSnapshotTests : MDCSnapshotTestCase

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

/**
 Sizes a view to its intrinsic content size with optional extra sizing.

 @param view The view to resize.
 @param extraSize Additional size (positive or negative) to apply to the view's bounds.
 */
- (void)sizeViewToIntrinsicContentSize:(UIView *)view extraSize:(CGSize)extraSize;

@end

@implementation MDCTabBarViewLayoutStyleSnapshotTests

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
  self.tabBarView.items = @[ self.item1, self.item2, self.item3 ];
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

- (void)sizeViewToIntrinsicContentSize:(UIView *)view extraSize:(CGSize)extraSize {
  CGSize intrinsicContentSize = view.intrinsicContentSize;
  view.bounds = CGRectMake(0, 0, intrinsicContentSize.width + extraSize.width,
                           intrinsicContentSize.height + extraSize.height);
}

- (void)activateRippleInView:(MDCTabBarView *)tabBarView forItem:(UITabBarItem *)item {
  NSUInteger indexOfItem = [tabBarView.items indexOfObject:item];
  if (indexOfItem == NSNotFound || indexOfItem >= tabBarView.itemViews.count) {
    NSAssert(NO, @"(%@) has no associated item view.", item);
    return;
  }
  UIView *itemView = tabBarView.itemViews[indexOfItem];
  if (![itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
    return;
  }
  MDCTabBarViewItemView *mdcItemView = (MDCTabBarViewItemView *)itemView;
  [mdcItemView.rippleTouchController.rippleView
      beginRippleTouchDownAtPoint:CGPointMake(CGRectGetMidX(mdcItemView.bounds),
                                              CGRectGetMidY(mdcItemView.bounds))
                         animated:NO
                       completion:nil];
}

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

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  // Needed so that any "scrolling" can take place for the selected item to be visible.
  [self activateRippleInView:self.tabBarView forItem:self.item2];
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Fixed Layout

- (void)testFixedLayoutStyleMixedTitlesFitSizeLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleMixedTitlesFitSizeArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleMixedTitlesTooNarrowSizeLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleMixedTitlesTooNarrowSizeArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleMixedTitlesTooWideSizeLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleMixedTitlesTooWideSizeArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - FixedClusteredCentered Layout

- (void)testFixedClusteredCenteredLayoutStyleFitSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleFitSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooNarrowSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooNarrowSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooWideSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooWideSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - FixedClusteredLeading Layout

- (void)testFixedClusteredLeadingLayoutStyleFitSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleFitSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooNarrowSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooNarrowSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooWideSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooWideSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - FixedClusteredTrailing Layout

- (void)testFixedClusteredTrailingLayoutStyleFitSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleFitSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooNarrowSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooNarrowSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooWideSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooWideSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Scrollable Layout

- (void)testScrollableLayoutStyleFitSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleFitSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooNarrowSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooNarrowSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooWideSizeMixedTitlesLatinLTR {
  // When
  self.item1.title = kItemTitleLong1Latin;
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooWideSizeMixedTitlesArabicRTL {
  // When
  [self changeToArabicStringsWithLongTitles:NO];
  self.item1.title = kItemTitleLong1Arabic;
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

@end
