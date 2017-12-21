/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

#import "../../src/private/MDCBottomNavigationItemBadge.h"

@interface BottomNavigationItemBadgeCodingTests : XCTestCase

@end

@implementation BottomNavigationItemBadgeCodingTests

- (void)testBasicCoding {
    // Given
  MDCBottomNavigationItemBadge *badge = [[MDCBottomNavigationItemBadge alloc] init];
  badge.badgeCircleWidth = 7;
  badge.badgeCircleHeight = 8;
  badge.xPadding = 9;
  badge.yPadding = 10;
  badge.badgeValue = @"value";
  badge.badgeColor = UIColor.orangeColor;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:badge];
  MDCBottomNavigationItemBadge *unarchivedBadge =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertEqualWithAccuracy(badge.badgeCircleWidth, unarchivedBadge.badgeCircleWidth, 0.001);
  XCTAssertEqualWithAccuracy(badge.badgeCircleHeight, unarchivedBadge.badgeCircleHeight, 0.001);
  XCTAssertEqualWithAccuracy(badge.xPadding, unarchivedBadge.xPadding, 0.001);
  XCTAssertEqualWithAccuracy(badge.yPadding, unarchivedBadge.yPadding, 0.001);
  XCTAssertEqualObjects(badge.badgeValue, unarchivedBadge.badgeValue);
  XCTAssertEqualObjects(badge.badgeColor, unarchivedBadge.badgeColor);
  XCTAssertEqualObjects(badge.badgeValueLabel.text, unarchivedBadge.badgeValueLabel.text);
}

- (void)testMultipleEncodingsKeepSubviewsEqual {
  // Given
  MDCBottomNavigationItemBadge *badge = [[MDCBottomNavigationItemBadge alloc] init];

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:badge];
  MDCBottomNavigationItemBadge *unarchivedBadge =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  for (int i = 0; i < 3; ++i) {
    archive = [NSKeyedArchiver archivedDataWithRootObject:unarchivedBadge];
    unarchivedBadge = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  }

  // Then
  XCTAssertEqual(badge.subviews.count, unarchivedBadge.subviews.count);
}

@end
