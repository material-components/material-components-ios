//
//  MDCTabBarColorSchemeTests.m
//  MaterialComponentsUnitTests
//
//  Created by Mohammad Cazi on 3/9/18.
//

#import <XCTest/XCTest.h>

#import "MaterialTabs.h"
#import "MaterialThemes.h"
#import "MDCTabBarColorThemer.h"

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

@interface MDCTabBarColorSchemeTests : XCTestCase

@end

@implementation MDCTabBarColorSchemeTests

- (void)testTabBarColorThemerApplyColorSchemeProperly {
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  MDCTabBarTestColorScheme *colorScheme = [[MDCTabBarTestColorScheme alloc] init];
  [MDCTabBarColorThemer applyColorScheme:colorScheme toTabBar:tabBar];
  XCTAssertEqualObjects(tabBar.selectedItemTintColor, colorScheme.primaryDarkColor);
  XCTAssertEqualObjects(tabBar.unselectedItemTintColor, colorScheme.primaryLightColor);
  XCTAssertEqualObjects(tabBar.inkColor, colorScheme.primaryLightColor);
}

@end
