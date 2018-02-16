/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCColorUtility.h"

@interface MDCColorUtilityTests : XCTestCase

@end

@implementation MDCColorUtilityTests

- (void)testColorFromRGBA {
  // Given
  UIColor *expectedSolidRedColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
  UIColor *expectedSolidGreenColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
  UIColor *expectedSolidBlueColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
  CGFloat alpha = (CGFloat)(128.0/255.0);
  UIColor *expectedTransparentRedColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
  UIColor *expectedTransparentGreenColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:alpha];
  UIColor *expectedTransparentBlueColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:alpha];

  // When
  UIColor *solidRedColor = MDCColorFromRGBA(0xFF0000FF);
  UIColor *solidGreenColor = MDCColorFromRGBA(0x00FF00FF);
  UIColor *solidBlueColor = MDCColorFromRGBA(0x0000FFFF);
  UIColor *transparentRedColor = MDCColorFromRGBA(0xFF000080);
  UIColor *transparentGreenColor = MDCColorFromRGBA(0x00FF0080);
  UIColor *transparentBlueColor = MDCColorFromRGBA(0x0000FF80);

  // Then
  XCTAssertEqualObjects(solidRedColor, expectedSolidRedColor);
  XCTAssertEqualObjects(solidGreenColor, expectedSolidGreenColor);
  XCTAssertEqualObjects(solidBlueColor, expectedSolidBlueColor);
  XCTAssertEqualObjects(transparentRedColor, expectedTransparentRedColor);
  XCTAssertEqualObjects(transparentGreenColor, expectedTransparentGreenColor);
  XCTAssertEqualObjects(transparentBlueColor, expectedTransparentBlueColor);
}

- (void)testColorFromRGB {
  // Then
  XCTAssertEqualObjects(MDCColorFromRGB(0x123456), MDCColorFromRGBA(0x123456FF));
  XCTAssertEqualObjects(MDCColorFromRGB(0x101010), MDCColorFromRGBA(0x101010FF));
  XCTAssertEqualObjects(MDCColorFromRGB(0x000000), MDCColorFromRGBA(0x000000FF));
  XCTAssertEqualObjects(MDCColorFromRGB(0xFFFFFF), MDCColorFromRGBA(0xFFFFFFFF));
}

@end
