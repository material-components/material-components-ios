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

#import "supplemental/MDCBottomNavigationSnapshotTestMutableTraitCollection.h"
#import "supplemental/MDCBottomNavigationSnapshotTestUtilities.h"
#import "supplemental/MDCFakeBottomNavigationBar.h"
#import "MDCBottomNavigationBar.h"
#import "MDCRippleTouchController.h"
#import "MDCRippleView.h"
#import "MDCSnapshotTestCase.h"
#import "UIImage+MDCSnapshot.h"
#import "UIView+MDCSnapshot.h"

@interface MDCBottomNavigationBarTitleLayoutSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCFakeBottomNavigationBar *navigationBar;
@property(nonatomic, strong) UITabBarItem *tabItem1;
@property(nonatomic, strong) UITabBarItem *tabItem2;
@property(nonatomic, strong) UITabBarItem *tabItem3;
@property(nonatomic, strong) UITabBarItem *tabItem4;
@property(nonatomic, strong) UITabBarItem *tabItem5;
@end

@implementation MDCBottomNavigationBarTitleLayoutSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navigationBar = [[MDCFakeBottomNavigationBar alloc] init];

  CGSize imageSize = CGSizeMake(24, 24);
  self.tabItem1 = [[UITabBarItem alloc]
      initWithTitle:@"Item 1"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleEllipses]
                tag:1];
  self.tabItem2 = [[UITabBarItem alloc]
      initWithTitle:@"Item 2"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleCheckerboard]
                tag:2];
  self.tabItem2.badgeValue = MDCBottomNavigationTestBadgeTitleLatin;
  self.tabItem3 = [[UITabBarItem alloc]
      initWithTitle:@"Item 3"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleFramedX]
                tag:3];
  self.tabItem4 = [[UITabBarItem alloc]
      initWithTitle:@"Item 4"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleRectangles]
                tag:4];
  self.tabItem5 = [[UITabBarItem alloc]
      initWithTitle:@"Item 5"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                tag:5];
  self.navigationBar.items =
      @[ self.tabItem1, self.tabItem2, self.tabItem3, self.tabItem4, self.tabItem5 ];
}

#pragma mark - Helpers

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.navigationBar mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)performRippleTouchOnBar:(MDCBottomNavigationBar *)navigationBar item:(UITabBarItem *)item {
  [navigationBar layoutIfNeeded];
  MDCBottomNavigationItemView *itemView =
      (MDCBottomNavigationItemView *)[navigationBar viewForItem:item];
  CGPoint point = CGPointMake(CGRectGetMidX(itemView.bounds), CGRectGetMidY(itemView.bounds));
  [itemView.rippleTouchController.rippleView beginRippleTouchDownAtPoint:point
                                                                animated:NO
                                                              completion:nil];
}

- (void)configureBottomNavigation:(MDCFakeBottomNavigationBar *)bottomNavigation
                    withAlignment:(MDCBottomNavigationBarAlignment)alignment
                  titleVisibility:(MDCBottomNavigationBarTitleVisibility)titleVisibility
                  traitCollection:(UITraitCollection *)traitCollection
                        allTitles:(NSString *)title {
  bottomNavigation.alignment = alignment;
  bottomNavigation.titleVisibility = titleVisibility;
  if (traitCollection) {
    bottomNavigation.traitCollectionOverride = traitCollection;
  }
  if (title) {
    for (UITabBarItem *item in bottomNavigation.items) {
      item.title = title;
    }
  }
}

- (void)changeToRTLAndArabicWithTitle:(NSString *)title {
  static UIFont *urduFont;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    urduFont = [UIFont fontWithName:@"NotoNastaliqUrdu" size:12];
  });
  self.navigationBar.itemTitleFont = urduFont;
  self.navigationBar.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  for (UITabBarItem *item in self.navigationBar.items) {
    item.title = title;
    UIView *view = [self.navigationBar viewForItem:item];
    view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
  self.navigationBar.items[1].badgeValue = MDCBottomNavigationTestBadgeTitleArabic;
}

#pragma mark - Title length tests

- (void)testJustifiedUnspecifiedAlwaysWithFiveLongTitleItemsiPadWidthTypicalHeightLTR {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysWithFiveLongTitleItemsUnboundiPadWidthTypicalHeightLTR {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  self.navigationBar.truncatesLongTitles = NO;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysWithFiveLongTitleItemsiPadWidthTypicalHeightRTL {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysWithFiveLongTitleItemsUnboundiPadWidthTypicalHeightRTL {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  self.navigationBar.truncatesLongTitles = NO;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysWithFiveLongTitleItemsiPadWidthTypicalHeightLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:traitCollection
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysWithFiveLongTitleItemsUnboundiPadWidthTypicalHeightLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:traitCollection
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  self.navigationBar.truncatesLongTitles = NO;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysWithFiveLongTitleItemsWrappediPadWidthTypicalHeightLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:traitCollection
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.titlesNumberOfLines = 0;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysWithFiveLongTitleItemsiPadWidthTypicalHeightRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:traitCollection
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysWithFiveLongTitleItemsUnboundiPadWidthTypicalHeightRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:traitCollection
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  self.navigationBar.truncatesLongTitles = NO;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysWithFiveLongTitleItemsWrappediPadWidthTypicalHeightRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:traitCollection
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  self.navigationBar.titlesNumberOfLines = 0;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredUnspecifiedAlwaysWithFiveLongTitleItemsiPadWidthTypicalHeightLTR {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentCentered
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredUnspecifiedAlwaysWithFiveLongTitleItemsUnboundiPadWidthTypicalHeightLTR {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentCentered
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  self.navigationBar.truncatesLongTitles = NO;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredUnspecifiedAlwaysWithFiveLongTitleItemsWrappediPadWidthTypicalHeightLTR {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentCentered
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  self.navigationBar.titlesNumberOfLines = 0;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredUnspecifiedAlwaysWithFiveLongTitleItemsiPadWidthTypicalHeightRTL {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentCentered
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredUnspecifiedAlwaysWithFiveLongTitleItemsUnboundiPadWidthTypicalHeightRTL {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentCentered
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  self.navigationBar.truncatesLongTitles = NO;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredUnspecifiedAlwaysWithFiveLongTitleItemsWrappediPadWidthTypicalHeightRTL {
  // When
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentCentered
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestLongTitleArabic];
  self.navigationBar.titlesNumberOfLines = 0;
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Title visibility tests

- (void)testJustifiedUnspecifiedSelectedWithThreeItemsTypicalWidthTypicalHeightLTR {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedSelectedWithThreeItemsTypicalWidthTypicalHeightRTL {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysWithThreeItemsTypicalWidthTypicalHeightLTR {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysWithThreeItemsTypicalWidthTypicalHeightRTL {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];
  [self performRippleTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedNeverWithThreeItemsTypicalWidthTypicalHeightLTR {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityNever;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedNeverWithThreeItemsTypicalWidthTypicalHeightRTL {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityNever;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];

  // Then
  [self generateAndVerifySnapshot];
}

@end
