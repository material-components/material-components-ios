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
#import "MaterialTabs.h"
#import "MaterialTypography.h"

@interface MDCTabBarTests : XCTestCase

@end

@implementation MDCTabBarTests

- (void)testDefaultValues {
  // Given
  MDCTabBar *tabBar = [[MDCTabBar alloc] init];

  // Then
  XCTAssertNotNil(tabBar.selectionIndicatorTemplate);
  XCTAssertEqualObjects(tabBar.selectedItemTintColor, UIColor.whiteColor);
  XCTAssertEqualObjects(tabBar.unselectedItemTintColor,
                        [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  XCTAssertEqualObjects(tabBar.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.7]);
  XCTAssertNil(tabBar.barTintColor);
  XCTAssertTrue(tabBar.clipsToBounds);
  XCTAssertEqual(tabBar.barPosition, UIBarPositionAny);
  XCTAssertEqual(tabBar.alignment, MDCTabBarAlignmentLeading);
  XCTAssertEqual(tabBar.titleTextTransform, MDCTabBarTextTransformAutomatic);
  XCTAssertEqual(tabBar.itemAppearance, MDCTabBarItemAppearanceTitles);
  XCTAssertEqualObjects(tabBar.selectedItemTitleFont, [MDCTypography buttonFont]);
  XCTAssertEqualObjects(tabBar.unselectedItemTitleFont, [MDCTypography buttonFont]);
  XCTAssertNotNil(tabBar.items);
  XCTAssertEqual(tabBar.items.count, 0U);
  XCTAssertNil(tabBar.selectedItem);
  XCTAssertNil(tabBar.delegate);
  XCTAssertTrue(tabBar.displaysUppercaseTitles);
}

@end
