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

#import "MaterialTabs+Theming.h"
#import "MaterialTabs.h"

/**
 An MDCTabBar subclass that allows the user to override the @c traitCollection property.
 */
@interface MDCTabBarWithCustomTraitCollection : MDCTabBar
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCTabBarWithCustomTraitCollection
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

/**
 A Snapshot test case for testing MDCTabBarWithCustomTraitCollection's dynamic color support.
 */
@interface MDCTabBarDynamicColorSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCContainerScheme *containerScheme;

@property(nonatomic, strong) MDCTabBarWithCustomTraitCollection *tabBar;
@property(nonatomic, strong) UITabBarItem *item1;
@property(nonatomic, strong) UITabBarItem *item2;
@property(nonatomic, strong) UITabBarItem *item3;
@property(nonatomic, strong) UITabBarItem *item4;
@property(nonatomic, strong) UITabBarItem *item5;

@end

@implementation MDCTabBarDynamicColorSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //    self.recordMode = YES;

  self.tabBar = [[MDCTabBarWithCustomTraitCollection alloc] init];
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;

  CGSize imageSize = CGSizeMake(24, 24);
  self.item1 = [[UITabBarItem alloc]
      initWithTitle:@"Item 1"
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleCheckerboard]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:1];
  self.item1.badgeValue = @"1";

  self.item2 = [[UITabBarItem alloc]
      initWithTitle:@"Item 2"
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:2];
  self.item2.badgeValue = @"2";

  self.item3 = [[UITabBarItem alloc]
      initWithTitle:@"Item 3"
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleFramedX]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:3];
  self.item3.badgeValue = @"3";

  self.item4 = [[UITabBarItem alloc]
      initWithTitle:@"Item 4"
              image:[[UIImage mdc_testImageOfSize:imageSize
                                        withStyle:MDCSnapshotTestImageStyleEllipses]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:4];
  self.item4.badgeValue = @"4";

  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];

#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    UIColor *dynamicOnPrimary =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.greenColor;
          } else {
            return UIColor.yellowColor;
          }
        }];
    self.containerScheme.colorScheme.onPrimaryColor = dynamicOnPrimary;

    UIColor *dynamicBadgeColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.redColor;
          } else {
            return UIColor.blueColor;
          }
        }];
    self.item1.badgeColor = dynamicBadgeColor;
    self.item2.badgeColor = dynamicBadgeColor;
    self.item3.badgeColor = dynamicBadgeColor;
    self.item4.badgeColor = dynamicBadgeColor;
  }
#endif
}

- (void)tearDown {
  self.containerScheme = nil;
  self.tabBar = nil;
  self.item1 = nil;
  self.item2 = nil;
  self.item3 = nil;
  self.item4 = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)testColorSchemeDefaultsWithLightUserInterfaceStyle {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // When
    [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];
    self.tabBar.items = @[ self.item1, self.item2, self.item3, self.item4 ];
    self.tabBar.frame = CGRectMake(0, 0, 480, 100);
    [self.tabBar sizeToFit];
    [self.tabBar layoutIfNeeded];

    // Then
    UIView *snapshotView = [self.tabBar mdc_addToBackgroundView];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif
}

- (void)testColorSchemeDefaultsWithDarkUserInterfaceStyle {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // When
    self.tabBar.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    self.tabBar.items = @[ self.item1, self.item2, self.item3, self.item4 ];
    [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];
    self.tabBar.frame = CGRectMake(0, 0, 480, 100);
    [self.tabBar sizeToFit];
    [self.tabBar layoutIfNeeded];

    // Then
    UIView *snapshotView = [self.tabBar mdc_addToBackgroundView];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif
}

@end
