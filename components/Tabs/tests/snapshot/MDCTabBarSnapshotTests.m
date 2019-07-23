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
@interface MDCTabBarSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCTabBar *tabBar;
@property(nonatomic, strong) UITabBarItem *item1;
@property(nonatomic, strong) UITabBarItem *item2;
@property(nonatomic, strong) UITabBarItem *item3;
@property(nonatomic, strong) UITabBarItem *item4;
@property(nonatomic, strong) UITabBarItem *item5;
@end

@implementation MDCTabBarSnapshotTests

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

#pragma mark - Alignment tests

- (void)testTabBarDefaultItemsFitLatinLTR {
  // When
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarDefaultItemsFitArabicRTL {
  // When
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarJustifiedItemsFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentJustified;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarJustifiedItemsFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentJustified;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterItemsFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenter;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterItemsFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenter;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterSelectedItemsFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterSelectedItemsFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarLeadingItemsFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentLeading;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarLeadingItemsFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentLeading;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

#pragma mark - Long Strings

- (void)testTabBarDefaultItemsDontFitLatinLTR {
  // When
  [self setTitlesToLatinLong];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarDefaultItemsDontFitArabicRTL {
  // When
  [self setTitlesToArabicLong];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarJustifiedItemsDontFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentJustified;
  [self setTitlesToLatinLong];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarJustifiedItemsDontFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentJustified;
  [self setTitlesToArabicLong];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterItemsDontFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenter;
  [self setTitlesToLatinLong];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterItemsDontFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenter;
  [self setTitlesToArabicLong];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterSelectedItemsDontFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;
  [self setTitlesToLatinLong];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarCenterSelectedItemsDontFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;
  [self setTitlesToArabicLong];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarLeadingItemsDontFitLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentLeading;
  [self setTitlesToLatinLong];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarLeadingItemsDontFitArabicRTL {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentLeading;
  [self setTitlesToArabicLong];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

#pragma mark - Style Tests

- (void)testTabBarDefaultAlignmentTitledImagesAppearanceLatinLTR {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarDefaultAlignmentTitledImagesAppearanceArabicRTL {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarDefaultAlignmentImagesAppearanceLatinLTR {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarDefaultAlignmentImagesAppearanceArabicRTL {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  [self setTitlesToArabicShort];
  [self changeLayoutToRTL];
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

- (void)testTabBarItemBadgeColors {
  // When
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  if (@available(iOS 10.0, *)) {
    self.item1.badgeValue = kItemTitleShort3Latin;
    self.item1.badgeColor = UIColor.cyanColor;
    self.item2.badgeValue = kItemTitleShort1Latin;
    self.item2.badgeColor = UIColor.orangeColor;
    self.item3.badgeValue = kItemTitleShort2Latin;
    self.item3.badgeColor = UIColor.blackColor;
    self.item4.badgeValue = kItemTitleShort1Latin;
    self.item4.badgeColor = UIColor.blueColor;
    self.item5.badgeValue = kItemTitleShort3Latin;
    self.item5.badgeColor = UIColor.whiteColor;
  }
  self.tabBar.frame = CGRectMake(0, 0, 480, 100);
  [self.tabBar sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.tabBar];
}

@end
