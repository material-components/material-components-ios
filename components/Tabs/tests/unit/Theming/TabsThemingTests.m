// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <XCTest/XCTest.h>

#import <MaterialComponents/MaterialColorScheme.h>
#import <MaterialComponents/MaterialTabs.h>
#import <MaterialComponents/MaterialTypographyScheme.h>
#import <MaterialComponentsBeta/MaterialContainerScheme.h>
#import <MaterialComponentsBeta/MaterialTabs+Theming.h>

static const CGFloat kUnselectedTitleOpacity = (CGFloat)0.6;
static const CGFloat kUnselectedImageOpacity = (CGFloat)0.54;
static const CGFloat kBottomDividerOpacity = (CGFloat)0.12;

@interface MDCTabsThemingTest : XCTestCase
@property(nonatomic, strong) MDCTabBar *tabBar;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@end

@implementation MDCTabsThemingTest

- (void)setUp {
  [super setUp];

  self.tabBar = [[MDCTabBar alloc] init];
  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.tabBar = nil;
  self.colorScheme = nil;
  self.typographyScheme = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testTabBarSemanticThemingDefault {
  // When
  [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];

  // Then
  // Color
  XCTAssertEqualObjects(self.tabBar.barTintColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects(self.tabBar.tintColor, self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.onPrimaryColor);
  UIColor *unselectedTitleColor =
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedImageOpacity];
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateNormal],
                        unselectedTitleColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateNormal],
                        unselectedImageColor);
  XCTAssertEqualObjects(
      self.tabBar.bottomDividerColor,
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kBottomDividerOpacity]);

  // Typography
  XCTAssertEqualObjects(self.tabBar.selectedItemTitleFont, self.typographyScheme.button);
  XCTAssertEqualObjects(self.tabBar.unselectedItemTitleFont, self.typographyScheme.button);
}

- (void)testTabBarSemanticThemingCustom {
  // When
  self.colorScheme.primaryColor = UIColor.redColor;
  self.colorScheme.onPrimaryColor = UIColor.blueColor;
  self.typographyScheme.button = [UIFont systemFontOfSize:14];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;
  [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];

  // Then
  // Color
  XCTAssertEqualObjects(self.tabBar.barTintColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects(self.tabBar.tintColor, self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.onPrimaryColor);
  UIColor *unselectedTitleColor =
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedImageOpacity];
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateNormal],
                        unselectedTitleColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateNormal],
                        unselectedImageColor);
  XCTAssertEqualObjects(
      self.tabBar.bottomDividerColor,
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kBottomDividerOpacity]);

  // Typography
  XCTAssertEqualObjects(self.tabBar.selectedItemTitleFont, self.typographyScheme.button);
  XCTAssertEqualObjects(self.tabBar.unselectedItemTitleFont, self.typographyScheme.button);
}

- (void)testTabBarSurfaceVariantThemingDefault {
  // When
  [self.tabBar applySurfaceVariantThemeWithScheme:self.containerScheme];

  // Then
  // Color
  XCTAssertEqualObjects(self.tabBar.barTintColor, self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.tabBar.tintColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.primaryColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.primaryColor);
  UIColor *unselectedTitleColor =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedImageOpacity];
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateNormal],
                        unselectedTitleColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateNormal],
                        unselectedImageColor);
  XCTAssertEqualObjects(
      self.tabBar.bottomDividerColor,
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kBottomDividerOpacity]);

  // Typography
  XCTAssertEqualObjects(self.tabBar.selectedItemTitleFont, self.typographyScheme.button);
  XCTAssertEqualObjects(self.tabBar.unselectedItemTitleFont, self.typographyScheme.button);
}

- (void)testTabBarSurfaceVariantThemingCustom {
  // When
  self.colorScheme.surfaceColor = UIColor.redColor;
  self.colorScheme.primaryColor = UIColor.blueColor;
  self.colorScheme.onSurfaceColor = UIColor.yellowColor;
  self.typographyScheme.button = [UIFont systemFontOfSize:14];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.tabBar applySurfaceVariantThemeWithScheme:self.containerScheme];

  // Then
  // Color
  XCTAssertEqualObjects(self.tabBar.barTintColor, self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.tabBar.tintColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.primaryColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.primaryColor);
  UIColor *unselectedTitleColor =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedImageOpacity];
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateNormal],
                        unselectedTitleColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateNormal],
                        unselectedImageColor);
  XCTAssertEqualObjects(
      self.tabBar.bottomDividerColor,
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kBottomDividerOpacity]);

  // Typography
  XCTAssertEqualObjects(self.tabBar.selectedItemTitleFont, self.typographyScheme.button);
  XCTAssertEqualObjects(self.tabBar.unselectedItemTitleFont, self.typographyScheme.button);
}

@end
