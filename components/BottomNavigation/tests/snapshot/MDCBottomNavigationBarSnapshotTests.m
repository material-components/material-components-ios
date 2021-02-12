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
#import "MaterialAvailability.h"
#import "MaterialBottomNavigation.h"
#import "MDCBottomNavigationBar+MaterialTheming.h"
#import "MaterialInk.h"
#import "MaterialSnapshot.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kWidthWide = 1600;
static const CGFloat kWidthNarrow = 240;
static const CGFloat kHeightTall = 120;
static const CGFloat kHeightShort = 48;

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
  if (self.navigationBar.items.count >= 2U) {
    self.navigationBar.items[1].badgeValue = MDCBottomNavigationTestBadgeTitleArabic;
  } else {
    self.navigationBar.items.firstObject.badgeValue = MDCBottomNavigationTestBadgeTitleArabic;
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
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];
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
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];
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
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];

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
  [self changeToRTLAndArabicWithTitle:MDCBottomNavigationTestShortTitleArabic];

  // When
  self.tabItem1.titlePositionAdjustment = UIOffsetMake(20, -20);
  self.tabItem3.titlePositionAdjustment = UIOffsetMake(-20, 20);

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Theming Material baseline

- (void)testMaterialBaselineTheme {
  // Given
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [self.navigationBar applyPrimaryThemeWithScheme:containerScheme];
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
  [self performInkTouchOnBar:self.navigationBar item:self.tabItem2];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCustomColorScheme {
  // Given
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
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
  containerScheme.colorScheme = colorScheme;

  containerScheme.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

  // When
  [self.navigationBar applyPrimaryThemeWithScheme:containerScheme];
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                        MDCBottomNavigationBarTestHeightTypical);
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
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
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
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
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
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
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
                        allTitles:MDCBottomNavigationTestLongTitleLatin];
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);
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

- (void)testShadowColorRespondsToDynamicColor {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *dynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blackColor;
          } else {
            return UIColor.redColor;
          }
        }];
    self.navigationBar.bounds = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                           MDCBottomNavigationBarTestHeightTypical);
    self.navigationBar.elevation = 10;
    self.navigationBar.shadowColor = dynamicColor;

    // When
    self.navigationBar.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [self.navigationBar layoutIfNeeded];

    // Then
    UIView *snapshotView =
        [self.navigationBar mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

#pragma mark - Badging

- (void)testCustomBadgeColorsSetAfterItems {
  // Given
  self.tabItem1.badgeValue = @"";
  self.tabItem2.badgeValue = @"Gray on Yellow";
  self.tabItem3.badgeValue = @"Gray on Green";
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);

  // When
  self.tabItem3.badgeColor = UIColor.greenColor;
  self.navigationBar.itemBadgeBackgroundColor = UIColor.yellowColor;
  self.navigationBar.itemBadgeTextColor = UIColor.darkGrayColor;

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCustomBadgeColorsSetBeforeItems {
  // Given
  self.tabItem1.badgeValue = @"";
  self.tabItem2.badgeValue = @"Gray on Yellow";
  self.tabItem3.badgeValue = @"Gray on Green";
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);

  // When
  self.tabItem3.badgeColor = UIColor.greenColor;
  self.navigationBar.itemBadgeBackgroundColor = UIColor.yellowColor;
  self.navigationBar.itemBadgeTextColor = UIColor.darkGrayColor;
  self.navigationBar.items =
      @[ self.tabItem1, self.tabItem2, self.tabItem3, self.tabItem4, self.tabItem5 ];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testNilBadgeColorsRendersClearBackgroundAndUILabelDefaultTextColor {
  // Given
  self.tabItem1.badgeValue = @"";
  self.tabItem2.badgeValue = @"Black on Clear";
  self.tabItem3.badgeValue = @"Black on Green";
  self.navigationBar.frame = CGRectMake(0, 0, MDCBottomNavigationBarTestWidthiPad,
                                        MDCBottomNavigationBarTestHeightTypical);

  // When
  self.tabItem3.badgeColor = UIColor.greenColor;
  self.navigationBar.itemBadgeBackgroundColor = nil;
  self.navigationBar.itemBadgeTextColor = nil;

  // Then
  [self generateAndVerifySnapshot];
}

@end
