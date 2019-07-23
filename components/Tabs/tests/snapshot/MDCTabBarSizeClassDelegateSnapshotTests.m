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

#import "MDCTabBarSizeClassDelegate.h"
#import "MaterialContainerScheme.h"
#import "MaterialTabs+Theming.h"
#import "MaterialTabs.h"

static NSString *const kItemTitleShort1Latin = @"Quando";
static NSString *const kItemTitleShort2Latin = @"No";
static NSString *const kItemTitleShort3Latin = @"Facer";

static NSString *const kItemTitleShort1Arabic = @"عل";
static NSString *const kItemTitleShort2Arabic = @"قد";
static NSString *const kItemTitleShort3Arabic = @"وتم";

/** Snapshot tests for MDCTabBar rendering .*/
@interface MDCTabBarSizeClassDelegateSnapshotTests
    : MDCSnapshotTestCase <MDCTabBarSizeClassDelegate>

/** The view being tested. */
@property(nonatomic, strong) MDCTabBar *tabBar;
@property(nonatomic, strong) UITabBarItem *item1;
@property(nonatomic, strong) UITabBarItem *item2;
@property(nonatomic, strong) UITabBarItem *item3;
@property(nonatomic, strong) UITabBarItem *item4;
@property(nonatomic, strong) UITabBarItem *item5;

/** The returned horizontal size class when acting as the tab bar's size class delegate. */
@property(nonatomic) UIUserInterfaceSizeClass horizontalSizeClass;
@end

@implementation MDCTabBarSizeClassDelegateSnapshotTests

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
  [self.tabBar applySurfaceThemeWithScheme:[[MDCContainerScheme alloc] init]];
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

- (void)setTitlesToArabicShort {
  self.item1.title = kItemTitleShort1Arabic;
  self.item2.title = kItemTitleShort2Arabic;
  self.item3.title = kItemTitleShort3Arabic;
  self.item3.badgeValue = kItemTitleShort1Arabic;
  self.item4.title = kItemTitleShort1Arabic;
  self.item5.title = kItemTitleShort2Arabic;
}

- (void)generateSnapshotAndVerifyTabBar {
  self.tabBar.frame = CGRectMake(0, 0, 240, 100);
  [self.tabBar sizeToFit];
  UIView *snapshotView = [self.tabBar mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - MDCTabBarSizeClassDelegate methods

- (UIUserInterfaceSizeClass)horizontalSizeClassForObject:(id<UITraitEnvironment>)object {
  return self.horizontalSizeClass;
}

#pragma mark - Tests for Leading Alignment

- (void)testLeadingAlignmentNilHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testLeadingAlignmentNilHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.alignment = MDCTabBarAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testLeadingAlignmentCompactHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testLeadingAlignmentCompactHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testLeadingAlignmentRegularHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testLeadingAlignmentRegularHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

#pragma mark - Tests for Justified Alignment

- (void)testJustifiedAlignmentNilHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testJustifiedAlignmentNilHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.alignment = MDCTabBarAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testJustifiedAlignmentCompactHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testJustifiedAlignmentCompactHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testJustifiedAlignmentRegularHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testJustifiedAlignmentRegularHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

#pragma mark - Tests for Center Alignment

- (void)testCenterAlignmentNilHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterAlignmentNilHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterAlignmentCompactHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterAlignmentCompactHorizontalSizeClassDelegateArabicRTL {
  // Given
  self.tabBar.sizeClassDelegate = self;
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterAlignmentRegularHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterAlignmentRegularHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

#pragma mark - Tests for CenterSelected Alignment

- (void)testCenterSelectedAlignmentNilHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterSelectedAlignmentNilHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterSelectedAlignmentCompactHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterSelectedAlignmentCompactHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassCompact;
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterSelectedAlignmentRegularHorizontalSizeClassDelegateLatinLTR {
  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

- (void)testCenterSelectedAlignmentRegularHorizontalSizeClassDelegateArabicRTL {
  // Given
  [self setTitlesToArabicShort];
  [self changeViewToRTL:self.tabBar];

  // When
  self.tabBar.sizeClassDelegate = self;
  self.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  // Then
  [self generateSnapshotAndVerifyTabBar];
}

@end
