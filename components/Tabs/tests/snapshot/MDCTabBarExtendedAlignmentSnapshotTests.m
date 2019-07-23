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

#import "MDCTabBarExtendedAlignment.h"
#import "MaterialTabs+Theming.h"
#import "MaterialTabs.h"

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

/** Snapshot tests for MDCTabBar rendering .*/
@interface MDCTabBarExtendedAlignmentSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCTabBar *tabBar;
@property(nonatomic, strong) UITabBarItem *item1;
@property(nonatomic, strong) UITabBarItem *item2;
@property(nonatomic, strong) UITabBarItem *item3;
@property(nonatomic, strong) UITabBarItem *item4;
@property(nonatomic, strong) UITabBarItem *item5;
@end

@implementation MDCTabBarExtendedAlignmentSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  CGSize imageSize = CGSizeMake(24, 24);
  self.tabBar = [[MDCTabBar alloc] init];
  self.item1 = [[UITabBarItem alloc]
      initWithTitle:kItemTitleShort1Latin
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleCheckerboard]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:1];
  self.item2 = [[UITabBarItem alloc]
      initWithTitle:kItemTitleShort2Latin
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:2];
  self.item3 = [[UITabBarItem alloc]
      initWithTitle:kItemTitleShort3Latin
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleFramedX]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:3];
  self.item3.badgeValue = kItemTitleShort1Latin;
  self.item4 = [[UITabBarItem alloc]
      initWithTitle:kItemTitleShort1Latin
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleEllipses]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:4];
  self.item5 = [[UITabBarItem alloc]
      initWithTitle:kItemTitleShort2Latin
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleRectangles]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:5];
  self.tabBar.items = @[ self.item1, self.item2, self.item3, self.item4, self.item5 ];
  self.tabBar.alignment = (MDCTabBarAlignment)MDCTabBarExtendedAlignmentBestEffortJustified;
  self.tabBar.selectedItem = self.item2;
  [self.tabBar applyPrimaryThemeWithScheme:[[MDCContainerScheme alloc] init]];
}

- (void)tearDown {
  self.tabBar = nil;
  self.item1 = nil;
  self.item2 = nil;
  self.item3 = nil;
  self.item4 = nil;
  self.item5 = nil;

  [super tearDown];
}

- (void)changeLayoutToRTL {
  [self changeViewToRTL:self.tabBar];
}

- (void)setTitlesToLatinLong {
  self.item1.title = kItemTitleLong1Latin;
  self.item2.title = kItemTitleLong2Latin;
  self.item3.title = kItemTitleLong3Latin;
  self.item3.badgeValue = kItemTitleLong1Latin;
  self.item4.title = kItemTitleLong1Latin;
  self.item5.title = kItemTitleLong2Latin;
}

- (void)setTitlesToArabicShort {
  self.item1.title = kItemTitleShort1Arabic;
  self.item2.title = kItemTitleShort2Arabic;
  self.item3.title = kItemTitleShort3Arabic;
  self.item3.badgeValue = kItemTitleShort1Arabic;
  self.item4.title = kItemTitleShort1Arabic;
  self.item5.title = kItemTitleShort2Arabic;
}

- (void)setTitlesToArabicLong {
  self.item1.title = kItemTitleLong1Arabic;
  self.item2.title = kItemTitleLong2Arabic;
  self.item3.title = kItemTitleLong3Arabic;
  self.item3.badgeValue = kItemTitleLong1Arabic;
  self.item4.title = kItemTitleLong1Arabic;
  self.item5.title = kItemTitleLong2Arabic;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Static alignment tests

- (void)testTabBarTitlesOnlyFitLatinLTR {
  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitlesOnlyFitArabicRTL {
  // When
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitlesOnlyDontFitLatinLTR {
  // When
  [self setTitlesToLatinLong];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitlesOnlyDontFitArabicRTL {
  // When
  [self setTitlesToArabicLong];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesAppearanceFitLatinLTR {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesAppearanceFitArabicRTL {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesAppearanceDontFitLatinLTR {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.frame = CGRectMake(0, 0, 200, 100);
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesAppearanceDontFitArabicRTL {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 200, 100);
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesAppearanceFitLatinLTR {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesAppearanceFitArabicRTL {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesAppearanceDontFitLatinLTR {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesAppearanceDontFitArabicRTL {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

#pragma mark - Reactive alignment tests

- (void)testTabBarTitlesOnlyWhenSizeChangesToNotFitLatinLTR {
  // Given
  self.tabBar.selectedItem = self.item1;  // Make it easier to see Leading alignment
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 200, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitlesOnlyWhenSizeChangesToNotFitArabicRTL {
  // Given
  self.tabBar.selectedItem = self.item1;  // Make it easier to see Leading alignment
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 200, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitlesOnlyWhenSizeChangesToFitLatinLTR {
  // Given
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitlesOnlyWhenSizeChangesToFitArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesOnlyWhenSizeChangesToNotFitLatinLTR {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  self.tabBar.selectedItem = self.item1;  // Make it easier to see Leading alignment
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 200, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesOnlyWhenSizeChangesToNotFitArabicRTL {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  self.tabBar.selectedItem = self.item1;  // Make it easier to see Leading alignment
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 200, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesOnlyWhenSizeChangesToFitLatinLTR {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarImagesOnlyWhenSizeChangesToFitArabicRTL {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesWhenSizeChangesToNotFitLatinLTR {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.selectedItem = self.item1;  // Make it easier to see Leading alignment
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 200, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesWhenSizeChangesToNotFitArabicRTL {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.selectedItem = self.item1;  // Make it easier to see Leading alignment
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 200, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesWhenSizeChangesToFitLatinLTR {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarTitledImagesWhenSizeChangesToFitArabicRTL {
  // Given
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 100, 100);
  [self.tabBar sizeToFit];
  [self.tabBar layoutIfNeeded];

  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, CGRectGetHeight(self.tabBar.bounds));
  [self.tabBar layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

@end
