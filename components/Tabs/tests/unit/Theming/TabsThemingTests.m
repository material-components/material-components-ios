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

#import <XCTest/XCTest.h>

#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTabs+Theming.h"
#import "MaterialTabs.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kPrimaryThemeUnselectedOpacity = (CGFloat)0.74;
static const CGFloat kSurfaceThemeUnselectedOpacity = (CGFloat)0.6;

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
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;
}

- (void)tearDown {
  self.tabBar = nil;
  self.colorScheme = nil;
  self.typographyScheme = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testTabBarPrimaryThemingDefault {
  // When
  [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTabBarPrimaryTheming];
}

- (void)testTabBarPrimaryThemingCustom {
  // Given
  self.colorScheme = [self customColorScheme];
  self.typographyScheme = [self customTypographyScheme];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.tabBar applyPrimaryThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTabBarPrimaryTheming];
}

- (void)testTabBarSurfaceVariantThemingDefault {
  // When
  [self.tabBar applySurfaceThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTabBarSurfaceVariantTheming];
}

- (void)testTabBarSurfaceVariantThemingCustom {
  // Given
  self.colorScheme = [self customColorScheme];
  self.typographyScheme = [self customTypographyScheme];
  self.containerScheme.colorScheme = self.colorScheme;
  self.containerScheme.typographyScheme = self.typographyScheme;

  // When
  [self.tabBar applySurfaceThemeWithScheme:self.containerScheme];

  // Then
  [self verifyTabBarSurfaceVariantTheming];
}

#pragma mark - Test helpers

- (MDCSemanticColorScheme *)customColorScheme {
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

  colorScheme.primaryColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:0];
  colorScheme.primaryColorVariant = [UIColor colorWithWhite:(CGFloat)0.8 alpha:(CGFloat)0.1];
  colorScheme.secondaryColor = [UIColor colorWithWhite:(CGFloat)0.7 alpha:(CGFloat)0.2];
  colorScheme.errorColor = [UIColor colorWithWhite:(CGFloat)0.6 alpha:(CGFloat)0.3];
  colorScheme.surfaceColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:(CGFloat)0.4];
  colorScheme.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.4 alpha:(CGFloat)0.5];
  colorScheme.onPrimaryColor = [UIColor colorWithWhite:(CGFloat)0.3 alpha:(CGFloat)0.6];
  colorScheme.onSecondaryColor = [UIColor colorWithWhite:(CGFloat)0.2 alpha:(CGFloat)0.7];
  colorScheme.onSurfaceColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:(CGFloat)0.8];
  colorScheme.onBackgroundColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.9];

  return colorScheme;
}

- (MDCTypographyScheme *)customTypographyScheme {
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];

  typographyScheme.headline1 = [UIFont systemFontOfSize:1];
  typographyScheme.headline2 = [UIFont systemFontOfSize:2];
  typographyScheme.headline3 = [UIFont systemFontOfSize:3];
  typographyScheme.headline4 = [UIFont systemFontOfSize:4];
  typographyScheme.headline5 = [UIFont systemFontOfSize:5];
  typographyScheme.headline6 = [UIFont systemFontOfSize:6];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:7];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:8];
  typographyScheme.body1 = [UIFont systemFontOfSize:9];
  typographyScheme.body2 = [UIFont systemFontOfSize:10];
  typographyScheme.caption = [UIFont systemFontOfSize:11];
  typographyScheme.button = [UIFont systemFontOfSize:12];
  typographyScheme.overline = [UIFont systemFontOfSize:13];

  return typographyScheme;
}

- (void)verifyTabBarPrimaryTheming {
  // Color
  XCTAssertEqualObjects(self.tabBar.barTintColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects(self.tabBar.tintColor, self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.onPrimaryColor);
  UIColor *unselectedTitleColor =
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeUnselectedOpacity];
  UIColor *unselectedImageColor =
      [self.colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeUnselectedOpacity];
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateNormal],
                        unselectedTitleColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateNormal],
                        unselectedImageColor);

  // Typography
  XCTAssertEqualObjects(self.tabBar.selectedItemTitleFont, self.typographyScheme.button);
  XCTAssertEqualObjects(self.tabBar.unselectedItemTitleFont, self.typographyScheme.button);
}

- (void)verifyTabBarSurfaceVariantTheming {
  // Color
  XCTAssertEqualObjects(self.tabBar.barTintColor, self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(self.tabBar.tintColor, self.colorScheme.primaryColor);
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.primaryColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateSelected],
                        self.colorScheme.primaryColor);
  UIColor *unselectedTitleColor =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kSurfaceThemeUnselectedOpacity];
  UIColor *unselectedImageColor =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kSurfaceThemeUnselectedOpacity];
  XCTAssertEqualObjects([self.tabBar titleColorForState:MDCTabBarItemStateNormal],
                        unselectedTitleColor);
  XCTAssertEqualObjects([self.tabBar imageTintColorForState:MDCTabBarItemStateNormal],
                        unselectedImageColor);

  // Typography
  XCTAssertEqualObjects(self.tabBar.selectedItemTitleFont, self.typographyScheme.button);
  XCTAssertEqualObjects(self.tabBar.unselectedItemTitleFont, self.typographyScheme.button);
}

@end
