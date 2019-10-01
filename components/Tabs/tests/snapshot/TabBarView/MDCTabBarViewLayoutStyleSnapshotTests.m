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

#import "../../../src/TabBarView/private/MDCTabBarViewItemView.h"
#import "MDCTabBarView.h"

/** The typical size of an image in a Tab bar. */
static const CGSize kTypicalImageSize = (CGSize){24, 24};

/** The expected height of titles-only or icons-only Tabs. */
static const CGFloat kExpectedHeightTitlesOrIconsOnly = 48;

static NSString *const kItemTitleShort1Latin = @"No";
static NSString *const kItemTitleShort2Latin = @"Facer";

static NSString *const kItemTitleLong1Latin =
    @"Quando volumus maluisset cum ei, ad zril quodsi cum.";

static NSString *const kItemTitleShort1Arabic = @"عل";
static NSString *const kItemTitleShort2Arabic = @"قد";

static NSString *const kItemTitleLong1Arabic =
    @"عل أخذ استطاعوا الانجليزية. قد وحتّى بزمام التبرعات مكن.";

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

  self.item1 = [[UITabBarItem alloc] initWithTitle:kItemTitleLong1Latin
                                             image:self.typicalIcon1
                                               tag:0];
  self.item2 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort1Latin
                                             image:self.typicalIcon2
                                               tag:1];
  self.item3 = [[UITabBarItem alloc] initWithTitle:kItemTitleShort2Latin
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

- (void)changeToArabicStrings {
  self.item1.title = kItemTitleLong1Arabic;
  self.item2.title = kItemTitleShort1Arabic;
  self.item3.title = kItemTitleShort2Arabic;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  // Needed so that any "scrolling" can take place for the selected item to be visible.
  [self activateRippleInView:self.tabBarView forItem:self.item2];
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Fixed Layout

- (void)testFixedLayoutStyleFitSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleFitSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleTooNarrowSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleTooNarrowSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleTooWideSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutStyleTooWideSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutContentPaddingLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixed];

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedLayoutContentPaddingArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixed];

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - FixedClusteredCentered Layout

- (void)testFixedClusteredCenteredLayoutStyleFitSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleFitSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooNarrowSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooNarrowSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooWideSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutStyleTooWideSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutContentPaddingLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredCentered];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredCenteredLayoutContentPaddingArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredCentered];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - FixedClusteredLeading Layout

- (void)testFixedClusteredLeadingLayoutStyleFitSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleFitSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooNarrowSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooNarrowSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooWideSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutStyleTooWideSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutContentPaddingLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredLeading];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredLeadingLayoutContentPaddingArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredLeading];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - FixedClusteredTrailing Layout

- (void)testFixedClusteredTrailingLayoutStyleFitSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleFitSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooNarrowSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooNarrowSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooWideSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutStyleTooWideSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutContentPaddingLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredTrailing];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testFixedClusteredTrailingLayoutContentPaddingArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleFixedClusteredTrailing];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

#pragma mark - Scrollable Layout

- (void)testScrollableLayoutStyleFitSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleFitSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeZero];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooNarrowSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooNarrowSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(-100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooWideSizeLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutStyleTooWideSizeArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;

  // Then
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutContentPaddingLatinLTR {
  // When
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 30)
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

- (void)testScrollableLayoutContentPaddingArabicRTL {
  // When
  [self changeToArabicStrings];
  [self changeViewToRTL:self.tabBarView];
  self.tabBarView.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;
  [self.tabBarView setContentPadding:UIEdgeInsetsMake(10, 20, 40, 20)
                      forLayoutStyle:MDCTabBarViewLayoutStyleScrollable];

  // Then
  // Add padding to make the layout clearer in the snapshots.
  [self sizeViewToIntrinsicContentSize:self.tabBarView extraSize:CGSizeMake(100, 0)];
  [self generateSnapshotAndVerifyForView:self.tabBarView];
}

@end
