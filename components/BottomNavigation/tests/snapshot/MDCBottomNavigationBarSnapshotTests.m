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
static const CGFloat kWidthiPad = 1024;
static const CGFloat kWidthTypical = 360;
static const CGFloat kWidthNarrow = 240;
static const CGFloat kHeightTall = 120;
static const CGFloat kHeightTypical = 56;
static const CGFloat kHeightShort = 48;
static NSString *const kLongTitleLatin =
    @"123456789012345678901234567890123456789012345678901234567890";
static NSString *const kLongTitleArabic =
    @"دول السيطرة استطاعوا ٣٠. مليون وفرنسا أوراقهم انه تم, نفس قد والديون العالمية. دون ما تنفّس.";
static NSString *const kShortTitleArabic = @"ما تنفّس.";
static NSString *const kBadgeTitleLatin = @"888+";
static NSString *const kBadgeTitleArabic = @"أورا";

@interface MDCBottomNavigationBarSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCFakeBottomNavigationBar *navigationBar;
@property(nonatomic, strong) UITabBarItem *tabItem1;
@property(nonatomic, strong) UITabBarItem *tabItem2;
@property(nonatomic, strong) UITabBarItem *tabItem3;
@property(nonatomic, strong) UITabBarItem *tabItem4;
@property(nonatomic, strong) UITabBarItem *tabItem5;
@end

@implementation MDCBottomNavigationBarSnapshotTests

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
  self.tabItem2.badgeValue = kBadgeTitleLatin;
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

- (void)performInkTouchOnBar:(MDCBottomNavigationBar *)navigationBar item:(UITabBarItem *)item {
  [navigationBar layoutIfNeeded];
  MDCBottomNavigationItemView *itemView =
      (MDCBottomNavigationItemView *)[navigationBar viewForItem:item];
  [itemView.inkView startTouchBeganAtPoint:CGPointMake(CGRectGetMidX(itemView.bounds),
                                                       CGRectGetMidY(itemView.bounds))
                                  animated:NO
                            withCompletion:nil];
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

#pragma mark - Extreme sizes

- (void)testJustifiedUnspecifiedAlwaysFiveItemsNarrowWidthShortHeightLTR {
  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthNarrow, kHeightShort);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsNarrowWidthShortHeightRTL {
  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthNarrow, kHeightShort);
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsWideWidthTallHeightLTR {
  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthWide, kHeightTall);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsWideWidthTallHeightRTL {
  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthWide, kHeightTall);
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Layout Adjustments

- (void)testTitlePositionAdjustmentJustifiedAdjacentCompactLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  // When
  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testTitlePositionAdjustmentJustifiedAdjacentCompactRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // When
  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testTitlePositionAdjustmentJustifiedAdjacentRegularLTR {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];

  // When
  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testTitlePositionAdjustmentJustifiedAdjacentRegularRTL {
  // Given
  MDCBottomNavigationSnapshotTestMutableTraitCollection *traitCollection =
      [[MDCBottomNavigationSnapshotTestMutableTraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];
  [self changeToRTLAndArabicWithTitle:kShortTitleArabic];

  // When
  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Theming Material baseline

- (void)testMaterialBaselineTheme {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // When
  [MDCBottomNavigationBarColorThemer applySemanticColorScheme:colorScheme
                                           toBottomNavigation:self.navigationBar];
  [MDCBottomNavigationBarTypographyThemer applyTypographyScheme:typographyScheme
                                          toBottomNavigationBar:self.navigationBar];
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem2];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCustomColorScheme {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = UIColor.orangeColor;
  colorScheme.onPrimaryColor = UIColor.purpleColor;
  colorScheme.secondaryColor = UIColor.yellowColor;
  colorScheme.onSecondaryColor = UIColor.cyanColor;
  colorScheme.surfaceColor = UIColor.lightGrayColor;
  colorScheme.onSurfaceColor = UIColor.magentaColor;
  colorScheme.backgroundColor = UIColor.blueColor;
  colorScheme.onBackgroundColor = UIColor.brownColor;
  colorScheme.errorColor = UIColor.greenColor;
  colorScheme.primaryColorVariant = UIColor.whiteColor;

  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // When
  [MDCBottomNavigationBarColorThemer applySemanticColorScheme:colorScheme
                                           toBottomNavigation:self.navigationBar];
  [MDCBottomNavigationBarTypographyThemer applyTypographyScheme:typographyScheme
                                          toBottomNavigationBar:self.navigationBar];
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem2];

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - KVO tests

- (void)testChangeSelectedIconWhenUnselected {
  // Given
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:kLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, kWidthiPad, kHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];
  self.navigationBar.selectedItemTintColor = UIColor.orangeColor;
  self.navigationBar.unselectedItemTintColor = UIColor.blackColor;
  self.navigationBar.selectedItem = self.tabItem2;

  // When
  self.tabItem3.selectedImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeSelectedIconWhenSelected {
  // Given
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:kLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, kWidthiPad, kHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];
  self.navigationBar.selectedItemTintColor = UIColor.orangeColor;
  self.navigationBar.unselectedItemTintColor = UIColor.blackColor;
  self.navigationBar.selectedItem = self.tabItem2;

  // When
  self.tabItem2.selectedImage = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeUnselectedIconWhenUnselected {
  // Given
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:kLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, kWidthiPad, kHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];
  self.navigationBar.selectedItemTintColor = UIColor.orangeColor;
  self.navigationBar.unselectedItemTintColor = UIColor.blackColor;
  self.navigationBar.selectedItem = self.tabItem2;

  // When
  self.tabItem3.image = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testChangeUnselectedIconWhenSelected {
  // Given
  [self configureBottomNavigation:self.navigationBar
                    withAlignment:MDCBottomNavigationBarAlignmentJustified
                  titleVisibility:MDCBottomNavigationBarTitleVisibilityAlways
                  traitCollection:nil
                        allTitles:kLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, kWidthiPad, kHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem1];
  self.navigationBar.selectedItemTintColor = UIColor.orangeColor;
  self.navigationBar.unselectedItemTintColor = UIColor.blackColor;
  self.navigationBar.selectedItem = self.tabItem2;

  // When
  self.tabItem2.image = [[UIImage mdc_testImageOfSize:CGSizeMake(36, 36)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // Then
  [self generateAndVerifySnapshot];
}

@end
