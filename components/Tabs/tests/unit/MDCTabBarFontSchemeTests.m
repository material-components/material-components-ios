//
//  MDCTabBarFontSchemeTests.m
//  MaterialComponentsUnitTests
//
//  Created by Mohammad Cazi on 3/9/18.
//

#import <XCTest/XCTest.h>

#import "MaterialTabs.h"
#import "MaterialThemes.h"
#import "MDCTabBarFontThemer.h"

@interface MDCTabBarFontSchemeTests : XCTestCase
@end

@implementation MDCTabBarFontSchemeTests

- (void)testTabBarFontThemerApplyFontSchemeProperly {
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.button = [UIFont boldSystemFontOfSize:22];
  [MDCTabBarFontThemer applyFontScheme:fontScheme toTabBar:tabBar];
  XCTAssertEqualObjects(tabBar.selectedItemTitleFont, fontScheme.button);
  XCTAssertEqualObjects(tabBar.unselectedItemTitleFont, fontScheme.button);
}

@end
