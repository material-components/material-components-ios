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

#import "supplemental/MDCBottomNavigationSnapshotTestMutableTraitCollection.h"
#import "supplemental/MDCFakeBottomNavigationBar.h"
#import "MDCBottomNavigationBar.h"
#import "MDCSnapshotTestCase.h"
#import "UIImage+MDCSnapshot.h"
#import "UIView+MDCSnapshot.h"

/** Snapshot tests for MDCBottomNavigationBar's @c alignment property. */
@interface MDCBottomNavigationBarAlignmentSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCFakeBottomNavigationBar *navigationBar;
@end

@implementation MDCBottomNavigationBarAlignmentSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navigationBar = [[MDCFakeBottomNavigationBar alloc] init];

  CGSize imageSize = CGSizeMake(24, 24);
  UITabBarItem *tabItem1 = [[UITabBarItem alloc]
      initWithTitle:@"Item 1"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleEllipses]
                tag:1];
  UITabBarItem *tabItem2 = [[UITabBarItem alloc]
      initWithTitle:@"Item 2"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleCheckerboard]
                tag:2];
  tabItem2.badgeValue = @"888+";
  UITabBarItem *tabItem3 = [[UITabBarItem alloc]
      initWithTitle:@"Item 3"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleFramedX]
                tag:3];
  UITabBarItem *tabItem4 = [[UITabBarItem alloc]
      initWithTitle:@"Item 4"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleRectangles]
                tag:4];
  UITabBarItem *tabItem5 = [[UITabBarItem alloc]
      initWithTitle:@"Item 5"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                tag:5];
  self.navigationBar.items = @[ tabItem1, tabItem2, tabItem3, tabItem4, tabItem5 ];

  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = tabItem2;
}

#pragma mark - Helpers

- (void)generateAndVerifySnapshot {
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(1600, 120)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  UIView *backgroundView = [self.navigationBar mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

// TODO(b/229038068): Add test for Ripple touchOnBar after adding gating property

- (void)changeToRTLAndArabic {
  static UIFont *urduFont;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    urduFont = [UIFont fontWithName:@"NotoNastaliqUrdu" size:12];
  });
  self.navigationBar.itemTitleFont = urduFont;
  self.navigationBar.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  for (UITabBarItem *item in self.navigationBar.items) {
    item.title = @"ما تنفّس.";
    UIView *view = [self.navigationBar viewForItem:item];
    view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
  self.navigationBar.items[1].badgeValue = @"أورا";
}

#pragma mark - Alignment .Justified

- (void)testJustifiedAlignmentWithUnspecifiedHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithUnspecifiedHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;

  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithCompactHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithCompactHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithRegularHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAlignmentWithRegularHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .JustifiedAdjacent

- (void)testJustifiedAdjacentAlignmentWithUnspecifiedHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithUnspecifiedHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithCompactHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithCompactHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithRegularHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentAlignmentWithRegularHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .Centered

- (void)testCenteredAlignmentWithUnspecifiedHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithUnspecifiedHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithCompactHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithCompactHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithRegularHorizontalSizeClassInLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredAlignmentWithRegularHorizontalSizeClassInRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.traitCollectionOverride = traitCollection;
  [self changeToRTLAndArabic];

  // Then
  [self generateAndVerifySnapshot];
}

@end
