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

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "MaterialTypographyScheme.h"

@interface MDCTypographySchemeTests : XCTestCase
@end

@implementation MDCTypographySchemeTests

- (void)testInitializer {
  // Given
  MDCTypographyScheme *latestScheme = [[MDCTypographyScheme alloc] init];
  MDCTypographyScheme *scheme201902 =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // Then
  XCTAssertEqual(latestScheme.headline1.pointSize, scheme201902.headline1.pointSize);
  XCTAssertEqual(latestScheme.headline2.pointSize, scheme201902.headline2.pointSize);
  XCTAssertEqual(latestScheme.headline3.pointSize, scheme201902.headline3.pointSize);
  XCTAssertEqual(latestScheme.headline4.pointSize, scheme201902.headline4.pointSize);
  XCTAssertEqual(latestScheme.headline5.pointSize, scheme201902.headline5.pointSize);
  XCTAssertEqual(latestScheme.headline6.pointSize, scheme201902.headline6.pointSize);
  XCTAssertEqual(latestScheme.subtitle1.pointSize, scheme201902.subtitle1.pointSize);
  XCTAssertEqual(latestScheme.subtitle2.pointSize, scheme201902.subtitle2.pointSize);
  XCTAssertEqual(latestScheme.body1.pointSize, scheme201902.body1.pointSize);
  XCTAssertEqual(latestScheme.body2.pointSize, scheme201902.body2.pointSize);
  XCTAssertEqual(latestScheme.caption.pointSize, scheme201902.caption.pointSize);
  XCTAssertEqual(latestScheme.button.pointSize, scheme201902.button.pointSize);
  XCTAssertEqual(latestScheme.overline.pointSize, scheme201902.overline.pointSize);
}

- (void)testTypographySchemeCopy {
  // Given
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];

  // When
  MDCTypographyScheme *typographySchemeCopy = [typographyScheme copy];

  // Then
  XCTAssertNotEqual(typographyScheme, typographySchemeCopy);
  XCTAssertEqualObjects(typographyScheme.headline1, typographySchemeCopy.headline1);
  XCTAssertEqualObjects(typographyScheme.headline2, typographySchemeCopy.headline2);
  XCTAssertEqualObjects(typographyScheme.headline3, typographySchemeCopy.headline3);
  XCTAssertEqualObjects(typographyScheme.headline4, typographySchemeCopy.headline4);
  XCTAssertEqualObjects(typographyScheme.headline5, typographySchemeCopy.headline5);
  XCTAssertEqualObjects(typographyScheme.headline6, typographySchemeCopy.headline6);
  XCTAssertEqualObjects(typographyScheme.subtitle1, typographySchemeCopy.subtitle1);
  XCTAssertEqualObjects(typographyScheme.subtitle2, typographySchemeCopy.subtitle2);
  XCTAssertEqualObjects(typographyScheme.body1, typographySchemeCopy.body1);
  XCTAssertEqualObjects(typographyScheme.body2, typographySchemeCopy.body2);
  XCTAssertEqualObjects(typographyScheme.caption, typographySchemeCopy.caption);
  XCTAssertEqualObjects(typographyScheme.button, typographySchemeCopy.button);
  XCTAssertEqualObjects(typographyScheme.overline, typographySchemeCopy.overline);
}

@end
