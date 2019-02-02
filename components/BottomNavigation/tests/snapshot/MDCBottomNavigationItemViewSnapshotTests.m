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
static NSString *const kLongTitleArabic =
    @"دول السيطرة استطاعوا ٣٠. مليون وفرنسا أوراقهم انه تم, نفس قد والديون العالمية. دون ما تنفّس.";

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
}

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.itemView mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)changeToRTLAndArabic {
  if (@available(iOS 9.0, *)) {
    self.itemView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
  self.itemView.title = kLongTitleArabic;
}

#pragma mark - Varied widths

- (void)testNarrowWidthTypicalHeightLongTitleStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleStackedRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testNarrowWidthTypicalHeightLongTitleAdjacentRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthNarrrow, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleStackedRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMinimumWidthTypicalHeightLongTitleAdjacentRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMinimum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleStackedRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTypicalHeightLongTitleAdjacentRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleStackedRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

- (void)testMaximumWidthTypicalHeightLongTitleAdjacentRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthMaximum, kHeightTypical);

  [self generateAndVerifySnapshot];
}

#pragma mark - Varied heights

- (void)testTypicalWidthShortHeightLongTitleStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleStackedRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthShortHeightLongTitleAdjacentRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightShort);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleStackedLTR {
  // When
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleStackedRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = YES;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleAdjacentLTR {
  // When
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

- (void)testTypicalWidthTallHeightLongTitleAdjacentRTL {
  // When
  [self changeToRTLAndArabic];
  self.itemView.titleBelowIcon = NO;
  self.itemView.frame = CGRectMake(0, 0, kWidthTypical, kHeightTall);

  [self generateAndVerifySnapshot];
}

@end
