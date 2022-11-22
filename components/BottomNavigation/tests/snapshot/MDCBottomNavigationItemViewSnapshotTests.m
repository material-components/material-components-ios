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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCBottomNavigationItemView.h"
#import "MDCSnapshotTestCase.h"
#import "UIImage+MDCSnapshot.h"
#import "UIView+MDCSnapshot.h"
#pragma clang diagnostic pop
#import "supplemental/MDCBottomNavigationSnapshotTestUtilities.h"
#import "MDCBottomNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kBadgeTitleEmpty = @"";
static NSString *const kBadgeTitleSingleLatin = @"8";
static NSString *const kBadgeTitleMaxLatin = @"888+";
static NSString *const kBadgeTitleSingleArabic = @"أ";
static NSString *const kBadgeTitleMaxArabic = @"أورا";

/** The shortest acceptable height for correct layout. */
static const CGFloat kItemViewHeightShort = 48;

/** Typical height for correct layout. */
static const CGFloat kItemViewHeightTypical = 56;

/** A height too tall for correct layout. */
static const CGFloat kItemViewHeightTall = 120;

/** A width too narrow for correct layout */
static const CGFloat kItemViewWidthNarrrow = 40;  // 64 - 12 points on leading/trailing edge

/** The minimum acceptable width for correct layout */
static const CGFloat kItemViewWidthMinimum = 56;  // 80 - 12 points on leading/trailing edge

/** The suggested width for correct layout */
static const CGFloat kItemViewWidthTypical = 96;  // 120 - 12 points on leading/trailing edge

/** The maximum acceptable width for correct layout */
static const CGFloat kItemViewWidthMaximum = 144;  // 168 - 12 points on leading/trailing edge

static const CGFloat kItemViewContentHorizontalMargin = 12;

@interface MDCBottomNavigationItemViewSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCBottomNavigationItemView *itemView;
@end

@implementation MDCBottomNavigationItemViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.itemView = [[MDCBottomNavigationItemView alloc] init];
  self.itemView.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.itemView.image = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)];
  self.itemView.title = MDCBottomNavigationTestLongTitleLatin;
  self.itemView.contentHorizontalMargin = kItemViewContentHorizontalMargin;
  self.itemView.backgroundColor = UIColor.whiteColor;
  self.itemView.badgeText = kBadgeTitleEmpty;
}

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.itemView mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)changeToRTLAndArabicWithBadgeText:(NSString *)badgeText {
  static UIFont *urduFont;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    urduFont = [UIFont fontWithName:@"NotoNastaliqUrdu" size:12];
  });
  self.itemView.itemTitleFont = urduFont;
  self.itemView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  self.itemView.title = MDCBottomNavigationTestLongTitleArabic;
  self.itemView.badgeText = badgeText;
}

#pragma mark - Varied widths

- (void)testNarrowWidthTypicalHeightLongTitleEmptyBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleEmptyBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightFitTitleManyLinesEmptyBadgeStackedLTR {
  // When
  self.itemView.titleNumberOfLines = 0;
  self.itemView.titleBelowIcon = YES;
  self.itemView.title = [MDCBottomNavigationTestLongTitleLatin substringToIndex:10];
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightFitTitleManyLinesEmptyBadgeStackedRTL {
  // When
  self.itemView.titleNumberOfLines = 0;
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.title = [MDCBottomNavigationTestLongTitleArabic substringToIndex:10];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleManyLinesEmptyBadgeStackedLTR {
  // When
  self.itemView.titleNumberOfLines = 0;
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleManyLinesEmptyBadgeStackedRTL {
  // When
  self.itemView.titleNumberOfLines = 0;
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);
  self.itemView.badgeText = kBadgeTitleSingleLatin;

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleSingleBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleManyLinesSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleNumberOfLines = 0;
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);
  self.itemView.badgeText = kBadgeTitleSingleLatin;

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleManyLinesSingleBadgeAdjacentRTL {
  // When
  self.itemView.titleNumberOfLines = 0;
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthNarrrow, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleMaxBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeText = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMinimum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleMaxBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMinimum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleEmptyBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMinimum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleEmptyBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMinimum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleSingleBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeText = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleSingleBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleManyLinesSingleBadgeStackedLTR {
  // When
  self.itemView.titleNumberOfLines = 0;
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeText = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleManyLinesSingleBadgeStackedRTL {
  // When
  self.itemView.titleNumberOfLines = 0;
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleMaxBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeText = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleMaxBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleManyLinesMaxBadgeAdjacentLTR {
  // When
  self.itemView.titleNumberOfLines = 0;
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeText = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleManyLinesMaxBadgeAdjacentRTL {
  // When
  self.itemView.titleNumberOfLines = 0;
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleEmptyBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMaximum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleEmptyBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMaximum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeText = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMaximum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleSingleBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthMaximum, kItemViewHeightTypical);

  [self generateAndVerifySnapshot];
}

#pragma mark - Varied heights

- (void)testTypicalWidthShortHeightLongTitleEmptyBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleEmptyBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeText = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleSingleBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleMaxBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeText = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleMaxBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleEmptyBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleEmptyBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeText:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTall);

  [self generateAndVerifySnapshot];
}

#pragma mark - UI Changes

- (void)testChangeUnselectedImageWhenNotSelectedWithSelectedImage {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);
  self.itemView.selected = NO;
  self.itemView.selectedImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                    withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.itemView.selectedItemTintColor = UIColor.orangeColor;
  self.itemView.unselectedItemTintColor = UIColor.blackColor;

  // When
  self.itemView.image = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeUnselectedImageWhenNotSelectedWithoutSelectedImage {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);
  self.itemView.selected = NO;
  self.itemView.selectedImage = nil;
  self.itemView.selectedItemTintColor = UIColor.orangeColor;
  self.itemView.unselectedItemTintColor = UIColor.blackColor;

  // When
  self.itemView.image = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                            withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeUnselectedImageWhenSelectedWithSelectedImage {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);
  self.itemView.selected = YES;
  self.itemView.selectedImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                    withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.itemView.selectedItemTintColor = UIColor.orangeColor;
  self.itemView.unselectedItemTintColor = UIColor.blackColor;

  // When
  self.itemView.image = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                            withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeUnselectedImageWhenSelectedWithoutSelectedImage {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);
  self.itemView.selected = YES;
  self.itemView.selectedImage = nil;
  self.itemView.selectedItemTintColor = UIColor.orangeColor;
  self.itemView.unselectedItemTintColor = UIColor.blackColor;

  // When
  self.itemView.image = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                            withStyle:MDCSnapshotTestImageStyleFramedX]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeSelectedImageWhenNotSelected {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);
  self.itemView.selected = NO;
  self.itemView.selectedItemTintColor = UIColor.orangeColor;
  self.itemView.unselectedItemTintColor = UIColor.blackColor;

  // When
  self.itemView.selectedImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                    withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeSelectedImageWhenSelected {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kItemViewWidthTypical, kItemViewHeightTypical);
  self.itemView.selected = YES;
  self.itemView.selectedItemTintColor = UIColor.orangeColor;
  self.itemView.unselectedItemTintColor = UIColor.blackColor;

  // When
  self.itemView.selectedImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                                    withStyle:MDCSnapshotTestImageStyleEllipses]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

@end

NS_ASSUME_NONNULL_END
