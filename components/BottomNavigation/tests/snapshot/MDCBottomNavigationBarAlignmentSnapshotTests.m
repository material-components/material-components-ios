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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "../../src/private/MDCBottomNavigationItemView.h"

#import "MaterialBottomNavigation+ColorThemer.h"
#import "MaterialBottomNavigation+TypographyThemer.h"
#import "MaterialBottomNavigation.h"
#import "MaterialInk.h"
#import "MaterialSnapshot.h"
#import "supplemental/MDCBottomNavigationSnapshotTestMutableTraitCollection.h"
#import "supplemental/MDCFakeBottomNavigationBar.h"

static const CGFloat kWidthWide = 1600;
static const CGFloat kHeightTall = 120;
static NSString *const kLongTitleLatin =
    @"123456789012345678901234567890123456789012345678901234567890";
static NSString *const kLongTitleArabic =
    @"دول السيطرة استطاعوا ٣٠. مليون وفرنسا أوراقهم انه تم, نفس قد والديون العالمية. دون ما تنفّس.";
static NSString *const kShortTitleArabic = @"ما تنفّس.";
static NSString *const kBadgeTitleLatin = @"888+";
static NSString *const kBadgeTitleArabic = @"أورا";

/** Snapshot tests for MDCBottomNavigationBar's @c alignment property. */
@interface MDCBottomNavigationBarAlignmentSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCFakeBottomNavigationBar *navigationBar;
@property(nonatomic, strong) UITabBarItem *tabItem1;
@property(nonatomic, strong) UITabBarItem *tabItem2;
@property(nonatomic, strong) UITabBarItem *tabItem3;
@property(nonatomic, strong) UITabBarItem *tabItem4;
@property(nonatomic, strong) UITabBarItem *tabItem5;
@property(nonatomic, strong) UIImage *testImage;
@end

@implementation MDCBottomNavigationBarAlignmentSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navigationBar = [[MDCFakeBottomNavigationBar alloc] init];

  self.testImage = [UIImage mdc_testImageOfSize:CGSizeMake(24, 24)];
  self.tabItem1 = [[UITabBarItem alloc] initWithTitle:@"Item 1" image:self.testImage tag:1];
  self.tabItem2 = [[UITabBarItem alloc] initWithTitle:@"Item 2" image:self.testImage tag:2];
  self.tabItem2.badgeValue = kBadgeTitleLatin;
  self.tabItem3 = [[UITabBarItem alloc] initWithTitle:@"Item 3" image:self.testImage tag:3];
  self.tabItem4 = [[UITabBarItem alloc] initWithTitle:@"Item 4" image:self.testImage tag:4];
  self.tabItem5 = [[UITabBarItem alloc] initWithTitle:@"Item 5" image:self.testImage tag:5];
  self.navigationBar.items =
      @[ self.tabItem1, self.tabItem2, self.tabItem3, self.tabItem4, self.tabItem5 ];

  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
}

#pragma mark - Helpers

- (void)generateAndVerifySnapshot {
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  UIView *backgroundView = [self.navigationBar mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)performInkTouchOnBar:(MDCBottomNavigationBar *)navigationBar item:(UITabBarItem *)item {
  [navigationBar layoutIfNeeded];
  MDCBottomNavigationItemView *itemView =
      (MDCBottomNavigationItemView *)[navigationBar viewForItem:item];
  [itemView.inkView startTouchBeganAtPoint:CGPointMake(CGRectGetMidX(itemView.bounds),
                                                       CGRectGetMidY(itemView.bounds))
                                  animated:NO
                            withCompletion:nil];
}

- (void)changeToRTLAndArabicWithTitle:(NSString *)title {
  if (@available(iOS 9.0, *)) {
    self.navigationBar.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
  for (UITabBarItem *item in self.navigationBar.items) {
    item.title = title;
    if (@available(iOS 9.0, *)) {
      UIView *view = [self.navigationBar viewForItem:item];
      view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    }
  }
  if (self.navigationBar.items.count >= 2U) {
    self.navigationBar.items[1].badgeValue = kBadgeTitleArabic;
  } else {
    self.navigationBar.items.firstObject.badgeValue = kBadgeTitleArabic;
  }
}

#pragma mark - Alignment .Justified

- (void)testJustifiedAlignmentWithUnspecifiedHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithUnspecifiedHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;

  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithCompactHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithCompactHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithRegularHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithRegularHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .JustifiedAdjacent

- (void)testJustifiedAdjacentAlignmentWithUnspecifiedHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithUnspecifiedHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithCompactHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithCompactHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithRegularHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithRegularHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .Centered

- (void)testCenteredAlignmentWithUnspecifiedHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithUnspecifiedHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithCompactHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithCompactHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithRegularHorizontalSizeClassInLTR {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithRegularHorizontalSizeClassInRTL {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

@end
