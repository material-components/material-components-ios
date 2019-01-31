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

#import "MaterialBottomNavigation+ColorThemer.h"
#import "MaterialBottomNavigation+TypographyThemer.h"
#import "MaterialBottomNavigation.h"
#import "MaterialSnapshot.h"

static const CGFloat kWidthWide = 1600;
static const CGFloat kWidthTypical = 360;
static const CGFloat kWidthNarrow = 240;
static const CGFloat kHeightTall = 120;
static const CGFloat kHeightTypical = 56;
static const CGFloat kHeightShort = 48;

static inline UIImage *CreateTestImage(CGSize size) {
  UIGraphicsBeginImageContext(size);
  [UIColor.whiteColor setFill];
  CGFloat quarterWidth = size.width / 4;
  CGFloat quarterHeight = size.height / 4;
  // Create a "checkboard" pattern
  for (int x = 0; x < 4; ++x) {
    for (int y = (x & 0x01); y < 4; y += 2) {
      UIRectFill(CGRectMake(x * quarterWidth, y * quarterHeight, quarterWidth, quarterHeight));
    }
  }
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MDCMutableUITraitCollection : UITraitCollection
@property(nonatomic, assign) UIUserInterfaceSizeClass horizontalSizeClassOverride;
@property(nonatomic, assign) UIUserInterfaceSizeClass verticalSizeClassOverride;
@end

@implementation MDCMutableUITraitCollection

- (UIUserInterfaceSizeClass)horizontalSizeClass {
  return self.horizontalSizeClassOverride;
}

- (UIUserInterfaceSizeClass)verticalSizeClass {
  return self.verticalSizeClassOverride;
}

@end

@interface MDCFakeBottomNavigationBar : MDCBottomNavigationBar
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCFakeBottomNavigationBar

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCBottomNavigationBarSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCFakeBottomNavigationBar *navigationBar;
@property(nonatomic, strong) UITabBarItem *tabItem1;
@property(nonatomic, strong) UITabBarItem *tabItem2;
@property(nonatomic, strong) UITabBarItem *tabItem3;
@property(nonatomic, strong) UITabBarItem *tabItem4;
@property(nonatomic, strong) UITabBarItem *tabItem5;
@property(nonatomic, strong) UIImage *testImage;
@end

@implementation MDCBottomNavigationBarSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navigationBar = [[MDCFakeBottomNavigationBar alloc] init];

  self.testImage = CreateTestImage(CGSizeMake(24, 24));
  self.tabItem1 = [[UITabBarItem alloc] initWithTitle:@"Item 1" image:self.testImage tag:1];
  self.tabItem2 = [[UITabBarItem alloc] initWithTitle:@"Item 2" image:self.testImage tag:2];
  self.tabItem3 = [[UITabBarItem alloc] initWithTitle:@"Item 3" image:self.testImage tag:3];
  self.tabItem4 = [[UITabBarItem alloc] initWithTitle:@"Item 4" image:self.testImage tag:4];
  self.tabItem5 = [[UITabBarItem alloc] initWithTitle:@"Item 5" image:self.testImage tag:5];
  self.navigationBar.items =
      @[ self.tabItem1, self.tabItem2, self.tabItem3, self.tabItem4, self.tabItem5 ];
}

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.navigationBar mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

#pragma mark - Title visibility

- (void)testJustifiedUnspecifiedSelectedWithThreeItemsTypicalWidthTypicalHeight {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysWithThreeItemsTypicalWidthTypicalHeight {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedNeverWithThreeItemsTypicalWidthTypicalHeight {
  // When
  self.navigationBar.items = @[ self.tabItem1, self.tabItem2, self.tabItem3 ];
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityNever;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthTypical, kHeightTypical);

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Extreme sizes

- (void)testJustifiedUnspecifiedAlwaysFiveItemsNarrowWidthShortHeight {
  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthNarrow, kHeightShort);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedUnspecifiedAlwaysFiveItemsWideWidthTallHeight {
  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.frame = CGRectMake(0, 0, kWidthWide, kHeightTall);

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .Justified

- (void)testJustifiedUnspecifiedAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedCompactAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedRegularAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustified;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .JustifiedAdjacent

- (void)testJustifiedAdjacentUnspecifiedAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentCompactAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testJustifiedAdjacentRegularAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

#pragma mark - Alignment .Centered

- (void)testCenteredUnspecifiedAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassUnspecified;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredCompactAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassCompact;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testCenteredRegularAlwaysFiveItemsFitWidthFitHeight {
  // Given
  MDCMutableUITraitCollection *traitCollection = [[MDCMutableUITraitCollection alloc] init];
  traitCollection.horizontalSizeClassOverride = UIUserInterfaceSizeClassRegular;

  // When
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentCentered;
  self.navigationBar.selectedItem = self.tabItem2;
  self.navigationBar.traitCollectionOverride = traitCollection;
  CGSize fitSize = [self.navigationBar sizeThatFits:CGSizeMake(kWidthWide, kHeightTall)];
  self.navigationBar.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);

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

  // Then
  [self generateAndVerifySnapshot];
}

@end
