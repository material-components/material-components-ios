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

#import "MaterialColorScheme.h"
#import "MaterialTabs.h"
#import "MaterialTabs+ColorThemer.h"

@interface MDCTabBarTestColorScheme : NSObject <MDCColorScheme>

@end

@implementation MDCTabBarTestColorScheme

- (UIColor *)primaryColor {
  return [UIColor redColor];
}

- (UIColor *)primaryDarkColor {
  return [UIColor darkGrayColor];
}

- (UIColor *)primaryLightColor {
  return [UIColor yellowColor];
}

@end

@interface MDCTabBarTestColorSchemeNoOptionalImplementation : NSObject <MDCColorScheme>

@end

@implementation MDCTabBarTestColorSchemeNoOptionalImplementation

- (UIColor *)primaryColor {
  return [UIColor redColor];
}

@end

@interface MDCTabBarColorThemerTests : XCTestCase

@end

@implementation MDCTabBarColorThemerTests

- (void)testColorScheming {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = [UIColor redColor];
  colorScheme.onPrimaryColor = [UIColor blueColor];
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  tabBar.barTintColor = [UIColor greenColor];
  tabBar.tintColor = [UIColor yellowColor];
  tabBar.selectedItemTintColor = [UIColor yellowColor];
  
  // When
  [MDCTabBarColorThemer applySemanticColorScheme:colorScheme
                                          toTabs:tabBar];

  // Then
  XCTAssertEqualObjects(tabBar.barTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(tabBar.tintColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(tabBar.selectedItemTintColor, colorScheme.onPrimaryColor);
}

- (void)testSurfaceVariantColorScheming {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  colorScheme.primaryColor = [UIColor redColor];
  colorScheme.onPrimaryColor = [UIColor blueColor];
  colorScheme.surfaceColor = [UIColor orangeColor];
  colorScheme.onSurfaceColor = [UIColor greenColor];
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  tabBar.barTintColor = [UIColor greenColor];
  tabBar.tintColor = [UIColor yellowColor];
  tabBar.selectedItemTintColor = [UIColor yellowColor];

  // When
  [MDCTabBarColorThemer applySurfaceVariantWithColorScheme:colorScheme toTabs:tabBar];

  // Then
  XCTAssertEqualObjects(tabBar.barTintColor, colorScheme.surfaceColor);
  XCTAssertEqualObjects(tabBar.tintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(tabBar.selectedItemTintColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(
      tabBar.unselectedItemTintColor,
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54]);
}

- (void)testTabBarColorThemerApplyColorSchemeProperly {
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  MDCTabBarTestColorScheme *colorScheme = [[MDCTabBarTestColorScheme alloc] init];
  [MDCTabBarColorThemer applyColorScheme:colorScheme toTabBar:tabBar];
  XCTAssertEqualObjects(tabBar.selectedItemTintColor, colorScheme.primaryDarkColor);
  XCTAssertEqualObjects(tabBar.unselectedItemTintColor, colorScheme.primaryLightColor);
  XCTAssertEqualObjects(tabBar.inkColor, colorScheme.primaryLightColor);
}

- (void)testTabBarColorThemerGracefullyHandlesColorSchemeWithNoOptionalImplementation {
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  UIColor *color = [UIColor redColor];
  tabBar.selectedItemTintColor = color;
  tabBar.unselectedItemTintColor = color;
  tabBar.inkColor = color;

  MDCTabBarTestColorSchemeNoOptionalImplementation *colorScheme =
      [[MDCTabBarTestColorSchemeNoOptionalImplementation alloc] init];
  [MDCTabBarColorThemer applyColorScheme:colorScheme toTabBar:tabBar];
  XCTAssertEqualObjects(tabBar.selectedItemTintColor, color);
  XCTAssertEqualObjects(tabBar.unselectedItemTintColor, color);
  XCTAssertEqualObjects(tabBar.inkColor, color);
}

@end
