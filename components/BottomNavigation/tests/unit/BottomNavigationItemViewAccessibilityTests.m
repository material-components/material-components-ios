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

#import "../../src/private/MDCBottomNavigationItemView.h"

@interface BottomNavigationItemViewAccessibilityTests : XCTestCase

@end

@implementation BottomNavigationItemViewAccessibilityTests

- (void)testDefaultAccessiblityValue {
  // Given
  MDCBottomNavigationItemView *itemView = [[MDCBottomNavigationItemView alloc] init];

  // When
  itemView.badgeValue = @"777 apples";

  // Then
  XCTAssertEqualObjects(itemView.accessibilityValue, @"777 apples");
}

- (void)testDefaultAccessibilityValueUpdatesWhenBadgeValueChanges {
  // Given
  MDCBottomNavigationItemView *itemView = [[MDCBottomNavigationItemView alloc] init];

  // When
  itemView.badgeValue = @"777 apples";
  itemView.badgeValue = @"65 blueberries";

  // Then
  XCTAssertEqualObjects(itemView.accessibilityValue, @"65 blueberries");
}

- (void)testCustomAccessibilityValueOverridesDefault {
  // Given
  MDCBottomNavigationItemView *itemView = [[MDCBottomNavigationItemView alloc] init];

  // When
  itemView.badgeValue = @"777 apples";
  itemView.accessibilityValue = @"65 blueberries";

  // Then
  XCTAssertEqualObjects(itemView.accessibilityValue, @"65 blueberries");
}

- (void)testCustomAccessibilityValuePreventsBadgeValueFromOverriding {
  // Given
  MDCBottomNavigationItemView *itemView = [[MDCBottomNavigationItemView alloc] init];

  // When
  itemView.badgeValue = @"777 apples";
  itemView.accessibilityValue = @"65 blueberries";
  itemView.badgeValue = @"91 currants";

  // Then
  XCTAssertEqualObjects(itemView.accessibilityValue, @"65 blueberries");
}

@end
