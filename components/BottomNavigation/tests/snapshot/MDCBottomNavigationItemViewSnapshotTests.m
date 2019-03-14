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

#import "../../src/private/MDCBottomNavigationItemView.h"
#import "MaterialBottomNavigation.h"

static NSString *const kLongTitleLatin =
    @"123456789012345678901234567890123456789012345678901234567890";
static NSString *const kBadgeTitleEmpty = @"";
static NSString *const kBadgeTitleSingleLatin = @"8";
static NSString *const kBadgeTitleMaxLatin = @"888+";
static NSString *const kLongTitleArabic =
    @"دول السيطرة استطاعوا ٣٠. مليون وفرنسا أوراقهم انه تم, نفس قد والديون العالمية. دون ما تنفّس.";
static NSString *const kBadgeTitleSingleArabic = @"أ";
static NSString *const kBadgeTitleMaxArabic = @"أورا";
/** The shortest acceptable height for correct layout. */
static const CGFloat kHeightShort = 48;

/** Typical height for correct layout. */
static const CGFloat kHeightTypical = 56;

/** A height too tall for correct layout. */
static const CGFloat kHeightTall = 120;

/** A width too narrow for correct layout */
static const CGFloat kWidthNarrrow = 40;  // 64 - 12 points on leading/trailing edge

/** The minimum acceptable width for correct layout */
static const CGFloat kWidthMinimum = 56;  // 80 - 12 points on leading/trailing edge

/** The suggested width for correct layout */
static const CGFloat kWidthTypical = 96;  // 120 - 12 points on leading/trailing edge

/** The maximum acceptable width for correct layout */
static const CGFloat kWidthMaximum = 144;  // 168 - 12 points on leading/trailing edge

static const CGFloat kContentHorizontalMargin = 12;

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
  self.itemView.title = kLongTitleLatin;
  self.itemView.contentHorizontalMargin = kContentHorizontalMargin;
  self.itemView.backgroundColor = UIColor.whiteColor;
  self.itemView.badgeValue = kBadgeTitleEmpty;
}

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.itemView mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)changeToRTLAndArabicWithBadgeValue:(NSString *)badgeValue {
  if (@available(iOS 9.0, *)) {
    self.itemView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
  self.itemView.title = kLongTitleArabic;
  self.itemView.badgeValue = badgeValue;
}

#pragma mark - Varied widths

- (void)testNarrowWidthTypicalHeightLongTitleEmptyBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleEmptyBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);
  self.itemView.badgeValue = kBadgeTitleSingleLatin;

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleSingleBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleMaxBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeValue = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleMaxBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleEmptyBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleEmptyBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleSingleBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeValue = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleSingleBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleMaxBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeValue = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleMaxBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleEmptyBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleEmptyBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeValue = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleSingleBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

#pragma mark - Varied heights

- (void)testTypicalWidthShortHeightLongTitleEmptyBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleEmptyBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleSingleBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.badgeValue = kBadgeTitleSingleLatin;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleSingleBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleSingleArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleMaxBadgeStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.badgeValue = kBadgeTitleMaxLatin;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleMaxBadgeStackedRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleMaxArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleEmptyBadgeAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleEmptyBadgeAdjacentRTL {
  // When
  [self changeToRTLAndArabicWithBadgeValue:kBadgeTitleEmpty];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

#pragma mark - UI Changes

- (void)testChangeUnselectedImageWhenNotSelectedWithSelectedImage {
  // Given
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
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
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
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
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
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
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
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
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
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
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
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
