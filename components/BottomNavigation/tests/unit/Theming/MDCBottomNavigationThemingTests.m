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

#import "MaterialBottomNavigation+Theming.h"

#import <XCTest/XCTest.h>

#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialShadowElevations.h"
#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kUnselectedPrimaryAlpha = 0.74f;
static const CGFloat kUnselectedSurfaceAlpha = 0.6f;

@interface MDCBottomNavigationThemingTests : XCTestCase
@property(nonatomic, strong, nullable) MDCBottomNavigationBar *bottomNavigationBar;
@end

@implementation MDCBottomNavigationThemingTests

- (void)setUp {
  [super setUp];

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Home"
                                                            image:[UIImage imageNamed:@"Home"]
                                                              tag:0];
  UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Messages"
                                                            image:[UIImage imageNamed:@"Email"]
                                                              tag:0];
  UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Favorites"
                                                            image:[UIImage imageNamed:@"Favorite"]
                                                              tag:0];
  self.bottomNavigationBar.items = @[ tabBarItem1, tabBarItem2, tabBarItem3 ];
}

- (void)tearDown {
  self.bottomNavigationBar = nil;

  [super tearDown];
}

- (void)testPrimaryThemeWithDefaultContainerScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [bottomNav applyPrimaryThemeWithScheme:[[MDCContainerScheme alloc] init]];

  // Then
  XCTAssertEqualObjects(bottomNav.barTintColor, containerScheme.colorScheme.primaryColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTintColor,
                        containerScheme.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTitleColor,
                        containerScheme.colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(
      bottomNav.unselectedItemTintColor,
      [containerScheme.colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedPrimaryAlpha]);
  XCTAssertTrue(
      [bottomNav.itemTitleFont mdc_isSimplyEqual:containerScheme.typographyScheme.caption],
      @"%@ is not equal to %@", bottomNav.itemTitleFont, containerScheme.typographyScheme.caption);
  XCTAssertEqual(bottomNav.elevation, MDCShadowElevationBottomNavigationBar);
  XCTAssertEqual(bottomNav.itemsContentVerticalMargin, 0);
}

- (void)testSurfaceThemeWithDefaultScheme {
  // Given
  MDCBottomNavigationBar *bottomNav = self.bottomNavigationBar;
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [bottomNav applySurfaceThemeWithScheme:[[MDCContainerScheme alloc] init]];

  // Then
  XCTAssertEqualObjects(bottomNav.barTintColor, containerScheme.colorScheme.surfaceColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTintColor,
                        containerScheme.colorScheme.primaryColor);
  XCTAssertEqualObjects(bottomNav.selectedItemTitleColor,
                        containerScheme.colorScheme.primaryColor);
  XCTAssertEqualObjects(
                        bottomNav.unselectedItemTintColor,
                        [containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedSurfaceAlpha]);
  XCTAssertTrue(
                [bottomNav.itemTitleFont mdc_isSimplyEqual:containerScheme.typographyScheme.caption],
                @"%@ is not equal to %@", bottomNav.itemTitleFont, containerScheme.typographyScheme.caption);
  XCTAssertEqual(bottomNav.elevation, MDCShadowElevationBottomNavigationBar);
  XCTAssertEqual(bottomNav.itemsContentVerticalMargin, 0);
}

@end
